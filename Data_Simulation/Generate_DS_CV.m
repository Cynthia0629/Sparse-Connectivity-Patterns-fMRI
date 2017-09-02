clearvars 
close all

load('/home/niharika-shimona/Documents/Projects/Autism_Network/Sparse-Connectivity-Patterns-fMRI/Data_Simulation/Real_Data_ADOS_sub.mat')

indices = crossvalind('Kfold',Y,10);

for i = 1:10
    test = (indices == i); train = ~test;
    Y_train{i} = Y(train);
    Y_test{i} = Y(test);
    corr_train{i} = corr(train,:,:);
    corr_test{i} = corr(test,:,:);
end

save('/home/niharika-shimona/Documents/Projects/Autism_Network/Sparse-Connectivity-Patterns-fMRI/ADOS_CV/data.mat')