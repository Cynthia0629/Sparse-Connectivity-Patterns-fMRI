
load('/home/niharika-shimona/Documents/Projects/Autism_Network/Sparse-Connectivity-Patterns-fMRI/Convex_Relaxation/Simulated_Data.mat')
m= 116;
net =4;
n = size(corr,1);

B_init = -1+2*rand(m,net);
C_init = randn(net,size(Y,1));
D_init = randn(size(Y,1),m,net);
lamb_init = zeros(size(Y,1),m,net);
W_init = rand(net,1);

lr1 = 0.01; 
lambda = 0.1;
lambda_1 =1;
lambda_2 =0.1;
lambda_3 =0.1;


[B,C,W,D,lamb] = gradient_descent_runner(corr,B_init,C_init,W_init,D_init,Y,lamb_init,lambda,lambda_1,lambda_2,lambda_3,lr1);