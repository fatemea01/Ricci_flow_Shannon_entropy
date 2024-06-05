function [E,pi] = Entropy(sbj_feature,edges)
E = 0;
h = histogram(sbj_feature,edges);
% h.FaceColor = [0 0.5 0.5];
% saveas(gcf,sprintf('H_%d.png',n));
point_cnt = size(sbj_feature,2);
step_start = edges(1);

for i=1:size(edges,2)    
    step_end = step_start + h.BinWidth;
    pi(i) = K_count(sbj_feature, step_start, step_end);
    pi(i) = pi(i)/point_cnt;     
    if pi(i)    
        E = E + pi(i)*log2(pi(i)); 
    end
    step_start = step_end;
end
sumpi = sum(pi);
E = -E;
end