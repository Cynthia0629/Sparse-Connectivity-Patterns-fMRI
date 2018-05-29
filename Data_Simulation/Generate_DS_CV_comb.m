clearvars 
close all

load('/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/Data_Simulation/Real_Data_ADOS_out_sub.mat')
fold = 10;

indices = crossvalind('Kfold',Y,fold);

for i = 1:fold
    test = (indices == i); train = ~test;
    Y_ADOS_train{i} = Y(train);
    Y_ADOS_test{i} = Y(test);
    corr_train{i} = corr(train,:,:);
    corr_test{i} = corr(test,:,:);
end


load('/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/Data_Simulation/Real_Data_SRS_aut_out_sub.mat')
for i = 1:fold
    test = (indices == i); train = ~test;
    Y_SRS_train{i} = Y(train);
    Y_SRS_test{i} = Y(test);
%     corr_train_cont{i} = corr(train,:,:);
%     corr_test_cont{i} = corr(test,:,:);
end


% for i  = 1:fold
%     Y_train{i} = vertcat(Y_train_aut{i},Y_train_cont{i});
%     Y_test{i} = vertcat(Y_test_aut{i},Y_test_cont{i});
%     corr_train{i} = vertcat(corr_train_aut{i},corr_train_cont{i});
%     corr_test{i} = vertcat(corr_test_aut{i},corr_test_cont{i});
%     
% end

str1  = strcat('/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/data_',num2str(fold),'.mat');
save(str1)