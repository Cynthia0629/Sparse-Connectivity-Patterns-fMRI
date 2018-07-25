clearvars -except lambda_2 p thresh lambda_1
close all

fprintf('overlap: %d , lambda_2 : %f, thresh : %f ', p,lambda_2,thresh)

my_folder = strcat('/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/MultiModal_Modelling/Overlap_corr_',num2str(p),'_reg_C_',num2str(lambda_2));
my_path = strcat('/thresh_',num2str(thresh),'_multimodal');

load(strcat(my_folder,my_path,'.mat'))

m= 86;
% net =9;
net =8;
n = size(corr,1);
B_init = sprandn(m,net,0.4);
B_avg_init = reshape(mean(corr,1),[size(corr,2),size(corr,3)]);
C_init =  abs(2*randn(net,size(Y,1)));

for i = 1:size(Y,1)
    D_init(i,:,:) = B_init*diag(C_init(:,i));
end

lamb_init = zeros(size(Y,1),m,net);
W_init =randn(net,1);

lr1 = 0.001; 
lambda =0;
%lambda_1 =0.1;
% lambda_2 =0.01;
lambda_3 =0;

fprintf('sparsity: %f , reg C : %f, reg W : %f ', lambda_1,lambda_2,lambda_3)


% [B_gd,C_gd,W_gd,D_gd,lamb_gd] = gradient_descent_runner(corr,B_init,C_init,W_init,D_init,Y,lamb_init,Q,lambda,lambda_1,lambda_2,lambda_3,lr1);
[B_gd,B_avg_gd,C_gd,W_gd,D_gd,lamb_gd] = gradient_descent_runner_avg(corr,B_init,B_avg_init,C_init,W_init,D_init,Y,lamb_init,Q,lambda,lambda_1,lambda_2,lambda_3,lr1);

save(strcat(my_folder,my_path,'_avg_sparsity_',num2str(lambda_1),'_regC_',num2str(lambda_2),'_regW_',num2str(lambda_3),'_out','.mat'))
