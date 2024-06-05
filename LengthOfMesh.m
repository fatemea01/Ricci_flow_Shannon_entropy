function L = LengthOfMesh(Connct_List,Points)
disp('calculate Length of Mesh....');
point_cnt = size(Points,1);
tri_cnt = size(Connct_List,1);
L = sparse(point_cnt,point_cnt);

%--------------------compute the length of edge in triangulars------------%
for i = 1:tri_cnt
%     fprintf('\nAlgorithm 1 - L %d ',i);
    for j = 1:2
        p = Connct_List(i,j);
        for k = j+1:3
            q = Connct_List(i,k);
            L(p,q) = sum((Points(p,:)-Points(q,:)).^2)^0.5;
            L(q,p) = L(p,q);
        end
    end
end