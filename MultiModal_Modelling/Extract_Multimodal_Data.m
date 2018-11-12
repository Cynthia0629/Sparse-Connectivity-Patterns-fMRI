        
clearvars -except 
%% Parameters 
 
P = 86;
N = 39;
K = 8;

lambda_2 = 0.2;
lambda_1 = 20;
net =8;
lambda=0;
lambda_3=0;

for thresh = 0:0.2:0.4
%% Inferring C , simulating W and Y

        folder_name = strcat('/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/MultiModal_Modelling/Training_runs/Avg/Binary/Thresh_',num2str(thresh));
        filename = strcat(folder_name,'/workspace_out_net_',num2str(net),'_sparsity_',num2str(lambda_1),'_regC_',num2str(lambda_2),'_regW_',num2str(lambda_3),'_trad_',num2str(lambda),'_out');
        
        load(strcat(filename,'.mat'))
%         B_avg =B_avg_gd;
        B=B_gd;
        C=C_gd;
        B_avg=B_avg_gd;
        
        sigma_w = 2*ones(K,1);
        mu_w = zeros(K,1);
        sigma_y = 0.2*ones(N,1);

        W = abs(normrnd(mu_w,sigma_w));
        Y = normrnd(C'*W,sigma_y.*(C'*W));
        

        my_path = strcat('/thresh_',num2str(thresh),'_multimodal');

        strname = strcat(filename,'_sim.mat');
        save(strname,'B','C','B_avg','Y','W','corr','Q')

end


