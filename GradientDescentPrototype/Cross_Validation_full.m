clearvars 
close all

n =8;
fold = 5;

st = '/home/niharika-shimona/Documents/Projects/Autism_Network/Sparse-Connectivity-Patterns-fMRI/ADOS_CV';
load(strcat(st,'/data_',num2str(fold),'.mat'))
fprintf(st)
fprintf('\n')

%% Initialising parameters
for i = 1: size(Y_train,2)
    m= 116;
    B_init = -1+2*rand(m,n);
    % [V,D] = eig(reshape(mean(corr,1),[116,116]));
    % B_init = V(:,1:n);
    % C_init = rand(size(C));
    C_init = rand(n,size(Y_train{i},1));
    % W_init = rand(size(W));
    W_init = rand(n,1);
    

    lr1 = 0.001;
    lr2 = 0.0001;
    lambda = 1;
    lambda_1 =2;
    lambda_2 =1;
    lambda_3 =1;

    [B_gd{i},C_gd{i},W_gd{i}] = gradient_descent_runner(corr_train{i},B_init,C_init,W_init,Y_train{i},lambda,lambda_1,lambda_2,lambda_3,lr1,lr2);

    B_thresh{i} = B_gd{i}.*(B_gd{i}<0.1*(min(min(B_gd{i})))) + B_gd{i}.*(B_gd{i}>0.1*(max(max(B_gd{i}))));
    str1 = strcat(st,'/workspace_',num2str(n),'_net',num2str(fold));
    str2 = strcat(str1,'.mat');
    save(str2)
end

%% Testing 

clearvars -except str1 st;
load(str1)
load(strcat(st,'/data.mat'))

for i = 1:size(B_thresh,2)
    
    C_gd_test{i} = quad_estimate_C(B_gd{i},lambda_2,corr_test{i});
    Y_obt_test{i} = C_gd_test{i}'*W_gd{i};
    Y_obt_train{i} = C_gd{i}'*W_gd{i};
    error_test(i) = norm(Y_obt_test{i}-Y_test{i},'fro')/size(Y_test{i},1);
    error_train(i) = norm(Y_obt_train{i}-Y_train{i},'fro')/size(Y_train{i},1);
    
end

str2  = strcat(str1,'_test',num2str(fold),'.mat');
save(str2)