clearvars 
close all

load('/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/Data_Simulation/Real_Data_SRS_aut_out_sub.mat')
fold = 58;

%manually exclude outliers
%A = (Y~=120&Y~=168&Y~=155&Y~=41&Y~=159&Y~=38&Y~=119&Y~=138&Y~=45);
Y_new =Y;
corr_new = corr(:,:,:);

indices = crossvalind('Kfold',Y_new,fold);

for i = 1:fold
%     test = (indices == i); train = ~test;
    mask =  logical(zeros(fold,1));mask(i)=1;
    Y_train{i} = Y_new(~mask);
    Y_test{i} = Y_new(mask);
    corr_train{i} = corr_new(~mask,:,:);
    corr_test{i} = corr_new(mask,:,:);
end

str1  = strcat('/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/data_out_',num2str(fold),'.mat');
save(str1)