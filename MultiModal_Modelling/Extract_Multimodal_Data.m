clearvars -except B_gd
%% Parameters 
 
P = 86;
N = 39;
K = 8;

lambda_2 = 0.2;

for p = 80
    for thresh = 0:0.2:0.4
        
        net_ind_1 = randsample(P,p*K,true);
        net_ind = reshape(net_ind_1,[],K);

        sigma_B = 0.2* ones(P,K);
        mu_B = zeros(P,K);

        B = normrnd(mu_B,sigma_B);
 
        for k = 1:K
     
            nz_ind = net_ind(:,k);
            b_k = ones(P,1);
            b_k(nz_ind,:) = 0;
            B(:,k) = B(:,k).*b_k;
     
        end


%         load('/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/MultiModal_Modelling/Overlap_80_reg_C_0.2/thresh_0_multimodal_sparsity_10_regC_0.2_regW_0_out.mat')
%         B = B_gd;
        
%% Inferring C , simulating W and Y

        load('/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/MultiModal_Modelling/Real_Data_DTI_fMRI_all.mat')

        Q_conn = double(A_conn);
        C = quad_estimate_C_multimodal(B,lambda_2,F_corr,Q_conn);

        sigma_w = 0.5*ones(K,1);
        mu_w = zeros(K,1);
        sigma_y = ones(N,1);

        W = abs(normrnd(mu_w,sigma_w));
        Y = normrnd(C'*W,sigma_y);

        corr = F_corr;
        Q = double(A_conn>thresh);

        my_folder = strcat('/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/MultiModal_Modelling/Values_corr_',num2str(p),'_reg_C_',num2str(lambda_2));

        if ~exist(my_folder, 'dir')
            mkdir(my_folder)
        end

        my_path = strcat('/thresh_',num2str(thresh),'_multimodal');

        strname = strcat(my_folder,my_path,'.mat');
        save(strname,'B','C','Y','W','corr','Q')

    end
end

