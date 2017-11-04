clearvars -except net
close all

load('/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/Data_Simulation/Real_Data_ADOS_mean_sub.mat')

%% Initialising parameters

% B_init = rand(size(B));
% [m,n] = size(B);
m= 116;
B_init = -1+2*rand(m,net);
% [V,D] = eig(reshape(mean(corr,1),[116,116]));
% B_init = V(:,1:net);

%for i = 1:size(corr,1)
B_hat_init = (reshape(mean(corr,1),[116,116]));
%end

C_init = randn(net,size(corr,1));
W_init = rand(net,1);
C_hat_init = randn(size(corr,2),size(corr,1));

num_iter = 100;
lr1 = 0.001;
lr2 = 0.0001;
lambda = 1;
lambda_1 =2;
lambda_2 =0.1;
lambda_3 =0.01;
lambda_4 =0;

[B_gd,B_hat_gd,C_gd,C_hat_gd,W_gd] = gradient_descent_runner(corr,B_init,B_hat_init,C_init,C_hat_init,W_init,Y,lambda,lambda_1,lambda_2,lambda_3,lambda_4,lr1);

B_thresh = B_gd.*(B_gd<0.1*(min(min(B_gd)))) + B_gd.*(B_gd>0.1*(max(max(B_gd))));

% figure; 
% % subplot(1,3,1);
% % 
% % imagesc(B)
% % colorbar;
% % title('Original connections matrix')
% 
% subplot(1,2,1)
% 
% imagesc(B_thresh)
% colorbar;colormap('jet')
% title('Recovered connections matrix')
% 
% subplot(1,2,2)
% 
% imagesc(C_gd)
% colorbar;colormap('jet')
% title('Coefficients matrix')
% 
% plot_qual_res(B_gd,C_gd)
str1 = strcat('/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/mod_2/ADOS_runs_mean_sub/workspace_qp_s_2_',num2str(net),'_net.mat');
save(str1)