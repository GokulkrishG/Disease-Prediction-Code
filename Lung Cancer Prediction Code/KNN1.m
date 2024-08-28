function [misclass1, acc1]=KNN1(A)
    
    [m, n]=size(A);
    data1=A(:,1:end-1);
    cls=A(:,end);
    cl=fitcknn(data1,cls,...
        'classNames',[0,1,2,3]);
    
    %CVMdl1 = crossval(cl,'leaveout','on');
    CVMdl1 = crossval(cl);
    yfit = kfoldPredict(CVMdl1);
    
    misclass1 = (kfoldLoss(CVMdl1))*100;
    
    [k1,k2]=size(yfit);
    cr=0;
    for i=1:k1
        if(yfit(i,1)==cl.Y(i,1))
            cr=cr+1;   
        end
    end
    acc1=(cr/m)*100;
    
    
end