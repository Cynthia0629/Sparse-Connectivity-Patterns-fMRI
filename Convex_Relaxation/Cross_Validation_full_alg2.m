clearvars -except net lambda_2
close all

fold =10;
st = '/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/Convex_Relaxation/SRS_Cont_CV';

load(strcat(st,'/data_out_',num2str(fold),'.mat'))
fprintf(st)
fprintf('\n')

  %% Initialising parameters
for i =1:size(Y_train,2)

    m= 116;
    
    B_init = sprandn(m,net,0.2);
%     mean_corr = reshape(mean(corr_train{i},1),[116,116]);
%     
%     [V,D] = eig(mean_corr);
%     [uselessVariable,permutation]=sort(diag(D));
%     D=D(permutation,permutation);V=V(:,permutation);
%     
%     B_init = V(:,end-net+1:end);
%     
    C_init =  abs(randn(net,size(Y_train{i},1)));

    lamb_init = zeros(size(Y_train{i},1),m,net);
    W_init =randn(net,1);
    
    %B_avg_init = reshape(mean(corr_train{i},1),size(corr,2),size(corr,3));
    
    for j = 1:size(Y_train{i},1)
        D_init(j,:,:) = B_init*diag(C_init(:,j));
    end 
    
    fprintf('\n Fold: %d, regression penalty : %f; networks: %d \n',i,lambda_2,net)
    lr1 = 0.001; 
    lambda = 1;
    lambda_1 =10;
    
    %lambda_2 =0.2;
    lambda_3 =1;

%  [B_gd{i},B_avg_gd{i},C_gd{i},W_gd{i},D_gd{i},lamb_gd{i}]  = gradient_descent_runner_avg(corr_train{i},B_init,B_avg_init,C_init,W_init,D_init,Y_train{i},lamb_init,lambda,lambda_1,lambda_2,lambda_3,lr1);
  [B_gd{i},C_gd{i},W_gd{i},D_gd{i},lamb_gd{i}]  = gradient_descent_runner(corr_train{i},B_init,C_init,W_init,D_init,Y_train{i},lamb_init,lambda,lambda_1,lambda_2,lambda_3,lr1);
%     
    str1 = strcat(st,'/workspace_out_',num2str(net),'_net_',num2str(fold),'_fold_',num2str(lambda_2),'_regC_');
    str2 = strcat(str1,'.mat');
    save(str2)
end

 

