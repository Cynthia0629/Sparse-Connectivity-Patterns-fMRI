%% Testing

fold =10;

st = '/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/Convex_Relaxation/Praxis_ADOS_CV/';

% load(strcat(st,'/data_out_',num2str(fold),'.mat'))

str1 = strcat(st,'/workspace_out_',num2str(net),'_net_',num2str(fold),'_fold_',num2str(lambda_1),'_sparsity_'...
    ,num2str(lambda_2),'_regC_',num2str(lambda_3),'_regW_',num2str(lambda),'_trad');
fin =str1;
load(strcat(str1,'.mat'))
str3  = strcat(fin,'_test',num2str(fold),'.mat');

for i = 1:size(B_gd,2)

%     C_gd_test{i}= quad_estimate_C_avg(B_gd{i},lambda_2,corr_test{i},B_avg_gd{i});
%     C_gd_train{i}= quad_estimate_C_avg(B_gd{i},lambda_2,corr_train{i},B_avg_gd{i});
  
     C_gd_test{i}= quad_estimate_C_old(B_gd{i},lambda_2,corr_test{i});
     C_gd_train{i}= quad_estimate_C_old(B_gd{i},lambda_2,corr_train{i});
 
     Y_ADOS_obt_train{i} = (C_gd{i})'*W_ADOS_gd{i};
     Y_SRS_obt_train{i} = (C_gd{i})'*W_SRS_gd{i};
     
     Y_ADOS_est_train{i} = (C_gd_train{i})'*W_ADOS_gd{i};
     Y_SRS_est_train{i} = (C_gd_train{i})'*W_SRS_gd{i};
     
     Y_ADOS_obt_test{i} = (C_gd_test{i})'*W_ADOS_gd{i};
     Y_SRS_obt_test{i} = (C_gd_test{i})'*W_SRS_gd{i};
     
%    offs =-20;
     Y_ADOS_obt_train{i} = (Y_ADOS_obt_train{i})*(1/scale_A)-offs_A;
     Y_SRS_obt_train{i} = (Y_SRS_obt_train{i})*(1/scale_S)-offs_S;
     
     Y_ADOS_train{i} = (Y_ADOS_train{i})*(1/scale_A)-offs_A;
     Y_SRS_train{i} = (Y_SRS_train{i})*(1/scale_S)-offs_S;
     
     Y_ADOS_est_train{i} = (Y_ADOS_est_train{i})*(1/scale_A) -offs_A;
     Y_SRS_est_train{i} = (Y_SRS_est_train{i})*(1/scale_S) -offs_S;
     
     Y_ADOS_obt_test{i} = (Y_ADOS_obt_test{i})*(1/scale_A) -offs_A;
     Y_SRS_obt_test{i} = (Y_SRS_obt_test{i})*(1/scale_S) -offs_S;
     
    error_ADOS_test(i) = sqrt(sum((Y_ADOS_obt_test{i}(:)-Y_ADOS_test{i}(:)).^2)/numel(Y_ADOS_test{i}));
    error_SRS_test(i) = sqrt(sum((Y_SRS_obt_test{i}(:)-Y_SRS_test{i}(:)).^2)/numel(Y_SRS_test{i}));
    
    error_ADOS_train(i) = sqrt(sum((Y_ADOS_obt_train{i}(:)-Y_ADOS_train{i}(:)).^2)/numel(Y_ADOS_train{i}));
    error_SRS_train(i) = sqrt(sum((Y_SRS_obt_train{i}(:)-Y_SRS_train{i}(:)).^2)/numel(Y_SRS_train{i}));
    
    error_ADOS_train_est(i) = sqrt(sum((Y_ADOS_est_train{i}(:)-Y_ADOS_train{i}(:)).^2)/numel(Y_ADOS_train{i}));
    error_SRS_train_est(i) = sqrt(sum((Y_SRS_est_train{i}(:)-Y_SRS_train{i}(:)).^2)/numel(Y_SRS_train{i}));
    
end

clear fin fni
filename = strcat(str3);
save(filename,'C_gd_train','C_gd_test','Y_ADOS_est_train','Y_SRS_est_train','Y_ADOS_obt_test' ...
    ,'Y_SRS_obt_test', 'error_ADOS_test', 'error_SRS_test','error_ADOS_train','error_SRS_train','error_ADOS_train_est' ...
    ,'error_SRS_train_est','B_gd','C_gd','Y_ADOS_test','Y_SRS_test','Y_ADOS_train','Y_SRS_train','W_ADOS_gd','W_SRS_gd')

% save(str3,'C_gd_train','C_gd_test','Y_est_train','Y_obt_test','error_test','error_train','error_train_est' ...
% ,'B_gd','C_gd','D_gd','lamb_gd','Y_test','Y_train','W_gd')

save(str3)