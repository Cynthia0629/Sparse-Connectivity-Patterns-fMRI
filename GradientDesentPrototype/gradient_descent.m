clear all
close all

load('~/Documents/Sparse connectivity patterns/Data_Simulation/Simulated_Data.mat')

%% Initialising parameters

B_init = ones(size(B));
C_init = rand(size(C));
W_init = zeros(size(W));

num_iter = 1000;
lr1 = 0.01;
lr2 = 0.1;
lambda = 0.01;
lambda_1 = 0.01;
lambda_2 =100;

[B_gd,C_gd,W_gd] = gradient_descent_runner(corr,B_init,C_init,W_init,Y,lambda,lambda_1,lambda_2,lr1,lr2);

