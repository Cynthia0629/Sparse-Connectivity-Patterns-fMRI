clear all
close all

load('~/Documents/Sparse connectivity patterns/Data_Simulation/Simulated_Data.mat')

%% Initialising parameters

B_init = rand(size(B));
%[m,n] = size(B);
%B_init = randi([0 1], m,n);
C_init = rand(size(C));
W_init = rand(size(W));
%B_init = B;
% C_init = C;
% W_init = W;

num_iter = 100;
lr1 = 0.0001;
lr2 = 0.0001;
lambda = 5;
lambda_1 = 400;
lambda_2 =5;
lambda_3 = 9;

[B_gd,C_gd,W_gd] = gradient_descent_runner(corr,B_init,C_init,W_init,Y,lambda,lambda_1,lambda_2,lambda_3,lr1,lr2);

B_thresh = B_gd.*(B_gd<0.7*(min(min(B_gd)))) + B_gd.*(B_gd>0.7*(max(max(B_gd))));

figure; subplot(1,2,1);
colormap('hot')
title('Original connections matrix')
imagesc(B)
colorbar;

subplot(1,2,2)
title('Recovered connections matrix')
imagesc(B_thresh)
colorbar;