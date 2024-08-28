function [res1] = GLCMFeatures(glcm)
if ((nargin > 1) || (nargin == 0))
    error('Too many or too few input arguments')
else
    if ((size(glcm,1) <= 1) || (size(glcm,2) <= 1))
        error('The GLCM should be a 2-D or 3-D matrix.');
    elseif ( size(glcm,1) ~= size(glcm,2) )
        error('Each GLCM should be square with NumLevels rows and NumLevels cols');
    end  
end

glcm = bsxfun(@rdivide,glcm,sum(sum(glcm)));

nGrayLevels = size(glcm,1);
nglcm = size(glcm,3);

out.autoCorrelation                     = zeros(1,nglcm); 
out.clusterProminence                   = zeros(1,nglcm); 
out.clusterShade                        = zeros(1,nglcm); 
out.contrast                            = zeros(1,nglcm); 
out.correlation                         = zeros(1,nglcm); 
out.differenceEntropy                   = zeros(1,nglcm); 
out.differenceVariance                  = zeros(1,nglcm); 
out.dissimilarity                       = zeros(1,nglcm); 
out.energy                              = zeros(1,nglcm); 
out.entropy                             = zeros(1,nglcm);
out.homogeneity                         = zeros(1,nglcm);
out.informationMeasureOfCorrelation1    = zeros(1,nglcm);
out.informationMeasureOfCorrelation2    = zeros(1,nglcm);
out.inverseDifference                   = zeros(1,nglcm);
out.maximumProbability                  = zeros(1,nglcm); 
out.sumAverage                          = zeros(1,nglcm); 
out.sumEntropy                          = zeros(1,nglcm); 
out.sumOfSquaresVariance                = zeros(1,nglcm); 
out.sumVariance                         = zeros(1,nglcm); 
glcmMean = zeros(nglcm,1);
uX = zeros(nglcm,1);
uY = zeros(nglcm,1);
sX = zeros(nglcm,1);
sY = zeros(nglcm,1);

pX = zeros(nGrayLevels,nglcm); 
pY = zeros(nGrayLevels,nglcm); 
pXplusY = zeros((nGrayLevels*2 - 1),nglcm); 
pXminusY = zeros((nGrayLevels),nglcm); 

HXY1 = zeros(nglcm,1);
HX   = zeros(nglcm,1);
HY   = zeros(nglcm,1);
HXY2 = zeros(nglcm,1);

sub   = 1:nGrayLevels*nGrayLevels;
[I,J] = ind2sub([nGrayLevels,nGrayLevels],sub);

for k = 1:nglcm 
    currentGLCM = glcm(:,:,k);
    glcmMean(k) = mean2(currentGLCM);
    

    uX(k)   = sum(I.*currentGLCM(sub));
    uY(k)   = sum(J.*currentGLCM(sub));
    sX(k)   = sum((I-uX(k)).^2.*currentGLCM(sub));
    sY(k)   = sum((J-uY(k)).^2.*currentGLCM(sub));
    out.contrast(k)             = sum(abs(I-J).^2.*currentGLCM(sub)); %OK
    out.dissimilarity(k)        = sum(abs(I - J).*currentGLCM(sub)); %OK
    out.energy(k)               = sum(currentGLCM(sub).^2); % OK
    out.entropy(k)              = -nansum(currentGLCM(sub).*log(currentGLCM(sub))); %OK
    out.inverseDifference(k)    = sum(currentGLCM(sub)./( 1 + abs(I-J) )); %OK
    out.homogeneity(k)          = sum(currentGLCM(sub)./( 1 + (I - J).^2)); %OK
    
    out.sumOfSquaresVariance(k) = sum(currentGLCM(sub).*((I - uX(k)).^2));
    out.maximumProbability(k)   = max(currentGLCM(:));
    
    pX(:,k) = sum(currentGLCM,2); %OK
    pY(:,k) = sum(currentGLCM,1)'; %OK
    
    tmp1 = [(I+J)' currentGLCM(sub)'];
    tmp2 = [abs((I-J))' currentGLCM(sub)'];
    idx1 = 2:2*nGrayLevels;
    idx2 = 0:nGrayLevels-1;
    for i = idx1
        pXplusY(i-1,k) = sum(tmp1(tmp1(:,1)==i,2));
    end
    
    for i = idx2 
        pXminusY(i+1,k) = sum(tmp2(tmp2(:,1)==i,2));
    end
   
    out.sumAverage              = sum(bsxfun(@times,idx1',pXplusY));
    out.sumEntropy              = -nansum(pXplusY.*log(pXplusY)); %OK
    out.differenceEntropy       = -nansum(pXminusY.*log(pXminusY)); %OK
    out.differenceVariance(k)   = sum((idx2-out.dissimilarity(k)).^2'.*pXminusY(idx2+1,k)); 
    out.sumVariance(k)          = sum((idx1-out.sumAverage(k))'.^2.*pXplusY(idx1-1,k)); 
    
    HXY1(k)                     = -nansum(currentGLCM(sub)'.*log(pX(I,k).*pY(J,k))); %OK
    HXY2(k)                     = -nansum(pX(I,k).*pY(J,k).*log(pX(I,k).*pY(J,k))); %OK
    HX(k)                       = -nansum(pX(:,k).*log(pX(:,k))); %OK
    HY(k)                       = -nansum(pY(:,k).*log(pY(:,k))); %OK
    
    out.autoCorrelation(k)      = sum(I.*J.*currentGLCM(sub));
    out.clusterProminence(k)    = sum((I+J-uX(k)-uY(k)).^4.*currentGLCM(sub)); %OK
    out.clusterShade(k)         = sum((I+J-uX(k)-uY(k)).^3.*currentGLCM(sub)); %OK
    out.correlation(k)          = (out.autoCorrelation(k) - uX(k).*uY(k))./(sqrt(sX(k).*sY(k))); %OK
    
    out.informationMeasureOfCorrelation1(k) = (out.entropy(k)-HXY1(k))./(max(HX(k),HY(k))); %OK
    out.informationMeasureOfCorrelation2(k) = (1 - exp(-2.*(HXY2(k)-out.entropy(k))) ).^(1/2); %OK
    
end

ac=out.autoCorrelation;                     
cp=out.clusterProminence;                   
cs=out.clusterShade;               
ct=out.contrast;                            
cc=out.correlation;                         
de=out.differenceEntropy;                   
dv=out.differenceVariance;                  
ds=out.dissimilarity;                       
ey=out.energy;                              
et=out.entropy;                             
hg=out.homogeneity;                         
imc1=out.informationMeasureOfCorrelation1;    
imc2=out.informationMeasureOfCorrelation2;    
id=out.inverseDifference;                   
mp=out.maximumProbability ;                 
sa=out.sumAverage;                          
se=out.sumEntropy;                          
ssv=out.sumOfSquaresVariance;                
sv=out.sumVariance ; 

res1=[ac cp cs ct cc de dv ds ey et hg imc1 imc2 id mp sa se ssv sv];
