clearvars -except net lambda_2 lambda_1 lambda_3 lambda offs_A offs_S scale_A scale_S scale st offs scale

fold =10;

filename = strcat(st,'/data_',num2str(fold),'.mat');
filename1 = strcat(st,'/data_out_',num2str(fold),'.mat');

if exist(filename,'file')
    load(filename)
else
    load(filename1)
end

fprintf(st)
fprintf('\n')

%% Initialise
lr1 = 0.001; 
% lambda = 1;
% lambda_1 = 20;    
% %  lambda_22 =0.5;
% %  lambda_21 =2;
% % lambda_2 =0.1;
% lambda_3 =1;
% offs_A =0;
% scale_A =1;

  %% Initialising parameters
    
tic;
for i = 1:size(corr_train,2)
      
   m= size(corr_train{i},2);
    
   B_init = sprandn(m,net,0.4);    
   B_avg_init = reshape(mean(corr_train{i},1),size(corr_train{i},2),size(corr_train{i},3));
   C_init =  abs(randn(net,size(corr_train{i},1)));
%    b_init = mean(Y_train{i});
   
   lamb_init = zeros(size(corr_train{i},1),m,net);
   W_init =randn(net,1);
   
   D_init = initD(B_init,C_init);
   
%    offs =0;
%    scale = 30/137;
%    Y_train{i} = Y_train{i} + offs;
%    Y_train{i} = Y_train{i}* scale;
%    
   Y_ADOS_train{i} = Y_ADOS_train{i} + offs_A;
   Y_ADOS_train{i} = Y_ADOS_train{i}* scale_A;

   Y_SRS_train{i} = Y_SRS_train{i} + offs_S;
   Y_SRS_train{i} = Y_SRS_train{i}* scale_S;

   fprintf('\n Fold: %d, sparsity penalty : %f; networks: %d \n',i,lambda_1,net)
   fprintf('\n tradeoff penalty: %f, C penalty : %f; W penalty: %f \n',lambda,lambda_2,lambda_3)
    
%         [B_gd{i},B_avg_gd{i},C_gd{i},W_gd{i},D_gd{i},lamb_gd{i}]  = gradient_descent_runner_avg(corr_train{i},B_init,B_avg_init,C_init,W_init,D_init,Y_train{i},lamb_init,lambda,lambda_1,lambda_2,lambda_3,lr1);
%       [B_gd{i},C_gd{i},W_gd{i},D_gd{i},lamb_gd{i}]  = gradient_descent_runner(corr_train{i},B_init,C_init,W_init,D_init,Y_train{i},lamb_init,lambda,lambda_1,lambda_2,lambda_3,lr1);
         [B_gd{i},C_gd{i},W_ADOS_gd{i},W_SRS_gd{i},D_gd{i},lamb_gd{i}]  = gradient_descent_runner_multi(corr_train{i},B_init,C_init,W_init,D_init,Y_ADOS_train{i},Y_SRS_train{i},lamb_init,lambda,lambda_1,lambda_2,lambda_3,lr1);

                
%    [B_gd{i},C_gd{i},W1_gd{i},W2_gd{i},D_gd{i},lamb_gd{i}]  = gradient_descent_runner_hacky(corr_train{i},B_init,C_init,W_init,W_init,z_train{i},D_init,Y_train{i},lamb_init,lambda,lambda_1,lambda_21,lambda_22,lambda_3,lr1);


%bias 
%      [B_gd{i},B_avg_gd{i},C_gd{i},W_gd{i},b_gd{i},D_gd{i},lamb_gd{i}]  = gradient_descent_runner_avg_bias(corr_train{i},B_init,B_avg_init,C_init,W_init,b_init,D_init,Y_train{i},lamb_init,lambda,lambda_1,lambda_2,lambda_3,lr1);
%      [B_gd{i},C_gd{i},W_gd{i},b_gd{i},D_gd{i},lamb_gd{i}]  = gradient_descent_runner_bias(corr_train{i},B_init,C_init,W_init,b_init,D_init,Y_train{i},lamb_init,lambda,lambda_1,lambda_2,lambda_3,lr1);


str1 = strcat(st,'/workspace_out_',num2str(net),'_net_',num2str(fold),'_fold_',num2str(lambda_1),'_sparsity_',num2str(lambda_2),'_regC_',num2str(lambda_3),'_regW_',num2str(lambda),'_trad');
str2 = strcat(str1,'.mat');
    
save(str2)
 
end

toc;

% test_script;