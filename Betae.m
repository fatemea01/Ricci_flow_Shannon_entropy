function B = Betae(v1,v2,Connct_List,FN)
    [ri,ci] = find(Connct_List==v1);
    [rj,cj] = find(Connct_List==v2);
    a = ismember(ri,rj);
    idx = find(a==1);
    B = 0;
    if size(idx,1) > 1
        tri1 = Connct_List(ri(idx(1)),:);
        tri2 = Connct_List(ri(idx(2)),:);
        tri1_id = ri(idx(1));
        tri2_id = ri(idx(2));
        N1 = FN(tri1_id,:);
        N2 = FN(tri2_id,:);
        B = acos(dot(N1,N2)/norm(N1)*norm(N2));   
    end
end
