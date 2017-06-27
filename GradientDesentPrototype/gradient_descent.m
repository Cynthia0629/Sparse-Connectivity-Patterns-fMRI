clear all
close all

load('~/Documents/Sparse connectivity patterns/Data_Simulation/Simulated_Data.mat')

%% Initialising parameters

B_init = rand(size(B));
C_init = rand(size(C));
W_init = rand(size(W));
% B_init = B;
% C_init = C;
% W_init = W;

num_iter = 100;
lr1 = 0.0001;
lr2 = 0.0001;
lambda = 5;
lambda_1 = 100;
lambda_2 =5;
lambda_3 = 10;

[B_gd,C_gd,W_gd] = gradient_descent_runner(corr,B_init,C_init,W_init,Y,lambda,lambda_1,lambda_2,lambda_3,lr1,lr2);

