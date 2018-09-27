net = 4;seed=1;set=1;

my_path = '/home/niharika-shimona/Documents/Projects/Autism_Network/Sparse-Connectivity-Patterns-fMRI/Simulated_Data/Simulated_Data_set_';

clearvars -except net set seed my_path
close all

load(strcat(my_path,num2str(set),'.mat'))
m= 116;

n = size(corr,1);
spa = nnz(B)/numel(B);
params.spa =spa;
rng(seed)

B_init = sprandn(m,net,spa);
C_init =  abs(1*randn(net,size(Y,1)));
B_avg_init = reshape(mean(corr,1),[size(corr,2),size(corr,3)]); 

for i = 1:size(Y,1)
    D_init(i,:,:) = B_init*diag(C_init(:,i));
end

lamb_init = zeros(size(Y,1),m,net);
W_init =randn(net,1);

lr1 = 0.001; 
lambda = 1;
lambda_1 =10;
lambda_2 =0.1;
lambda_3 =1;


% [B_gd,B_avg_gd,C_gd,W_gd,D_gd,lamb_gd] = gradient_descent_runner_avg(corr,B_init,B_avg_init,C_init,W_init,D_init,Y,lamb_init,lambda,lambda_1,lambda_2,lambda_3,lr1);
[B_gd,C_gd,D_gd,lamb_gd] = gradient_descent_runner_NL(corr,B_init,C_init,D_init,Y,lamb_init,lambda,lambda_1,lambda_2,lambda_3,lr1);

save(strcat(my_path,num2str(set),'_out_',num2str(seed),'.mat'))