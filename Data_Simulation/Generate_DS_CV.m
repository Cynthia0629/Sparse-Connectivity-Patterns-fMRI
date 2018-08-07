clearvars 
close all
for  en = 2:10

    str = strcat('/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/Schizophrenia/Real_Data_beta7_c_eigsub_',num2str(en));

    load(str)
    fold = 10;

%manually exclude outliers
%A = (Y~=120&Y~=168&Y~=155&Y~=41&Y~=159&Y~=38&Y~=119&Y~=138&Y~=45);
    Y_new =Y;
    corr_new = corr(:,:,:);

    indices = crossvalind('Kfold',Y_new,fold);

    for i = 1:fold
        test = (indices == i); train = ~test;
%     mask =  logical(zeros(fold,1));mask(i)=1;
        Y_train{i} = Y_new(train);
        Y_test{i} = Y_new(test);
        corr_train{i} = corr_new(train,:,:);
        corr_test{i} = corr_new(test,:,:);
     end




% load('/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/Schizophrenia/Real_Data_beta7_c_sub.mat')
% Y_new =Y;
% corr_new = corr(:,:,:);
% 
% for i = 1:fold
%     test = (indices == i); train = ~test;
% %     mask =  logical(zeros(fold,1));mask(i)=1;
%     Y_train{i} = vertcat(Y_train{i},Y_new(train));
%     Y_test{i} = vertcat(Y_test{i},Y_new(test));
%     corr_train{i} = vertcat(corr_train{i},corr_new(train,:,:));
%     corr_test{i} = vertcat(corr_test{i},corr_new(test,:,:));
% end

     str1  = strcat('/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/Eig',num2str(en),'/data_',num2str(fold),'.mat');
     save(str1)
end