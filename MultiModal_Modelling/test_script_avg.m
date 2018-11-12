%% Testing

fold =5;

% st = '/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/Convex_Relaxation/SCI_m_CV/Reg_116/Non_Avg/';

% load(strcat(st,'/data_out_',num2str(fold),'.mat'))

str1 = strcat(st,'/workspace_out_',num2str(net),'_net_',num2str(lambda_1),'_sparsity_'...
    ,num2str(lambda_2),'_regC_',num2str(lambda_3),'_regW_',num2str(lambda),'_trad');
filename_final=str1;
load(strcat(str1,'.mat'))
my_string  = strcat(filename_final,'_test',num2str(fold),'.mat');

parfor i = 1:size(B_gd,2)

    C_gd_test{i}= quad_estimate_C_multimodal_avg(B_gd{i},B_avg_gd{i},lambda_2,corr_test{i},Q_test{i});
    C_gd_train{i}= quad_estimate_C_multimodal_avg(B_gd{i},B_avg_gd{i},lambda_2,corr_train{i},Q_train{i});
 
     Y_obt_train{i} = (C_gd{i})'*W_gd{i};
     Y_est_train{i} = (C_gd_train{i})'*W_gd{i};
     Y_obt_test{i} = (C_gd_test{i})'*W_gd{i};
     
     Y_obt_train{i} = (Y_obt_train{i})*(1/scale)-offs;
     Y_train{i} = (Y_train{i})*(1/scale)-offs;
     Y_est_train{i} = (Y_est_train{i})*(1/scale) -offs;
     Y_obt_test{i} = (Y_obt_test{i})*(1/scale) -offs;
     Y_test{i} = (Y_test{i})*(1/scale)-offs;
     
    error_test(i) = sqrt(sum((Y_obt_test{i}(:)-Y_test{i}(:)).^2)/numel(Y_test{i}));
    error_train(i) = sqrt(sum((Y_obt_train{i}(:)-Y_train{i}(:)).^2)/numel(Y_train{i}));
    error_train_est(i) = sqrt(sum((Y_est_train{i}(:)-Y_train{i}(:)).^2)/numel(Y_train{i}));
    
end

clear fin fni

save(my_string,'C_gd_train','C_gd_test','Y_est_train','Y_obt_test','Y_obt_train','error_test','error_train','error_train_est' ...
,'B_gd','C_gd','Y_test','Y_train','W_gd')

% save(str3,'C_gd_train','C_gd_test','Y_est_train','Y_obt_test','error_test','error_train','error_train_est' ...
% ,'B_gd','C_gd','D_gd','lamb_gd','Y_test','Y_train','W_gd')

% save(str3)