function [misclass1, acc1]=SVM1(A)
    
    [m, n]=size(A);
    data1=A(:,1:end-1);
    cls=A(:,end);
    t = templateSVM('Standardize',true,'KernelFunction','gaussian');
    cl=fitcecoc(data1,cls,'Learners',t,'FitPosterior',true,...
    'ClassNames',[0,1,2,3],...
    'Verbose',2);

    
    
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