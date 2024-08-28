function [res3] = GlobalFeatures(ROIonly,Nbins)
vectorValid = ROIonly(~isnan(ROIonly));
histo = hist(vectorValid,Nbins);
histo = histo./(sum(histo(:)));
vectNg = 1:Nbins;
u = histo*vectNg';



variance = 0;
for i=1:Nbins
    variance = variance+histo(i)*(i-u)^2;
end
sigma = sqrt(variance);
textures.Variance = variance;


skewness = 0;
for i = 1:Nbins
    skewness = skewness+histo(i)*(i-u)^3;
end
skewness = skewness/sigma^3;
textures.Skewness = skewness;


kurtosis = 0;
for i = 1:Nbins
    kurtosis = kurtosis+histo(i)*(i-u)^4;
end
kurtosis = (kurtosis/sigma^4) - 3;
textures.Kurtosis = kurtosis;

va=textures.Variance;
sk=textures.Skewness;
ku=textures.Kurtosis;

res3=[va sk ku];

end

