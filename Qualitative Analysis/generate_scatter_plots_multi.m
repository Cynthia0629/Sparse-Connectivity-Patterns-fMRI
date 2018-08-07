clear all
close all
strrmi = '/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/Convex_Relaxation/Praxis_ADOS_CV';

clearvars -except strrmi
 
for lambda_2 = 0.2:0.2:1
        
    lambda=1;lambda_1=20; lambda_3 =1; 
    f =7; 
    
    pause on
    pause(0.1)
    clearvars -except f lambda_1 lambda_2 lambda_3 lambda
    
    strrmi = '/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/Convex_Relaxation/Praxis_ADOS_CV';


    load(strcat(strrmi,'/workspace_out_',num2str(f),'_net_10_fold_',num2str(lambda_1),'_sparsity_', ...
        num2str(lambda_2),'_regC_',num2str(lambda_3),'_regW_',num2str(lambda),'_trad_test10.mat'))
   
    strrmi = '/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/Convex_Relaxation/Praxis_ADOS_CV';

 Y_ADOS_test_pred = [];
 Y_ADOS_test_meas = [];
 Y_ADOS_train_pred = [];
 Y_ADOS_train_meas = [];
 Y_ADOS_train_est = [];
    
    for i = 1: size(Y_ADOS_obt_test,2)
        Y_ADOS_test_pred = horzcat(Y_ADOS_test_pred,(Y_ADOS_obt_test{i})');
        Y_ADOS_train_pred = horzcat(Y_ADOS_train_pred,(Y_ADOS_obt_train{i})');
        Y_ADOS_test_meas = horzcat(Y_ADOS_test_meas,(Y_ADOS_test{i})');
        Y_ADOS_train_meas = horzcat(Y_ADOS_train_meas,(Y_ADOS_train{i})');
        Y_ADOS_train_est = horzcat(Y_ADOS_train_est,(Y_ADOS_est_train{i})');
    end

    figure1  = figure;
     scatter(Y_ADOS_train_meas',Y_ADOS_train_pred','r')
    hold on;
    scatter(Y_ADOS_test_meas',Y_ADOS_test_pred','g')
    
    stur =  strcat('Predictive Performance: Error',num2str(sqrt(median(abs(Y_ADOS_test_pred-Y_ADOS_test_meas).^2))));
    legend('test','train')
    title(stur)
    xlabel('Measured')
    ylabel('Predicted')

    str1 = strcat(strrmi,'/Plots/Pred_test_ADOS_',num2str(f),'_net_10_fold_',num2str(lambda_1),'_sparsity_', ...
        num2str(lambda_2),'_regC_',num2str(lambda_3),'_regW_',num2str(lambda),'_trad','.jpg');
    saveas(figure1,str1)
    close all;
    
    figure2  = figure;
   scatter(Y_ADOS_train_meas',Y_ADOS_train_pred','r') 

    hold on;
   scatter(Y_ADOS_train_meas',Y_ADOS_train_est','b') 
 
    
   
    Y_SRS_test_pred = [];
    Y_SRS_test_meas = [];
    Y_SRS_train_pred = [];
    Y_SRS_train_meas = [];
    Y_SRS_train_est = [];
    
    for i = 1: size(Y_SRS_obt_test,2)
        Y_SRS_test_pred = horzcat(Y_SRS_test_pred,(Y_SRS_obt_test{i})');
        Y_SRS_train_pred = horzcat(Y_SRS_train_pred,(Y_SRS_obt_train{i})');
        Y_SRS_test_meas = horzcat(Y_SRS_test_meas,(Y_SRS_test{i})');
        Y_SRS_train_meas = horzcat(Y_SRS_train_meas,(Y_SRS_train{i})');
        Y_SRS_train_est = horzcat(Y_SRS_train_est,(Y_SRS_est_train{i})');
    end
    stur =  strcat('Predictive Performance: Error',num2str(sqrt((median(abs(Y_SRS_train_meas-Y_SRS_train_est).^2)))));
    
    legend('train estimated','train')
    title(stur)
    xlabel('Measured')
    ylabel('Predicted')
    
    str1 = strcat(strrmi,'/Plots/Pred_train_ADOS_',num2str(f),'_net_10_fold_',num2str(lambda_1),'_sparsity_', ...
        num2str(lambda_2),'_regC_',num2str(lambda_3),'_regW_',num2str(lambda),'_trad','.jpg');
    saveas(figure2,str1)
    close all

    
    
    figure1  = figure;

    scatter(Y_SRS_train_meas',Y_SRS_train_pred','r')
    hold on;
    scatter(Y_SRS_test_meas',Y_SRS_test_pred','g')
       
    stur =  strcat('Predictive Performance: Error',num2str(sqrt(median(abs(Y_SRS_test_pred-Y_SRS_test_meas).^2))));
    legend('test','train')
    title(stur)
    xlabel('Measured')
    ylabel('Predicted')

    str1 = strcat(strrmi,'/Plots/Pred_test_SRS_',num2str(f),'_net_10_fold_',num2str(lambda_1),'_sparsity_', ...
        num2str(lambda_2),'_regC_',num2str(lambda_3),'_regW_',num2str(lambda),'_trad','.jpg');
    saveas(figure1,str1)
    close all;
    
    figure2  = figure;

    scatter(Y_SRS_train_meas',Y_SRS_train_pred','r')
    hold on;
    scatter(Y_SRS_train_meas',Y_SRS_train_est','b')    

 
% axis([min(Y_train_meas_)-2 max(Y_train_meas)+2 min(Y_train_meas)-2 max(Y_train_meas)+2])
    
    stur =  strcat('Predictive Performance: Error',num2str(sqrt((median(abs(Y_SRS_train_meas-Y_SRS_train_est).^2)))));
    
    legend('train estimated','train')
    title(stur)
    xlabel('Measured')
    ylabel('Predicted')
    
    str1 = strcat(strrmi,'/Plots/Pred_train_SRS_',num2str(f),'_net_10_fold_',num2str(lambda_1),'_sparsity_', ...
        num2str(lambda_2),'_regC_',num2str(lambda_3),'_regW_',num2str(lambda),'_trad','.jpg');
    saveas(figure2,str1)
    close all
end