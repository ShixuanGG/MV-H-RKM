function [ out ] =Moreau_brota( in )
% in ��������ݼ�
% out ��һ��������� 
% ��ֵ��һ��
min1 = min( in );
max1 = max( in );
out = ( in - min1 )./(max1-min1);
end