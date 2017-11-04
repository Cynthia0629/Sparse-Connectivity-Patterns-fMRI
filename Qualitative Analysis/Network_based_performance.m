close all
clear all

strrm = '/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/mod_2/SRS_Cont_CV/';

N_M =6:25;

for f = N_M
    
    clearvars -except f strrm N_M error_train_avg error_train_est_avg error_test_avg
    load(strcat(strrm,'/workspace_',num2str(f),'_net_10_fold_test10.mat'))
    
    corr_test_error = 0;
    corr_train_est_error =0;
    corr_train_error =0;
    
    
%     for i=1:size(B_gd,2)
%        
%         corr_test_error = 0;
%         corr_train_est_error =0;
%         corr_train_error =0;
%     
%         for j = 1: size(C_gd_train{i},2)
%            
%            subj_corr= reshape(corr_train{i}(j,:,:),[size(corr_train{i},2),size(corr_train{i},3)]);
%            corr_train_est_error = corr_train_est_error + norm(subj_corr-(B_gd{i}*diag(C_gd_train{i}(:,j))*B_gd{i}'),'fro');
%            corr_train_error = corr_train_error + norm(subj_corr-(B_gd{i}*diag(C_gd{i}(:,j))*B_gd{i}'),'fro');
%            
%         end
%         
%         for k = 1: size(C_gd_test{i},2)
%            subj_corr= reshape(corr_test{i}(k,:,:),[size(corr_test{i},2),size(corr_test{i},3)]);
%            corr_test_error = corr_test_error + norm(subj_corr-(B_gd{i}*diag(C_gd_test{i}(:,k))*B_gd{i}'),'fro');
%            
%         end
%         
%         Tcorr_test_error(i) =corr_test_error/k;
%         Tcorr_train_est_error(i) =corr_train_est_error/j;
%         Tcorr_train_error(i) =corr_train_error/j;
%     
%        
%     end
%     
%     
%     
%     error_train_avg(f-N_M(1)+1) = mean(Tcorr_train_error);
%     error_train_est_avg(f-N_M(1)+1) = mean(Tcorr_train_est_error);
%     error_test_avg(f-N_M(1)+1) = mean(Tcorr_test_error);
%     
    error_train_avg(f-N_M(1)+1) = mean(error_train);
    error_train_est_avg(f-N_M(1)+1) = mean(error_train_est);
    error_test_avg(f-N_M(1)+1) = mean(error_test);
    
end

figure2  = figure;
plot(N_M,error_train_avg,'b') 

hold on;
plot(N_M,error_train_est_avg,'r')

hold on;
plot(N_M,error_test_avg,'g')
   
legend('train','train estimated','test')
title('Recovery performance over dataset')
xlabel('No of networks')
ylabel('Average 10 fold CV error')
    
str1 = strcat(strrm,'/Plots/Overall_Performance.jpg');
saveas(figure2,str1)