clearvars -except net
close all

fold =10;
% part =5; 
st = '/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/mod_2/SRS_CA_CV';
load(strcat(st,'/data_',num2str(fold),'.mat'))
fprintf(st)
fprintf('\n')

  %% Initialising parameters
for i =1:size(Y_train,2)

    m= 116;
    B_init = -1+2*rand(m,net);
    C_init = randn(net,size(Y_train{i},1));
    B_hat_init = reshape(mean(corr,1),[116,116]);
    W_init = rand(net,1);
    %C_hat_init = randn(size(corr,2),size(Y_train{i},1));
    
    lr1 = 0.0001;
    
    
    lambda = 1;
    lambda_1 =2;
    lambda_2 =0.1;
    lambda_3 =0.01;
    lambda_4 =0.0;

    [B_gd{i},B_hat_gd{i},C_hat{i},W_gd{i}] = gradient_descent_runner(corr_train{i},B_init,B_hat_init,C_init,W_init,Y_train{i},lambda,lambda_1,lambda_2,lambda_3,lambda_4,lr1);

    B_thresh{i} = B_gd{i}.*(B_gd{i}<0.1*(min(min(B_gd{i})))) + B_gd{i}.*(B_gd{i}>0.1*(max(max(B_gd{i}))));
    
    %str1 = strcat(st,'/workspace_',num2str(n),'_net_',num2str(fold),'_part_');
    %str2 = strcat(str1,num2str(part),'.mat');
    

    str1 = strcat(st,'/workspace_',num2str(net),'_net_',num2str(fold),'_fold');
    str2 = strcat(str1,'.mat');
    save(str2)
end

 

