% clearvars -except net set seed my_path
clearvars -except net my_path
close all
fold=10;
% load(strcat(my_path,num2str(set),'.mat'))
filename = strcat(my_path,'/data_',num2str(fold),'.mat');
filename1 = strcat(my_path,'/data_out_',num2str(fold),'.mat');

if exist(filename,'file')
    load(filename)
else
    load(filename1)
end

corr=vertcat(corr_train{1},corr_test{1});
Y=vertcat(Y_train{1},Y_test{1});

m= 116;
% net =9;
n = size(corr,1);
% spa = nnz(B)/numel(B);
% params.spa =spa;
% rng(seed)
spa=0.2;

B_init = sprandn(m,net,spa);
C_init =  abs(4*randn(net,size(Y,1)));
B_avg_init = reshape(mean(corr,1),[size(corr,2),size(corr,3)]); 


for i = 1:size(Y,1)
    D_init(i,:,:) = B_init*diag(C_init(:,i));
    
end

lamb_init = zeros(size(Y,1),m,net);
W_init =randn(net,1);

lr1 = 0.001; 
lambda = 0;
lambda_1 =30;
lambda_2 =0.2;
lambda_3 =0;

% [B_gd,B_avg_gd,C_gd,W_gd,D_gd,lamb_gd] = gradient_descent_runner_avg(corr,B_init,B_avg_init,C_init,W_init,D_init,Y,lamb_init,lambda,lambda_1,lambda_2,lambda_3,lr1);
[B_gd,C_gd,W_gd,D_gd,lamb_gd] = gradient_descent_runner(corr,B_init,C_init,W_init,D_init,Y,lamb_init,lambda,lambda_1,lambda_2,lambda_3,lr1);

% save(strcat(my_path,num2str(set),'_out_',num2str(seed),'.mat'))
str1 = strcat(my_path,'/workspace_out_',num2str(net),'_net_',num2str(fold),'_fold_',num2str(lambda_1),'_sparsity_',num2str(lambda_2),'_regC_',num2str(lambda_3),'_regW_',num2str(lambda),'_trad');
str2 = strcat(str1,'.mat');
    
save(str2)
