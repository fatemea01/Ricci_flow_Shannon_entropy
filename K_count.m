function c = K_count(K, step_start, step_end)
len = size(K,2);  
c = 0;
for i=1:len
    if K(i)>=step_start && K(i)<step_end
        c = c+1;
    end
end
end