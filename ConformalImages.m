function [lamda,H] = ConformalImages(Connct_List,Points,L,L_ini)
TR = triangulation(Connct_List,Points);
FN = faceNormal(TR);
tri_cnt = size(Connct_List,1);
point_cnt = size(Points,1);
E = edges(TR);
edge_cnt = size(E,1);
% [L_ini,AA] = mesh_length(Connct_List,Points);
for p=1:point_cnt
    sum = 0;
    area = 0;
    suma = 0;
    [RowNo,ColNo] = find(Connct_List==p);
    Ball_tri(p,1:size(RowNo,1)) = RowNo;
    Ball_tri_cnt = size(RowNo,1); 
    ee = zeros(1,Ball_tri_cnt);
    j=1;
    for i=1:Ball_tri_cnt
        Tri = Connct_List(RowNo(i),:);
        [Li,Loc] = ismember(p,Tri);
        %---------------- col = locations of Tri that are not p --------%
        [row,col] = find(Loc~=[1,2,3]);
        v1 = p;
        v2 = Tri(col(1));
        v3 = Tri(col(2));
        [Li1,Loc1] = ismember(L(v1,v2),ee);
        if ~Li1
            ee(j) = L(v1,v2);
            j = j+1;
        end
        [Li2,Loc2] = ismember(L(v1,v3),ee);
        if ~Li2
            ee(j) = L(v1,v3);
            j = j+1;
        end
        Beta_v1v2 = Betae(v1,v2,Connct_List,FN);
        Beta_v1v3 = Betae(v1,v3,Connct_List,FN);
        sum = sum + L(v1,v2)*Beta_v1v2+L(v1,v3)*Beta_v1v3;
%         area = area + AreaOfTri(L(v1,v2),L(v1,v3),L(v2,v3));
        suma = suma + (log(AreaOfTri(L(v1,v2),L(v1,v3),L(v2,v3)))-log(AreaOfTri(L_ini(v1,v2),L_ini(v1,v3),L_ini(v2,v3))))/2;
    end
    minV = min(ee);
    area = 4*pi*minV*minV;
    H(p) = sum/area;
    lamda(p) = suma;
end

end