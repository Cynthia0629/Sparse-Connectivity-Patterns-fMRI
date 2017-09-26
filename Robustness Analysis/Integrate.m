clear all
close all 

net = 6;
strr = '/home/niharika-shimona/Documents/Projects/Autism_Network/Results/Sparse connectivity patterns/CV_Parallel/ADOS_CV';

load(strcat(strr,'/workspace_',num2str(net),'_net_66_part_5.mat'));

B_gd_store = B_gd;
C_gd_store = C_gd;
W_gd_store = W_gd;
corr_test_store = corr_test;
corr_train_store = corr_train;
B_thresh_store = B_thresh;

Y_test_store =Y_test;
Y_train_store =Y_train;

clearvars -except net W_gd_store corr_test_store corr_train_store B_gd_store C_gd_store Y_test_store Y_train_store B_thresh_store strr
 
load(strcat(strr,'/workspace_',num2str(net),'_net_66_part_4.mat'));

for i = 46:60
   
    B_gd_store{i} = B_gd{i};
    C_gd_store{i} = C_gd{i};
    B_thresh_store{i} = B_thresh{i};
    W_gd_store{i} = W_gd{i};
    corr_test_store{i} = corr_test{i};
    corr_train_store{i} = corr_train{i};
    Y_test_store{i} =Y_test{i};
    Y_train_store{i} =Y_train{i};
end

clearvars -except net W_gd_store corr_test_store corr_train_store B_gd_store C_gd_store Y_test_store Y_train_store B_thresh_store strr

load(strcat(strr,'/workspace_',num2str(net),'_net_66_part_3.mat'));

for i = 31:45
 
    B_gd_store{i} = B_gd{i};
    C_gd_store{i} = C_gd{i};
    B_thresh_store{i} = B_thresh{i};
    W_gd_store{i} = W_gd{i};
    corr_test_store{i} = corr_test{i};
    corr_train_store{i} = corr_train{i};
    Y_test_store{i} =Y_test{i};
    Y_train_store{i} =Y_train{i};
end


clearvars -except net W_gd_store corr_test_store corr_train_store except B_gd_store C_gd_store Y_test_store Y_train_store B_thresh_store strr

load(strcat(strr,'/workspace_',num2str(net),'_net_66_part_2.mat'));

for i = 16:30
   
    B_gd_store{i} = B_gd{i};
    C_gd_store{i} = C_gd{i};
    B_thresh_store{i} = B_thresh{i};
    W_gd_store{i} = W_gd{i};
    corr_test_store{i} = corr_test{i};
    corr_train_store{i} = corr_train{i};
    
    Y_test_store{i} =Y_test{i};
    Y_train_store{i} =Y_train{i};
end

clearvars -except net W_gd_store corr_test_store corr_train_store B_gd_store C_gd_store Y_test_store Y_train_store B_thresh_store strr

load(strcat(strr,'/workspace_',num2str(net),'_net_66_part_1.mat'));

for i = 1:15
   
    B_gd_store{i} = B_gd{i};
    C_gd_store{i} = C_gd{i};
    B_thresh_store{i} = B_thresh{i};
    corr_test_store{i} = corr_test{i};
    W_gd_store{i} = W_gd{i};
    corr_train_store{i} = corr_train{i};
    Y_test_store{i} =Y_test{i};
    Y_train_store{i} =Y_train{i};
end

clearvars -except net W_gd_store corr_test_store corr_train_store B_gd_store C_gd_store Y_test_store Y_train_store B_thresh_store strr

save(strcat(strr,'/workspace_',num2str(net),'_net_66_rec.mat'))