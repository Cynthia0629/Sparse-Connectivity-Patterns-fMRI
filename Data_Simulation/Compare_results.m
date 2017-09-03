clearvars -except n
close all

str1 = strcat('/home/niharika-shimona/Documents/Projects/Autism_Network/Sparse-Connectivity-Patterns-fMRI/ADOS_runs/workspace_qp_',num2str(n),'_net.mat');
load(str1)

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