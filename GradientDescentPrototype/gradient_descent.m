clearvars -except n
close all

load('/home/niharika-shimona/Documents/Projects/Autism_Network/Sparse-Connectivity-Patterns-fMRI/Data_Simulation/Real_Data_SRSTotal.mat')

%% Initialising parameters

% B_init = rand(size(B));
% [m,n] = size(B);
m= 116;
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
lambda = 0.1;
lambda_1 =0.1;
lambda_2 =0.1;
lambda_3 =0.1;

[B_gd,C_gd,W_gd] = gradient_descent_runner(corr,B_init,C_init,W_init,Y,lambda,lambda_1,lambda_2,lambda_3,lr1,lr2);

B_thresh = B_gd.*(B_gd<0.1*(min(min(B_gd)))) + B_gd.*(B_gd>0.1*(max(max(B_gd))));

figure; 
% subplot(1,3,1);
% 
% imagesc(B)
% colorbar;
% title('Original connections matrix')

subplot(1,2,1)

imagesc(B_thresh)
colorbar;
title('Recovered connections matrix')

subplot(1,2,2)

imagesc(C_gd)
colorbar;
title('Coefficients matrix')

plot_qual_res(B_gd,C_gd)
str1 = strcat('/home/niharika-shimona/Documents/Projects/Autism_Network/Sparse-Connectivity-Patterns-fMRI/SRS_CA_runs/workspace_qp_s_0.1_',num2str(n),'_net.mat');
save(str1)