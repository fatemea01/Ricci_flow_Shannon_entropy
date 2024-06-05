clc
clear
sbjCount = 80;
for i = 1:sbjCount           
    load (['CN-LH-Results-Converge-Struct-match\\Converge_',num2str(i),'.mat']); 
    Connct_List = Converge.Connct_List;        
    Points = Converge.Points;
    L = Converge.L;
    point_cnt(i) = size(Points,1);
    U_cn(i,1:point_cnt(i)) = Converge.U;
    L_ini = LengthOfMesh(Connct_List,Points);
    [lamda_cn(i,1:point_cnt(i)),H_cn(i,1:point_cnt(i))] = ConformalImages(Connct_List,Points,L,L_ini);            
end
%--------------------------------------find minimum and maximum of lamda and H---------------------------%
[max_H,min_H] = feature_MaxMin(H_cn,sbjCount);
[max_lamda,min_lamda] = feature_MaxMin(lamda_cn,sbjCount);
[max_U,min_U] = feature_MaxMin(U_cn,sbjCount);

%-------------------------------------------------compute entropy of H------------------------%
k = 0;
max_H = 6;
min_H = 0;
for st = 0.05:0.05:2 %2:2:10
    k = k+1;
    for i = 1:sbjCount      
        H_edges = min_H:st:max_H;
        CN_Entropy_H(i,k) = Entropy(H_cn(i,1:point_cnt(i)),H_edges);            
    end
end
CN_Feature1 = CN_Entropy_H;
%-------------------------------------------------compute entropy of lamda -----------------------------%
k = 0;
min_lamda = -10;
max_lamda = 10;
for st = 0.2:0.3:5 %5:5:20
    k = k+1;
    for i = 1:sbjCount              
        lamda_edges = min_lamda:st:max_lamda;
        CN_Entropy_lamda(i,k) = Entropy(lamda_cn(i,1:point_cnt(i)),lamda_edges);  
    end
end
CN_Feature2 = CN_Entropy_lamda;

%-------------------------------------------------compute entropy of U---------------------------------%
k = 0;
for st = 0.5:0.2:5
    k = k+1;
    for i = 1:sbjCount             
        U_edges = min_U-5:st:max_U+5;
        CN_Entropy_U(i,k) = Entropy(U_cn(i,1:point_cnt(i)),U_edges);     
    end
end
CN_Feature3 = CN_Entropy_U;

%---------------------------------------------------------------------------------------------------------%
for i = 1:sbjCount        
    load (['AD-LH-Results-Converge-Struct-match\\Converge_',num2str(i),'.mat']); 
    Connct_List = Converge.Connct_List;
    Points = Converge.Points;
    L = Converge.L;
    point_cnt(i) = size(Points,1);
    U_ad(i,1:point_cnt(i)) = Converge.U;
    L_ini = LengthOfMesh(Connct_List,Points);
    [lamda_ad(i,1:point_cnt(i)),H_ad(i,1:point_cnt(i))] = ConformalImages(Connct_List,Points,L,L_ini);           
end

%--------------------------------------find minimum and maximum of lamda and H---------------------------%
[max_H,min_H] = feature_MaxMin(H_ad,sbjCount);
[max_lamda,min_lamda] = feature_MaxMin(lamda_ad,sbjCount);
[max_U,min_U] = feature_MaxMin(U_ad,sbjCount);

%-------------------------------------------------compute entropy of H------------------------%
k = 0;
max_H = 6;
min_H = 0;
for st = 0.05:0.05:2 %2:2:10
    k = k+1;
    for i = 1:sbjCount      
        H_edges = min_H:st:max_H; %min_H-5:st:max_H+5;
        AD_Entropy_H(i,k) = Entropy(H_ad(i,1:point_cnt(i)),H_edges);           
    end
end
AD_Feature1 = AD_Entropy_H;
%-------------------------------------------------compute entropy of lamda ------------------------%
k = 0;
min_lamda = -10;
max_lamda = 10;
for st =  0.2:0.3:5 %5:5:20
    k = k+1;
    for i = 1:sbjCount             
        lamda_edges = min_lamda:st:max_lamda;
        AD_Entropy_lamda(i,k) = Entropy(lamda_ad(i,1:point_cnt(i)),lamda_edges);     
    end
end
AD_Feature2 = AD_Entropy_lamda;

%-------------------------------------------------compute entropy of U------------------------%
k = 0;
for st = 0.5:0.2:5
    k = k+1;
    for i = 1:sbjCount         
        U_edges = min_U-5:st:max_U+5;
        AD_Entropy_U(i,k) = Entropy(U_ad(i,1:point_cnt(i)),U_edges);     
    end
end
AD_Feature3 = AD_Entropy_U;

LH_FeatureMat1 = [AD_Feature1;CN_Feature1];
LH_FeatureMat2 = [AD_Feature2;CN_Feature2];
LH_FeatureMat3 = [AD_Feature3;CN_Feature3];

col1 = size(AD_Feature1,2);
LH_FeatureMat1(1:sbjCount,col1+1) = 1;
LH_FeatureMat1(sbjCount+1:sbjCount*2,col1+1) = 2;

col2 = size(AD_Feature2,2);
LH_FeatureMat2(1:sbjCount,col2+1) = 1;
LH_FeatureMat2(sbjCount+1:sbjCount*2,col2+1) = 2;

col3 = size(AD_Feature3,2);
LH_FeatureMat3(1:sbjCount,col3+1) = 1;
LH_FeatureMat3(sbjCount+1:sbjCount*2,col3+1) = 2;

% save('LH_Features3.mat','LH_FeatureMat1','LH_FeatureMat2','LH_FeatureMat3');
