clearvars -except net set seed
close all

my_path = '/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/Convex_Relaxation/Simulated_Data_2/Simulated_Data';
load(strcat(my_path,num2str(set),'.mat'))
m= 116;
% net =9;
n = size(corr,1);
spa = nnz(B)/numel(B);
params.spa =spa;
rng(seed)

B_init = sprandn(m,net,spa);
C_init =  abs(2*randn(net,size(Y,1)));

for i = 1:size(Y,1)
    D_init(i,:,:) = B_init*diag(C_init(:,i));
end

lamb_init = zeros(size(Y,1),m,net);
W_init =randn(net,1);

lr1 = 0.001; 
lambda = 1;
lambda_1 =10;
lambda_2 =0.2;
lambda_3 =1;


[B_gd,C_gd,W_gd,D_gd,lamb_gd] = gradient_descent_runner(corr,B_init,C_init,W_init,D_init,Y,lamb_init,lambda,lambda_1,lambda_2,lambda_3,lr1);

save(strcat(my_path,'_set_',num2str(set),'_out_spa_',num2str(seed),'.mat'))