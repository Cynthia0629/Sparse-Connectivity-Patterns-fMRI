clearvars -except my_path net l l1 l2 l3 
% my_path = '/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/Non-Linear/Simulated_Data_NL/Simulated_Data_set_polybias_';

close all;clc

load(strcat(my_path,'.mat'))
my_path 
m= 116;

n = size(corr,1);
% spa = nnz(B)/numel(B);
% params.spa =spa;
% rng(seed)

% Initialisation
B_init = sprandn(m,net,0.4);
C_init =  2*abs(randn(net,size(Y,1)));
sigma =sqrt(1);
K_init = compute_kernel(C_init,sigma);
B_avg_init = reshape(mean(corr,1),[size(corr,2),size(corr,3)]); 

for i = 1:size(Y,1)
    D_init(i,:,:) = B_init*diag(C_init(:,i));
end

lamb_init = zeros(size(Y,1),m,net);
W_init =randn(net,1);

%parameters
lr1 = 0.001; 
lambda = l;
lambda_1 =l1;
lambda_2 =l2;
lambda_3 =l3;

%calls alt. min. modules
% [B_gd,B_avg_gd,C_gd,W_gd,D_gd,lamb_gd] = gradient_descent_runner_avg(corr,B_init,B_avg_init,C_init,W_init,D_init,Y,lamb_init,lambda,lambda_1,lambda_2,lambda_3,lr1);
[B_gd,C_gd,K_gd,D_gd,lamb_gd] = gradient_descent_runner_NL(corr,B_init,C_init,K_init,D_init,Y,lamb_init,lambda,lambda_1,lambda_2,lambda_3,lr1,sigma);

save(strcat(my_path,'_exppoly_net_',num2str(net),'_sparsity_',num2str(lambda_1),'_regC_',num2str(lambda_2), ...
 '_regW_',num2str(lambda_3),'_trad_',num2str(lambda),'.mat'))