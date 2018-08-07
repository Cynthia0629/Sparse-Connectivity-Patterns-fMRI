clear all
close all
strrmi = '/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/Convex_Relaxation/SRS_Aut_CV/Avg';

clearvars -except strrmi
 
for lambda_2 =0.2:0.2:2
    
    lambda=1;lambda_1=10; lambda_3 =1; 
    f =7; 
    
    pause on
    pause(0.1)
    clearvars -except f lambda_1 lambda_2 lambda_3 lambda
    
    strrmi = '/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/Convex_Relaxation/SRS_Aut_CV/Avg';


    load(strcat(strrmi,'/workspace_out_',num2str(f),'_net_10_fold_',num2str(lambda_1),'_sparsity_', ...
        num2str(lambda_2),'_regC_',num2str(lambda_3),'_regW_',num2str(lambda),'_trad.mat_test10.mat'))
   
    strrmi = '/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/Convex_Relaxation/SRS_Aut_CV/Avg';

    
%     Y_test_pred_aut = [];
%     Y_test_meas_aut = [];
%     Y_train_pred_aut = [];
%     Y_train_meas_aut = [];
%     Y_train_est_aut = [];
%     
%     Y_test_pred_cont = [];
%     Y_test_meas_cont = [];
%     Y_train_pred_cont = [];
%     Y_train_meas_cont = [];
%     Y_train_est_cont = [];
    
Y_test_pred = [];
Y_test_meas = [];
Y_train_pred = [];
Y_train_meas = [];
Y_train_est = [];
    
    for i = 1: size(Y_obt_test,2)
        Y_test_pred = horzcat(Y_test_pred,(Y_obt_test{i})');
        Y_train_pred = horzcat(Y_train_pred,(Y_obt_train{i})');
        Y_test_meas = horzcat(Y_test_meas,(Y_test{i})');
        Y_train_meas = horzcat(Y_train_meas,(Y_train{i})');
        Y_train_est = horzcat(Y_train_est,(Y_est_train{i})');
    end

%     for i = 1: size(Y_obt_test,2)
%         
%         cut_test = ceil(size(Y_obt_test{i},1)/2);
%         cut_train = ceil(size(Y_obt_train{i},1)/2);
%         
%         Y_test_pred_aut = horzcat(Y_test_pred_aut,(Y_obt_test{i}(1:cut_test))');
%         Y_train_pred_aut = horzcat(Y_train_pred_aut,(Y_obt_train{i}(1:cut_train))');
%         Y_test_meas_aut = horzcat(Y_test_meas_aut,(Y_test{i}(1:cut_test))');
%         Y_train_meas_aut = horzcat(Y_train_meas_aut,(Y_train{i}(1:cut_train))');
%         Y_train_est_aut = horzcat(Y_train_est_aut,(Y_est_train{i}(1:cut_train))');
%     
%         Y_test_pred_cont = horzcat(Y_test_pred_cont,(Y_obt_test{i}(cut_test+1:end))');
%         Y_train_pred_cont = horzcat(Y_train_pred_cont,(Y_obt_train{i}(cut_train+1:end))');
%         Y_test_meas_cont = horzcat(Y_test_meas_cont,(Y_test{i}(cut_test+1:end))');
%         Y_train_meas_cont = horzcat(Y_train_meas_cont,(Y_train{i}(cut_train+1:end))');
%         Y_train_est_cont = horzcat(Y_train_est_cont,(Y_est_train{i}(cut_train+1:end))');
%     
%     
%     end

    
%     Y_test_pred = horzcat(Y_test_pred_aut,Y_test_pred_cont);
%     Y_train_pred = horzcat(Y_train_pred_aut,Y_train_pred_cont);
%     Y_test_meas = horzcat(Y_test_meas_aut,Y_test_meas_cont);
%     Y_train_meas = horzcat(Y_train_meas_aut,Y_train_meas_cont);
%     Y_train_est = horzcat(Y_train_est_aut,Y_train_est_cont);
%     
    figure1  = figure;
     scatter(Y_train_meas',Y_train_pred','r')
%     scatter(Y_train_meas_aut',Y_train_pred_aut','r')
%     hold on;
%     scatter(Y_train_meas_cont',Y_train_pred_cont','r')
    hold on;
   scatter(Y_test_meas',Y_test_pred','g')
    
%     scatter(Y_test_meas_aut',Y_test_pred_aut','g')
%     hold on;
%     scatter(Y_test_meas_cont',Y_test_pred_cont','g')
    
%     axis([min(Y_test_meas)-2 max(Y_test_meas)+2 min(Y_test_meas)-2 max(Y_test_meas)+2])
   
    stur =  strcat('Predictive Performance: Error',num2str(sqrt(median(abs(Y_test_pred-Y_test_meas).^2))));
    legend('train','test')
    title(stur)
    xlabel('Measured')
    ylabel('Predicted')

    str1 = strcat(strrmi,'/Plots/Pred_test_',num2str(f),'_net_10_fold_',num2str(lambda_1),'_sparsity_', ...
        num2str(lambda_2),'_regC_',num2str(lambda_3),'_regW_',num2str(lambda),'_trad','.jpg');
    saveas(figure1,str1)
    close all;
    
    figure2  = figure;
  scatter(Y_train_meas',Y_train_est','b') 
  hold on;
   scatter(Y_train_meas',Y_train_pred','r') 

%     scatter(Y_train_meas_aut',Y_train_pred_aut','r')
%     hold on;
%     scatter(Y_train_meas_cont',Y_train_pred_cont','r')
%     hold on;
%     
%     scatter(Y_train_meas_aut',Y_train_est_aut','b')
%     hold on;
%     scatter(Y_train_meas_cont',Y_train_est_cont','b')
%  


% axis([min(Y_train_meas_)-2 max(Y_train_meas)+2 min(Y_train_meas)-2 max(Y_train_meas)+2])
    
    stur =  strcat('Predictive Performance: Error',num2str(sqrt((median(abs(Y_train_meas-Y_train_est).^2)))));
    
    legend('train estimated','train')
    title(stur)
    xlabel('Measured')
    ylabel('Predicted')
    
    str1 = strcat(strrmi,'/Plots/Pred_train_',num2str(f),'_net_10_fold_',num2str(lambda_1),'_sparsity_', ...
        num2str(lambda_2),'_regC_',num2str(lambda_3),'_regW_',num2str(lambda),'_trad','.jpg');
    saveas(figure2,str1)
    close all
end