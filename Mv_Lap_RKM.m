function [pre , score] = Mv_Lap_RKM(train , test , label , gamma_list, eta , lammda , sita )
%MV_RKM 多视角 受限核机
%   解决二分类问题，label为-1或1
%   eta正则项超参
%   lammda隐藏层超参
%Multi-View Least Squares Support Vector Machines Classificatio-formula(13)
label = double(label);
[~,V] = size(train);
[N,~] = size(train{1});
[N_t,~] = size(test{1});

K_sum = zeros(N,N);
L_list = cell(V,1);%图正则化矩阵集合
for i=1:V
   k = RBF_kernel(train{i} , gamma_list(i)); 
   K_sum = K_sum + k;
   L_list{i} = k_HyperLapGraph( k ,20 );
end

V_N = V.*ones(N,1);

II_N = eye(N,N);

Vy = V.*label;

One_N = ones(N,1);

%初始化图的权重
weights = ones(V,1)/V;
L = zeros(N,N);
for i=1:V
    L = L + weights(i)*L_list{i};
end
%A*B=C
A = [ (1/eta).*K_sum+lammda.*II_N-sita.*L , V_N ; One_N' , 0 ];
C = [ Vy ; 0 ];
B = inv(A)*C;

h = B(1:N)./label;%hidden
b = B(end);%bias
    
%predict
re = zeros(N_t,1);
for i=1:V
    k_test = RBF_kernel_test(train{i},test{i},gamma_list(i));
    re = re + (k_test'*(label.*h))+b;
end
score = (re./V)./eta;
pre = sign(score);
end

