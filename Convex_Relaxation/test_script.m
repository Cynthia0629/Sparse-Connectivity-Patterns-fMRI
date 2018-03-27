%% Testing
fold =10;
st = '/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/baseline/Outliers/ADOS_CV/Net_Sweep/';

% load(strcat(st,'/data_out_',num2str(fold),'.mat'))

str1 = strcat(st,'/workspace_out_',num2str(net),'_net_',num2str(fold),'_fold_',num2str(lambda_1),'_sparsity_'...
    ,num2str(lambda_2),'_regC_',num2str(lambda_3),'_regW_',num2str(lambda),'_trad');
fin =str1;
load(strcat(str1,'.mat'))
str3  = strcat(fin,'_test',num2str(fold),'.mat');

for i = 1:size(B_gd,2)

    C_gd_test{i}= quad_estimate_C_old(B_gd{i},lambda_2,corr_test{i});
    C_gd_train{i}= quad_estimate_C_old(B_gd{i},lambda_2,corr_train{i});
 
%     Aut_id_train{i} =ones(size(z_train{i},1),1);
%     Cont_id_train{i} =zeros(size(z_train{i},1),1);
%     Aut_id_test{i} =ones(size(z_test{i},1),1);
%     Cont_id_test{i} =zeros(size(z_test{i},1),1);
%     
%     
%     C_gd_test_aut{i}= quad_estimate_C_old_hacky(B_gd{i},lambda_21,lambda_22,corr_test{i},Aut_id_test{i});
%     C_gd_train_aut{i}= quad_estimate_C_old_hacky(B_gd{i},lambda_21,lambda_22,corr_train{i},Aut_id_train{i});
% 
%     C_gd_test_cont{i}= quad_estimate_C_old_hacky(B_gd{i},lambda_21,lambda_22,corr_test{i},Cont_id_test{i});
%     C_gd_train_cont{i}= quad_estimate_C_old_hacky(B_gd{i},lambda_21,lambda_22,corr_train{i},Cont_id_train{i});
%     %     C_gd_test{i}= quad_estimate_C_avg(B_gd{i},lambda_2,corr_test{i},B_avg_gd{i});
%     C_gd_train{i}= quad_estimate_C_avg(B_gd{i},lambda_2,corr_train{i},B_avg_gd{i});
 
%      Z_hat_train{i} =repmat(Aut_id_train{i}',[size(C_gd_train_aut,1),1]);
%      Z_hat_test{i} =repmat(Aut_id_test{i}',[size(C_gd_test_aut,1),1]);
%     
%      Z_hat_train_act{i} =repmat(z_train{i}',[size(C_gd_train_aut,1),1]);
%      
%      Y_obt_test_aut{i} = (C_gd_test_aut{i})'*W1_gd{i};
%      Y_obt_test_cont{i} = (C_gd_test_cont{i})'*W2_gd{i};
%     
%      Y_est_train_aut{i} =(C_gd{i}.*Z_hat_train_act{i})'*W1_gd{i};
%      Y_est_train_cont{i} =(C_gd{i}.*(1-Z_hat_train_act{i}))'*W2_gd{i};
     Y_obt_train{i} = (C_gd{i})'*W_gd{i};
     Y_est_train{i} = (C_gd_train{i})'*W_gd{i};
     Y_obt_test{i} = (C_gd_test{i})'*W_gd{i};
    
    error_test(i) = sqrt(sum((Y_obt_test{i}(:)-Y_test{i}(:)).^2)/numel(Y_test{i}));
    error_train(i) = sqrt(sum((Y_obt_train{i}(:)-Y_train{i}(:)).^2)/numel(Y_train{i}));
    error_train_est(i) = sqrt(sum((Y_est_train{i}(:)-Y_train{i}(:)).^2)/numel(Y_train{i}));
    
end

clear fin fni
save(str3,'C_gd_train','C_gd_test','Y_est_train','Y_obt_test','error_test','error_train','error_train_est' ...
,'B_gd','C_gd','Y_test','Y_train','W_gd')

% save(str3,'C_gd_train','C_gd_test','Y_est_train','Y_obt_test','error_test','error_train','error_train_est' ...
% ,'B_gd','C_gd','D_gd','lamb_gd','Y_test','Y_train','W_gd')

save(str3)