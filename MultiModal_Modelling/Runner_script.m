clearvars -except net set seed
close all

my_path = '/home/niharika-shimona/Documents/Projects/Autism_Network/Sparse-Connectivity-Patterns-fMRI/MultiModal_Modelling/Simulated_Data_multimodal';
load(strcat(my_path,'.mat'))
m= 116;
% net =9;
net =4;
n = size(corr,1);
B_init = sprandn(m,net,0.4);
C_init =  abs(2*randn(net,size(Y,1)));

for i = 1:size(Y,1)
    D_init(i,:,:) = B_init*diag(C_init(:,i));
end

lamb_init = zeros(size(Y,1),m,net);
W_init =randn(net,1);

lr1 = 0.001; 
lambda = 1;
lambda_1 =10;
lambda_2 =0.2;
lambda_3 =1;


[B_gd,C_gd,W_gd,D_gd,lamb_gd] = gradient_descent_runner(corr,B_init,C_init,W_init,D_init,Y,lamb_init,Q,lambda,lambda_1,lambda_2,lambda_3,lr1);

save(strcat(my_path,'_set_',num2str(set),'_multimodal_','.mat'))