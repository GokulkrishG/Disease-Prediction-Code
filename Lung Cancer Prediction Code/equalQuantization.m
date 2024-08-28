function [ROIonlyEqual,levels] = equalQuantization(ROIonly,Ng)
ROIonly = double(ROIonly);
ROIonly = (ROIonly - min(ROIonly(:)))./(max(ROIonly(:)) - min(ROIonly(:)));
qmax = max(ROIonly(:));
qmin = min(ROIonly(:));
ROIonly(isnan(ROIonly)) = qmax + 1;

[b,perm] = sort(reshape(ROIonly,[1 size(ROIonly,1)*size(ROIonly,2)*size(ROIonly,3)]));

ind = find(b<=1);
d = b(ind);


J = histeq(d,Ng);

b(ind(1:end)) = J(1:end);
ROIonlyEqual = zeros(1,size(ROIonly,1)*size(ROIonly,2)*size(ROIonly,3));
ROIonlyEqual(perm(1:end)) = b(1:end);

ROIonlyEqual = reshape(ROIonlyEqual,[size(ROIonly,1),size(ROIonly,2),size(ROIonly,3)]);
ROIonlyEqual(ROIonly==2) = NaN;

levels = unique(J);
volumeTemp = ROIonlyEqual;
for i=1:numel(levels)
    ROIonlyEqual(volumeTemp==levels(i)) = i;
end

levels = 1:Ng;

end