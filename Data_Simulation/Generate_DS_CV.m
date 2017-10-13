clearvars 
close all

load('/home/niharika-shimona/Documents/Projects/Autism_Network/Sparse-Connectivity-Patterns-fMRI/Data_Simulation/Real_Data_SRSTotal_sub.mat')
fold = 10;

indices = crossvalind('Kfold',Y,fold);

for i = 1:fold
    test = (indices == i); train = ~test;
    Y_train{i} = Y(train);
    Y_test{i} = Y(test);
    corr_train{i} = corr(train,:,:);
    corr_test{i} = corr(test,:,:);
end

str1  = strcat('/home/niharika-shimona/Documents/Projects/Autism_Network/Sparse-Connectivity-Patterns-fMRI/data_',num2str(fold),'.mat');
save(str1)