fold =10;
st = '/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/Convex_Relaxation/SRS_Aut_CV';

load(strcat(st,'/data_',num2str(fold),'.mat'))

str1 = strcat(st,'/workspace_',num2str(net),'_net_',num2str(fold),'_fold_',num2str(lambda_2),'_regC_');
fin =str1;
load(strcat(str1,'.mat'))

str3  = strcat(fin,'_cross_test',num2str(fold),'.mat');

for i = 1:size(B_gd,2)

    C_gd_test{i}= quad_estimate_C_old(B_cont{2},lambda_2,corr_test{i});
    C_gd_train{i}= quad_estimate_C_old(B_cont{2},lambda_2,corr_train{i});
%     C_gd_test{i}= quad_estimate_C_avg(B_gd{i},lambda_2,corr_test{i},B_avg_gd{i});
%     C_gd_train{i}= quad_estimate_C_avg(B_gd{i},lambda_2,corr_train{i},B_avg_gd{i});
%     
    Y_obt_test{i} = C_gd_test{i}'*W_gd{i};
    Y_obt_train{i} = C_gd{i}'*W_gd{i};
    Y_est_train{i} = C_gd_train{i}'*W_gd{i};
    
    error_test(i) = sqrt(sum((Y_obt_test{i}(:)-Y_test{i}(:)).^2)/numel(Y_test{i}));
    error_train(i) = sqrt(sum((Y_obt_train{i}(:)-Y_train{i}(:)).^2)/numel(Y_train{i}));
    error_train_est(i) = sqrt(sum((Y_est_train{i}(:)-Y_train{i}(:)).^2)/numel(Y_train{i}));
    
end

clear fin fni
save(str3,'C_gd_train','C_gd_test','Y_obt_train','Y_obt_test','Y_est_train','error_test','error_train','error_train_est' ...
,'B_gd','C_gd','D_gd','lamb_gd','Y_test','Y_train','W_gd')
