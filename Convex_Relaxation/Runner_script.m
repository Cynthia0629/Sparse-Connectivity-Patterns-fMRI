clear all
close all

load('/home/niharika-shimona/Documents/Projects/Autism_Network/Sparse-Connectivity-Patterns-fMRI/Convex_Relaxation/Simulated_Data.mat')
m= 116;
net =4;
n = size(corr,1);

B_init = -0.1+0.2*randn(m,net);
C_init =  abs(2*randn(net,size(Y,1)));

for i = 1:size(Y,1)
    D_init(i,:,:) = B_init*diag(C_init(:,i));
end

lamb_init = zeros(size(Y,1),m,net);
W_init =randn(net,1);

lr1 = 0.01; 
lambda = 0.01;
lambda_1 =0.0001;
lambda_2 =0.01;
lambda_3 =0.01;


[B_gd,C_gd,W_gd,D_gd,lamb_gd] = gradient_descent_runner(corr,B_init,C_init,W_init,D_init,Y,lamb_init,lambda,lambda_1,lambda_2,lambda_3,lr1);