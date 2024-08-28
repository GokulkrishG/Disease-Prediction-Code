function oneglrlm = rle_0(si,NL)
[m,n]=size(si);
oneglrlm=zeros(NL,n);
for i=1:m
    x=si(i,:);
    
    index = [ find(x(1:end-1) ~= x(2:end)), length(x) ];
    len = diff([ 0 index ]); 
    val = x(index);          
    temp =accumarray([val;len]',1,[NL n]);
    oneglrlm = temp + oneglrlm; 
end