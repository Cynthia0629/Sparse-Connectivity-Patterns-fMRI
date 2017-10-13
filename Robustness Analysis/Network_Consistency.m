close all
clear all
fold = 10;

for f = 10:11
    strrm = '/home/niharika-shimona/Documents/Projects/Autism_Network/Results/Sparse connectivity patterns/10_fold_CV_new/SRS_CA_CV/C0.01';
    clearvars -except strrm f fold
    load(strcat(strrm,'/workspace_',num2str(f),'_net_10_fold_testC10','.mat'))
    fprintf(strrm)
    fprintf('\n')

    b_mag = zeros(size(B_gd,2),f);

    for i = 1:size(B_gd,2)

        b_mag(i,:) = sqrt(sum(B_gd{i}.*B_gd{i}));

    end

    sim_mat = zeros(size(B_thresh,2),size(B_thresh,2));
    sim_mat2 = zeros(size(B_thresh,2),size(B_thresh,2));

    corr_full = corr ;
    clear corr

    for i = 1:size(B_thresh,2)

        low1 = find(b_mag(i,:)== min(b_mag(i,:)),1);

        for j = 1: size(B_thresh,2)

            low2 = find(b_mag(j,:)== min(b_mag(j,:)),1);
            val1 = corr(double(B_gd{i}(:,low1)),double(B_gd{j}(:,low2)),'type','Pearson');
            val2 = corr(double(B_gd{i}(:,low1)),-double(B_gd{j}(:,low2)),'type','Pearson');
            ind = val1>val2;
            sim_mat(i,j) = (val1.*ind)+(val2.*~ind);
        end
    end

%     for i = 1:size(C_gd,2)
% 
%         low1 = find(b_mag(i,:)== min(b_mag(i,:)));
% 
%         for j = 1: size(C_gd,2)
% 
%             low2 = find(b_mag(j,:)== min(b_mag(j,:)));
%             val1 = corr(double(C_gd{i}(low1,:))',double(C_gd{j}(low2,:))','type','Pearson');
%             val2 = corr(double(C_gd{i}(low1,:))',-double(C_gd{j}(low2,:))','type','Pearson');
%             ind = val1>val2;
%             sim_mat2(i,j) = (val1.*ind)+(val2.*~ind);
%         end
%     end


    figure1 = figure;
%     subplot(1,2,1)
    imagesc(sim_mat);
    colormap('jet')
    colorbar;
    title('Similarity in B')

%     subplot(1,2,2)
%     imagesc(sim_mat2);
%     colormap('jet')
%     colorbar;
%     title('Similarity in C')

    str1 = strcat(strrm,'/Similarity/Robustness_matrix_',num2str(f),'.jpg');
    saveas(figure1,str1)
    close all
    
end