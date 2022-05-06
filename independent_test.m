clear;

load('PDB186_feature.mat')
load('PDB1075_feature.mat')
load('\mRMR\feature_select.mat')


label = label_1075;
test_label = label_186;

% PDB1075多视角
train = {MCD_1075,NMBAC_1075(:,nmbac175),PSSM_AB_1075(:,ab175),PSSM_DWT_1075(:,dwt520),PSSM_Pse_1075};
test = {MCD_186,NMBAC_186(:,nmbac175),PSSM_AB_186(:,ab175),PSSM_DWT_186(:,dwt520),PSSM_Pse_186};

gamma_list = [0.03125,0.125,1,0.125,0.125];
V = 5;

[n,~] = size(label);
for i = 1:V
    tt = [train{i}' test{i}']';
    tt = Moreau_brota( tt );
    train{i} = tt(1:n,:);
    test{i} = tt(n+1:end,:);
end

% 多视角 Lap_RKM 独立测试集
eta = 2;
lammda = 1;
sita = 0.125;
[pre , score] = Mv_Lap_RKM(train , test , label , gamma_list, eta , lammda , sita );
[ acc,sn,spec,mcc ] = MCC( test_label , pre )
