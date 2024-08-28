function  Feat = FeatureExtract(orgImg,cls)     
    I=rgb2gray(orgImg);
    
    glcms = graycomatrix(I); 
    glcmft=GLCMFeatures(glcms);
    
    gl=grayrlmatrix(I);
    glrlm=GLRLMFeatures(gl);
    
    globalft=GlobalFeatures(glcms,8);
    
    
    Feat=[glcmft glrlm(1,:) globalft cls];

end