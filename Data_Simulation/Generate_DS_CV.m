clearvars 
close all

load('/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/Data_Simulation/Real_Data_ADOS_median.mat')
fold = 10;

indices = crossvalind('Kfold',Y,fold);

for i = 1:fold
    test = (indices == i); train = ~test;
    Y_train{i} = Y(train);
    Y_test{i} = Y(test);
    corr_train{i} = corr(train,:,:);
    corr_test{i} = corr(test,:,:);
end

str1  = strcat('/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/data_',num2str(fold),'.mat');
save(str1)