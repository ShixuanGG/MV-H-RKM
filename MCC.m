function [ acc,sn,spec,mcc ] = MCC( label , pre )
%MCC label 真实标签
%   pre 预测结果
[len,~] = size( label );
posi_index = find( label==1 );
nega_index = find( label==-1 );

[posi_num,~] = size( posi_index );
[nega_num,~] = size( posi_index );

[tp,~] = size( find( label(posi_index)==pre(posi_index) ) );
[tn,~] = size( find( label(nega_index)==pre(nega_index) ) );

[pre_pos_num,~] = size( find( pre==1 ) );
[nega_pos_num,~] = size( find( pre==-1 ) );

fp = pre_pos_num-tp;
fn = nega_pos_num-tn;

acc = (tp+tn)/(tp+fp+tn+fn);
sn = tp / (tp+fn);
spec = tn/(tn+fp);
mcc = (tp*tn - fp*fn)/ sqrt( (tp+fn)*(tn+fp)*(tp+fp)*(tn+fn));

end

