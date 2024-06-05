function [max_feature,min_feature] = feature_MaxMin(featureMat,sbjCount)
min_feature = 10^10;
max_feature = -10^10;
for i = 1:sbjCount     
    sbj_feature = featureMat(i,:);     
    if min(sbj_feature) < min_feature 
        min_feature = min(sbj_feature);
    end
    if max(sbj_feature) > max_feature && max(sbj_feature)<1000
        max_feature = max(sbj_feature);
    end            
end