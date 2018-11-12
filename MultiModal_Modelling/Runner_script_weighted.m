clearvars -except lambda_2 thresh lambda_1 thresh_fl avg_fl
close all

fprintf('lambda_1: %f , lambda_2 : %f, thresh : %f ', lambda_1,lambda_2,thresh)

my_folder = strcat('/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/MultiModal_Modelling');
my_path = strcat('/Real_Data_DTI_fMRI_all');

load(strcat(my_folder,my_path,'.mat'))


if (thresh_fl)
Q = double(A_conn>thresh);
else
Q = A_conn.*double(A_conn>thresh);
end
corr = F_corr.*Q;

%parameters
lr1 = 0.001; 
lambda =0;
lambda_3 =0;
net=8;

m= size(corr,2);

B_init = sprandn(m,net,0.4);
B_avg_init = reshape(mean(corr,1),[size(corr,2),size(corr,3)]);
C_init =  abs(2*randn(net,size(corr,1)));

for i = 1:size(corr,1)
    D_init(i,:,:) = B_init*diag(C_init(:,i));
end

lamb_init = zeros(size(corr,1),m,net);
W_init =randn(net,1);

Y = rand(size(corr,1),1);

fprintf('sparsity: %f , reg C : %f, reg W : %f ', lambda_1,lambda_2,lambda_3)

if (avg_fl)
    
    [B_gd,B_avg_gd,C_gd,W_gd,D_gd,lamb_gd] = gradient_descent_runner_avg(corr,B_init,B_avg_init,C_init,W_init,D_init,Y,lamb_init,Q,lambda,lambda_1,lambda_2,lambda_3,lr1);
    
    if(thresh_fl)
        
       save(strcat(my_folder,'/Training_runs/Avg/Binary/','Thresh_',num2str(thresh),'/workspace_w_out_net_',num2str(net),'_sparsity_',num2str(lambda_1),'_regC_',num2str(lambda_2),'_regW_',num2str(lambda_3),'_trad_',num2str(lambda),'_out.mat'))
    
    else
    
       save(strcat(my_folder,'/Training_runs/Avg/Values/','Thresh_',num2str(thresh),'/workspace_w_out_net_',num2str(net),'_sparsity_',num2str(lambda_1),'_regC_',num2str(lambda_2),'_regW_',num2str(lambda_3),'_trad_',num2str(lambda),'_out.mat'))
    
    end
    
else
    
    [B_gd,C_gd,W_gd,D_gd,lamb_gd] = gradient_descent_runner(corr,B_init,C_init,W_init,D_init,Y,lamb_init,Q,lambda,lambda_1,lambda_2,lambda_3,lr1);

    if(thresh_fl)
        
       save(strcat(my_folder,'/Training_runs/Non_Avg/Binary/','Thresh_',num2str(thresh),'/workspace_w_out_net_',num2str(net),'_sparsity_',num2str(lambda_1),'_regC_',num2str(lambda_2),'_regW_',num2str(lambda_3),'_trad_',num2str(lambda),'_out.mat'))
    
    else
    
       save(strcat(my_folder,'/Training_runs/Non_Avg/Values/','Thresh_',num2str(thresh),'/workspace_w_out_net_',num2str(net),'_sparsity_',num2str(lambda_1),'_regC_',num2str(lambda_2),'_regW_',num2str(lambda_3),'_trad_',num2str(lambda),'_out.mat'))
    
    end
    
end
