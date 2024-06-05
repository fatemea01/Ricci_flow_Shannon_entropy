function A = AreaOfTri(l1,l2,l3)  
    s = (l1+l2+l3)/2;    
    A = sqrt(s*(s-l1)*(s-l2)*(s-l3));
end