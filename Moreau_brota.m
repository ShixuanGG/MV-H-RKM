function [ out ] =Moreau_brota( in )
% in 输入的数据集
% out 归一化后的数据 
% 最值归一化
min1 = min( in );
max1 = max( in );
out = ( in - min1 )./(max1-min1);
end