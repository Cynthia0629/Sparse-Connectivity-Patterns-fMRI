%% Testing

fold =10;

st = '/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/Convex_Relaxation/Praxis_Aut/Avg_Errs/';

% load(strcat(st,'/data_out_',num2str(fold),'.mat'))

str1 = strcat(st,'/workspace_out_',num2str(net),'_net_',num2str(fold),'_fold_',num2str(lambda_1),'_sparsity_'...
    ,num2str(lambda_2),'_regC_',num2str(lambda_3),'_regW_',num2str(lambda),'_trad');
fin =str1;
load(strcat(str1,'.mat'))
str3  = strcat(str2,'_test',num2str(fold),'.mat');

for i = 1:size(B_gd,2)

    C_gd_test{i}= quad_estimate_C_avg(B_gd{i},lambda_2,corr_test{i},B_avg_gd{i});
    C_gd_train{i}= quad_estimate_C_avg(B_gd{i},lambda_2,corr_train{i},B_avg_gd{i});
 
     Y_obt_train{i} = (C_gd{i})'*W_gd{i};
     Y_est_train{i} = (C_gd_train{i})'*W_gd{i};
     Y_obt_test{i} = (C_gd_test{i})'*W_gd{i};
     
%    offs =-20;
%      Y_obt_train{i} = (Y_obt_train{i})*(1/scale)-offs;
%      Y_train{i} = (Y_train{i})*(1/scale)-offs;
%      Y_est_train{i} = (Y_est_train{i})*(1/scale) -offs;
%      Y_obt_test{i} = (Y_obt_test{i})*(1/scale) -offs;
     
    error_test(i) = sqrt(sum((Y_obt_test{i}(:)-Y_test{i}(:)).^2)/numel(Y_test{i}));
    error_train(i) = sqrt(sum((Y_obt_train{i}(:)-Y_train{i}(:)).^2)/numel(Y_train{i}));
    error_train_est(i) = sqrt(sum((Y_est_train{i}(:)-Y_train{i}(:)).^2)/numel(Y_train{i}));
    
end

clear fin fni
filename = strcat(str3);
save(filename,'C_gd_train','C_gd_test','Y_est_train','Y_obt_train','Y_obt_test','error_test','error_train','error_train_est' ...
,'B_gd','C_gd','Y_test','Y_train','W_gd','B_avg_gd')
% str3  = strcat(str2,'_test',num2str(fold),'.mat');
% save(str3,'C_gd_train','C_gd_test','Y_est_train','Y_obt_test','error_test','error_train','error_train_est' ...
% ,'B_gd','C_gd','D_gd','lamb_gd','Y_test','Y_train','W_gd')

% save(str3)