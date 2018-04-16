clearvars -except net lambda_1

fold =10;
st = '/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/Convex_Relaxation/SRS_Cont_CV';

load(strcat(st,'/data_out_',num2str(fold),'.mat'))
fprintf(st)
fprintf('\n')

%% Initialise
lr1 = 0.001; 
lambda = 1;
% lambda_1 =50;    
%  lambda_22 =0.5;
%  lambda_21 =2;
lambda_2 =0.5;
lambda_3 =1;


  %% Initialising parameters
    
tic;
for i = 1:size(Y_train,2)
      
   m= 116;
    
   B_init = sprandn(m,net,0.1);    
   B_avg_init = reshape(mean(corr_train{i},1),size(corr,2),size(corr,3));
   C_init =  abs(randn(net,size(Y_train{i},1)));
   b_init = mean(Y_train{i});
   
   lamb_init = zeros(size(Y_train{i},1),m,net);
   W_init =randn(net,1);
   
   D_init = initD(B_init,C_init);
   
   
   fprintf('\n Fold: %d, sparsity penalty : %f; networks: %d \n',i,lambda_1,net)
   fprintf('\n tradeoff penalty: %f, C penalty : %f; W penalty: %f \n',lambda,lambda_2,lambda_3)
    
%      [B_gd{i},B_avg_gd{i},C_gd{i},W_gd{i},D_gd{i},lamb_gd{i}]  = gradient_descent_runner_avg(corr_train{i},B_init,B_avg_init,C_init,W_init,D_init,Y_train{i},lamb_init,lambda,lambda_1,lambda_2,lambda_3,lr1);
%    [B_gd,B_avg_gd,C_gd,W_gd,D_gd,lamb_gd]  = gradient_descent_runner_avg(corr_train{i},B_init,B_avg_init,C_init,W_init,D_init,Y_train{i},lamb_init,lambda,lambda_1,lambda_2,lambda_3,lr1);
%       [B_gd{i},C_gd{i},W_gd{i},D_gd{i},lamb_gd{i}]  = gradient_descent_runner(corr_train{i},B_init,C_init,W_init,D_init,Y_train{i},lamb_init,lambda,lambda_1,lambda_2,lambda_3,lr1);
      [B_gd{i},C_gd{i},W_gd{i},b_gd{i},D_gd{i},lamb_gd{i}]  = gradient_descent_runner_bias(corr_train{i},B_init,C_init,W_init,b_init,D_init,Y_train{i},lamb_init,lambda,lambda_1,lambda_2,lambda_3,lr1);
%   [B_gd,C_gd,W_gd,D_gd,lamb_gd]  = gradient_descent_runner(corr_train{i},B_init,C_init,W_init,D_init,Y_train{i},lamb_init,lambda,lambda_1,lambda_2,lambda_3,lr1);
%  [B_gd{i},C_gd{i},W1_gd{i},W2_gd{i},D_gd{i},lamb_gd{i}]  = gradient_descent_runner_hacky(corr_train{i},B_init,C_init,W_init,W_init,z_train{i},D_init,Y_train{i},lamb_init,lambda,lambda_1,lambda_21,lambda_22,lambda_3,lr1);

str1 = strcat(st,'/Bias/Sweep_reg_B/workspace_out_',num2str(net),'_net_',num2str(fold),'_fold_',num2str(lambda_1),'_sparsity_',num2str(lambda_2),'_regC_',num2str(lambda_3),'_regW_',num2str(lambda),'_trad');
str2 = strcat(str1,'.mat');
    
save(str2)
 
end

toc;
 