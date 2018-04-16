close all
clear all

f = 6;
fold = 10;

str = '/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/Testing First Pass/SRS_Aut_CV';
load(strcat(str,'/workspace_',num2str(f),'_net_10_test',num2str(fold),'.mat'))
fprintf(str)
fprintf('\n')

b_mag = zeros(size(B_thresh,2),f);

for i = 1:size(B_thresh,2)
    
    b_mag(i,:) = sqrt(sum(B_thresh{i}.*B_thresh{i}));
    
end

sim_mat = zeros(size(B_thresh,2),size(B_thresh,2));

corr_full = corr ;
clear corr

for i = 1:size(B_thresh,2)
    
    low1 = find(b_mag(i,:)== min(b_mag(i,:)));
    
    for j = 1: size(B_thresh,2)
        
        low2 = find(b_mag(j,:)== min(b_mag(j,:)));
        val1 = corr(double(B_thresh{i}(:,low1)),double(B_thresh{j}(:,low2)),'type','Pearson');
        val2 = corr(double(B_thresh{i}(:,low1)),-double(B_thresh{j}(:,low2)),'type','Pearson');
        ind = val1>val2;
        sim_mat(i,j) = (val1.*ind)+(val2.*~ind);
    end
end

figure;
imagesc(sim_mat);
colormap('jet')
colorbar;
title('Similarity in recovered sparse network')
