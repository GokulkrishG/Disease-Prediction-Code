clc;

load Feat1;
load Feat2;
load Feat3;
load Feat4;


[filename, pathname] = uigetfile('*.png','LOAD AN TEST IMAGE');
orgImg=imread(fullfile(pathname, filename));


figure(1)
imshow(orgImg);
title('Input Image');

I1=orgImg;

[eq,levels]=equalQuantization(I1,64);
figure(2)
imshow(uint8(eq));
title('Quantization');

I=rgb2gray(orgImg);

glcms = graycomatrix(I); 

glcmft=GLCMFeatures(glcms);
    
gl=grayrlmatrix(I);

glrlm=GLRLMFeatures(gl);

    
globalft=GlobalFeatures(glcms,8);
    
qft=[glcmft glrlm(1,:) globalft];
disp('Features');
qft


k=1;
for i=1:length(Feat1)
    in(k,:)=Feat1{i,1};
    k=k+1;
end

for i=1:length(Feat2)
    in(k,:)=Feat2{i,1};
    k=k+1;
end

for i=1:length(Feat3)
    in(k,:)=Feat3{i,1};
    k=k+1;
end

for i=1:length(Feat4)
    in(k,:)=Feat4{i,1};
    k=k+1;
end


size(in)

%writematrix(in,'M.csv') 
csvwrite('M.csv',in);

[misclass1, acc1,pre]=DS1(in,qft);
if(pre==0)
    f = msgbox('Normal','Predicted Result');
elseif(pre==1)
    f = msgbox('Adenocarcinoma','Predicted Result');
elseif (pre==2)
    f = msgbox('Large cell carcinoma','Predicted Result');
else
    f = msgbox('Squamous cell carcinoma','Predicted Result');
end
[misclass2, acc2]=SVM1(in);
[misclass3, acc3]=KNN1(in);

figure(3)
y1=[acc1 acc2 acc3];
gr1=bar(y1);
title('Performance - Accuracy');
Labels={'DS','SVM','KNN'};
set(gca, 'XTick', 1:4, 'XTickLabel', Labels);
set(gr1, 'FaceColor','m');
ylabel('Value');


figure(4)
y2=[misclass1 misclass2 misclass3];
gr2=bar(y2);
title('Performance - Error Rate');
Labels={'DS','SVM','KNN'};
set(gca, 'XTick', 1:4, 'XTickLabel', Labels);
set(gr2, 'FaceColor','c');
ylabel('Value');


