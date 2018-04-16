
folder_run = '/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/Convex_Relaxation/';
fold =10;
load('/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/Data_Simulation/Real_Data_SRS_aut_out_sub.mat')
load(strcat(folder_run,'SRS_Aut_CV/data_out_10.mat'),'indices')

for i = 1:fold
    test = (indices == i); train = ~test;
    Y_train_aut{i} = Y(train);
    Y_test_aut{i} = Y(test);
    corr_train_aut{i} = corr(train,:,:);
    corr_test_aut{i} = corr(test,:,:);
    z_aut_train{i} =ones(size(Y_train_aut{i},1),1);
    z_aut_test{i} =ones(size(Y_test_aut{i},1),1);
end

%load(strcat(folder_run,'SRS_Aut_CV/workspace_',num2str(net),'_net_10_fold.mat'))

% B_gd_aut = B_gd;
% C_gd_aut =C_gd;
% W_gd_aut = W_gd;

load('/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/Data_Simulation/Real_Data_SRS_cont_out_sub.mat')
load(strcat(folder_run,'SRS_Cont_CV/data_out_10.mat'),'indices')

for i = 1:fold
    test = (indices == i); train = ~test;
    Y_train_cont{i} = Y(train);
    Y_test_cont{i} = Y(test);
    corr_train_cont{i} = corr(train,:,:);
    corr_test_cont{i} = corr(test,:,:);
    
    z_cont_train{i} =zeros(size(Y_train_cont{i},1),1);
    z_cont_test{i} =zeros(size(Y_test_cont{i},1),1);
end

%load(strcat(folder_run,'SRS_Cont_CV/workspace_',num2str(net),'_net_10_fold.mat'))

% B_gd_cont = B_gd;
% C_gd_cont =C_gd;
% W_gd_cont = W_gd;
 
for i  = 1:fold
    Y_train{i} = vertcat(Y_train_aut{i},Y_train_cont{i});
    Y_test{i} = vertcat(Y_test_aut{i},Y_test_cont{i});
    corr_train{i} = vertcat(corr_train_aut{i},corr_train_cont{i});
    corr_test{i} = vertcat(corr_test_aut{i},corr_test_cont{i});
    z_train{i} = vertcat(z_aut_train{i},z_cont_train{i});
    z_test{i} = vertcat(z_aut_test{i},z_cont_test{i});
%     B_gd_init{i} = horzcat(B_gd_aut{i},B_gd_cont{i});
%     C_gd_init_aut{i} = horzcat(C_gd_aut{i},zeros(size(C_gd_cont{i})));
%     C_gd_init_cont{i} = horzcat(zeros(size(C_gd_aut{i})),C_gd_cont{i});
%     C_gd_init{i} = vertcat(C_gd_init_aut{i},C_gd_init_cont{i});
%     W_gd_init{i} = vertcat(W_gd_aut{i},W_gd_cont{i});
end

save(strcat(folder_run,'SRS_CA_CV/data_out_10','.mat'),'Y_test','Y_train','corr_train','corr_test','z_train','z_test')
