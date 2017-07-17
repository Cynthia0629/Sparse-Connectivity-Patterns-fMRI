clear all
close all

load('/home/niharika-shimona/Documents/Projects/Autism_Network/Sparse-Connectivity-Patterns-fMRI/Data_Simulation/Real_Data_ADOS.mat')

%% Initialising parameters

% B_init = rand(size(B));
% [m,n] = size(B);
m= 116;
n= 8;
B_init = randi([-1,1],m,n);
% C_init = rand(size(C));
C_init = rand(n,size(Y,1));
% W_init = rand(size(W));
W_init = rand(n,1);
% B_init = B;
% C_init = C;
% W_init = W;

num_iter = 100;
lr1 = 0.0001;
lr2 = 0.0001;
lambda = 1;
lambda_1 =5;
lambda_2 =1;
lambda_3 = 1;

[B_gd,C_gd,W_gd] = gradient_descent_runner(corr,B_init,C_init,W_init,Y,lambda,lambda_1,lambda_2,lambda_3,lr1,lr2);

B_thresh = B_gd.*(B_gd<0.01*(min(min(B_gd)))) + B_gd.*(B_gd>0.01*(max(max(B_gd))));

figure; 
% subplot(1,2,1);
% colormap('hot')
% imagesc(B)
% colorbar;
% title('Original connections matrix')

% subplot(1,2,2)

imagesc(B_thresh)
colorbar;
title('Recovered connections matrix')

save('/home/niharika-shimona/Documents/Projects/Autism_Network/Sparse-Connectivity-Patterns-fMRI/Data_Simulation/workspace_qpRDADOS.mat')