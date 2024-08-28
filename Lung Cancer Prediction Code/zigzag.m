function seq = zigzag(SI)
c = 1; 
r = 1; 
rmin = 1; 
cmin = 1; 
rmax = size(SI, 1);
cmax = size(SI, 2);
%
i = 1; 
j = 1; 

sq_up_begin=1;
sq_down_begin=1;
output = zeros(1, rmax * cmax);
while ((r <= rmax) && (c <= cmax))
    if (mod(c + r, 2) == 0)      
        
        if (r == rmin)
            
            output(i) = SI(r, c);
            
            if (c == cmax)
                
                r   = r + 1;
                sq_up_end = i;
                sq_down_begin = i+1;
                seq{j}=output(sq_up_begin:sq_up_end);
                j = j + 1;
                
            else
                
                c = c + 1;
                sq_up_end = i;
                sq_down_begin = i+1;
                seq{j}=output(sq_up_begin:sq_up_end);
                j = j + 1;
            end;
            
            i = i + 1;
            
        elseif ((c == cmax) && (r < rmax))
            
            output(i) = SI(r, c);
            
            r = r + 1;
            
            sq_up_end = i;
            seq{j}=output(sq_up_begin:sq_up_end);
            sq_down_begin =i+1;
            j=j+1;
                        
            
            i = i + 1;
            
        elseif ((r > rmin) && (c < cmax))
            output(i) = SI(r, c);
            
            r = r - 1;
            c = c + 1;
            
            i = i + 1;
        end;
    
    else
    
        if ((r == rmax) && (c <= cmax))
            
            output(i) = SI(r, c);
            
            c = c + 1;
            sq_down_end = i;
            seq{j}=output(sq_down_begin:sq_down_end);
            sq_up_begin =i+1;
            j = j + 1;
            
            i = i + 1;
            
        elseif (c == cmin)
            
            output(i) = SI(r, c);
            
            if (r == rmax)
                c = c + 1;
                
                sq_down_end = i;
                seq{j}=output(sq_down_begin:sq_down_end);
                sq_up_begin =i+1;
                j = j + 1;
            else
                r = r + 1;
                
                sq_down_end = i;
                seq{j}=output(sq_down_begin:sq_down_end);
                sq_up_begin =i+1;
                j = j + 1;
            end;
            i = i + 1;
            
        elseif ((r < rmax) && (c > cmin))
            %
            output(i) = SI(r, c);
            
            r = r + 1;
            c = c - 1;
            
            i = i + 1;
        end;
    end;
    if ((r == rmax) && (c == cmax))         
        output(i) = SI(r, c);
        sq_end = i;
        seq{j}=output(sq_end);
        
        break
    end;
end;