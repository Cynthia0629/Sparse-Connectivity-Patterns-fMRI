%% Testing
fold =10;
st = '/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/Intersession_Experiments/Convergence_Criteria/SRS_Aut_CV';

load(strcat(st,'/data_',num2str(fold),'.mat'))

str1 = strcat(st,'/workspace_wo_orth_',num2str(net),'_net_',num2str(fold),'_fold_0.003_regC_');
fin =str1;
load(strcat(str1,'.mat'))

str3  = strcat(fin,'_test',num2str(fold),'.mat');

%lambda_2 = 0.0;
%B_hat = eye(size(corr,2),size(corr,3));
for i = 1:size(B_thresh,2)
%     
%     [C_gd_test{i},C_hat_gd_test{i}] = quad_estimate_C(B_gd{i},B_hat_gd{i},lambda_2,corr_test{i});
%     [C_gd_train{i},C_hat_gd_train{i}] = quad_estimate_C(B_gd{i},B_hat_gd{i},lambda_2,corr_train{i});
%     
%    corr_GSR_test{i} = corr_test{i} - mean(corr_train{i},1);
    C_gd_test{i}= quad_estimate_C_old(B_gd{i},lambda_2,corr_test{i});
    C_gd_train{i}= quad_estimate_C_old(B_gd{i},lambda_2,corr_train{i});
    
%     C_gd_test{i}= quad_estimate_C_old(B_gd{i},lambda_2,corr_test{i});
%     C_gd_train{i}= quad_estimate_C_old(B_gd{i},lambda_2,corr_train{i});
% %  
    Y_obt_test{i} = C_gd_test{i}'*W_gd{i};
    Y_obt_train{i} = C_gd{i}'*W_gd{i};
    Y_est_train{i} = C_gd_train{i}'*W_gd{i};
    %error_test(i) = norm(Y_obt_test{i}-Y_test{i},'fro')/size(Y_test{i},1);
    error_test(i) = sqrt(sum((Y_obt_test{i}(:)-Y_test{i}(:)).^2)/numel(Y_test{i}));
    %error_train(i) = norm(Y_obt_train{i}-Y_train{i},'fro')/size(Y_train{i},1);
    error_train(i) = sqrt(sum((Y_obt_train{i}(:)-Y_train{i}(:)).^2)/numel(Y_train{i}));
    error_train_est(i) = sqrt(sum((Y_est_train{i}(:)-Y_train{i}(:)).^2)/numel(Y_train{i}));
    %error_train_est(i) = norm(Y_est_train{i}-Y_train{i},'fro')/size(Y_train{i},1);
end

clear fin fni
save(str3)
