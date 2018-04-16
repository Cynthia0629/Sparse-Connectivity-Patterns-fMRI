clearvars -except net lambda_1
close all

fold =10;
% part =5; 
st = '/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/baseline/Outliers/SRS_Cont_CV';
load(strcat(st,'/data_out_',num2str(fold),'.mat'))
fprintf(st)
fprintf('\n')

%% Initialise
lr1 = 0.001; 
lambda = 0.1;
%   lambda_1 =2;
 lambda_2 =0.9;
lambda_3 =0.1;
lambda_4 =0;

% str1 = strcat('/workspace_out_',num2str(net),'_net_',num2str(fold),'_fold_',num2str(lambda_1),'_sparsity_',num2str(lambda_2),'_regC_',num2str(lambda_3),'_regW_',num2str(lambda),'_trad/');
% dire = strcat(st,'/Sweep_reg_C',str1);
% mkdir(dire);
  %% Initialising parameters
for i =1:size(Y_train,2)

    m= 116;
    B_init = -1+2*sprand(m,net,0.2);
    C_init = randn(net,size(Y_train{i},1));
    B_hat_init = reshape(mean(corr_train{i},1),[116,116]);
    W_init = rand(net,1);
   
    C_hat_init =zeros(size(corr_train{i},2),size(Y_train{i},1));
%     B_init = B_gd_init{i};
%     C_init = C_gd_init{i};
%     W_init =W_gd_init{i};
   
    %corr_GSR_train{i} = corr_train{i}- mean(corr_train{i},1);
    
   fprintf('\n Fold: %d, sparsity penalty : %f; networks: %d \n',i,lambda_1,net)
   fprintf('\n tradeoff penalty: %f, C penalty : %f; W penalty: %f \n',lambda,lambda_2,lambda_3)
   
    [B_gd{i},B_hat_gd{i},C_gd{i},C_hat_gd{i},W_gd{i}] = gradient_descent_runner(corr_train{i},B_init,B_hat_init,C_init,C_hat_init,W_init,Y_train{i},lambda,lambda_1,lambda_2,lambda_3,lambda_4,lr1);
%     [B_gd{i},C_gd{i},W_gd{i}] = gradient_descent_runner_old(corr_train{i},B_init,C_init,W_init,Y_train{i},lambda,lambda_1,lambda_2,lambda_3,lambda_4,lr1);
    

    
    str1 = strcat(st,'/Avg/Sweep_reg_B/workspace_out_',num2str(net),'_net_',num2str(fold),'_fold_',num2str(lambda_1),'_sparsity_',num2str(lambda_2),'_regC_',num2str(lambda_3),'_regW_',num2str(lambda),'_trad');
    str2 = strcat(str1,'.mat');
    
    save(str2)



end

