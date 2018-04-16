clearvars -except net lambda_2
close all

fold =10;
% part =5; 
st = '/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/baseline/Outliers/ADOS_CV/';
load(strcat(st,'/data_out_',num2str(fold),'.mat'))
fprintf(st)
fprintf('\n')

%% Initialise
lr1 = 0.001; 
lambda = 10;
lambda_1 =2;
% lambda_2 =0.1;
lambda_3 =0.1;
lambda_4 =0;

str1 = strcat('/workspace_out_',num2str(net),'_net_',num2str(fold),'_fold_',num2str(lambda_1),'_sparsity_',num2str(lambda_2),'_regC_',num2str(lambda_3),'_regW_',num2str(lambda),'_trad/');
dire = strcat(st,'/Sweep_reg_C',str1);
mkdir(dire);
tic;
  %% Initialising parameters
parfor i =1:size(Y_train,2)

    m= 116;
    B_init = -1+2*sprand(m,net,0.4);
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
   
%        [B_gd,B_hat_gd,C_gd,C_hat_gd,W_gd] = gradient_descent_runner(corr_train{i},B_init,B_hat_init,C_init,C_hat_init,W_init,Y_train{i},lambda,lambda_1,lambda_2,lambda_3,lambda_4,lr1);
    [B_gd,C_gd,W_gd] = gradient_descent_runner_old(corr_train{i},B_init,C_init,W_init,Y_train{i},lambda,lambda_1,lambda_2,lambda_3,lambda_4,lr1);
    
%     B_thresh{i} = B_gd{i}.*(B_gd{i}<0.1*(min(min(B_gd{i})))) + B_gd{i}.*(B_gd{i}>0.1*(max(max(B_gd{i}))));
    
    %str1 = strcat(st,'/workspace_',num2str(n),'_net_',num2str(fold),'_part_');
    %str2 = strcat(str1,num2str(part),'.mat');
    

    cd(dire)

%    parsave(sprintf('output%d.mat', i), B_gd,B_hat_gd,C_gd,W_gd, ...
%    corr_train{i},corr_test{i},Y_train{i},Y_test{i}, ...
%    B_init,B_hat_init,C_init,W_init, ...
%    lambda,lambda_1,lambda_2,lambda_3,lr1);

parsave_non_avg(sprintf('output%d.mat', i), B_gd,C_gd,W_gd, ...
   corr_train{i},corr_test{i},Y_train{i},Y_test{i}, ...
   B_init,C_init,W_init, ...
   lambda,lambda_1,lambda_2,lambda_3,lr1)

end

%      lr1 = 0.001; 
%     lambda = 1;
%     lambda_1 =2;
%     lambda_2 =0.1;
%     lambda_3 =0.1;
%     lambda_4 =0;
% str1 = strcat(st,'/Sweep_reg_W/workspace_out_',num2str(net),'_net_',num2str(fold),'_fold_',num2str(lambda_1),'_sparsity_',num2str(lambda_2),'_regC_',num2str(lambda_3),'_regW_',num2str(lambda),'_trad');
% str2 = strcat(str1,'.mat');
%     
% save(str2)
toc;
