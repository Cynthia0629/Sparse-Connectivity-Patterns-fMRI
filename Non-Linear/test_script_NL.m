%% Testing

fold=15;

% st = '/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/Non-Linear/SCI_m_CV';

% load(strcat(st,'/data_out_',num2str(fold),'.mat'))

str1 = strcat(st,'/workspace_frac_',num2str(net),'_net_',num2str(fold),'_fold_',num2str(lambda_1),'_sparsity_'...
    ,num2str(lambda_2),'_regC_',num2str(lambda_3),'_regW_',num2str(lambda),'_trad_',num2str(sigma^2),'_ker_',num2str(w_p),'_w_p_',num2str(p),'_ord');
fin =str1;
filename_NL = dir([str1 '/*.mat']);

str3  = strcat(fin,'_test',num2str(fold),'.mat');

for i = 1:size(filename_NL)
     
%     load(strcat(str1,'/',num2str(i),'_cv_f','.mat'))
    load([filename_NL(i).folder '/' filename_NL(i).name])
    B_gd{i} =B_gd_cv;
    C_gd{i}= C_gd_cv;
    K_gd{i} = K_gd_cv;
    D_gd{i}=D_gd_cv;
    lamb_gd{i}=lamb_gd_cv;
    
    C_gd_test{i} = quad_estimate_C_old(B_gd{i},lambda_2,corr_test{i});
    C_gd_train{i}= quad_estimate_C_old(B_gd{i},lambda_2,corr_train{i});
 
    Y_obt_train{i} =  Compute_Scores(C_gd{i},C_gd{i},K_gd{i},Y_train{i},lambda_3,lambda,corr_train{i},sigma,w_p,p);
    Y_est_train{i} = Compute_Scores(C_gd_train{i},C_gd{i},K_gd{i},Y_train{i},lambda_3,lambda,corr_train{i},sigma,w_p,p);
    Y_obt_test{i} = Compute_Scores(C_gd_test{i},C_gd{i},K_gd{i},Y_train{i},lambda_3,lambda,corr_test{i},sigma,w_p,p);
     
%    offs =-20;
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
filename_NL = strcat(str3);
save(filename_NL,'C_gd_train','C_gd_test','Y_est_train','Y_obt_test','Y_obt_train','error_test','error_train','error_train_est' ...
,'B_gd','C_gd','Y_test','Y_train')
