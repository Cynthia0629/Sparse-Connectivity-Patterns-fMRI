folder = '/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/Data_Simulation/' ;

str1 = strcat(folder,'Real_Data_SRSTotal_cont');

load(strcat(str1,'.mat'))


for i  = 1:size(corr,1)
   % corr(i,:,:) = corr(i,:,:) - mean(mean(corr(i,:,:)))*ones(1,size(corr,2),size(corr,3));
    mean_val(i) = mean(mean(corr(i,:,:)));
    median_val(i) = median(reshape(corr(i,:,:),[116*116,1]));
    mode_val(i) = mode(reshape(corr(i,:,:),[116*116,1]));
    
    corr_mat = reshape(corr(i,:,:),[116,116]);
    mask = (1- diag(ones(size(corr,2),1)));
    ut = nonzeros(triu(mask.*corr_mat)'); 
    
    [~,D] = eig(corr_mat);
    d1(i) = D(end, end);
    mean_val_ut(i) = mean(ut);
    median_val_ut(i) = median(ut);
    mode_val_ut(i) = mode(ut);
   
    
    h = histogram(reshape(corr(i,:,:),[116,116]),50);
    val(i) = mean(h.BinLimits);
    
    h = histogram(ut,50);
    val_ut(i) = mean(h.BinLimits);
end

% str2 = strcat(str1,'_mean_sub.mat');
% save(str2,'corr','Y')
