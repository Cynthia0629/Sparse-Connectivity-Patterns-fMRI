clear all
close all
strrmi = '/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/Convex_Relaxation/SRS_Aut_CV/Bias/Sweep_reg_B';

clearvars -except strrmi
 
for  lambda_1 =[20,30]
     
    lambda=0.1;lambda_2 =1; lambda_3 =0.1; 
      f= 7; 
    
    pause on
    pause(0.1)
    clearvars -except f  lambda_1 lambda_2 lambda_3 lambda
    
    strrmi = '/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/Convex_Relaxation/SRS_Aut_CV/Bias/Sweep_reg_B';


    load(strcat(strrmi,'/workspace_out_',num2str(f),'_net_10_fold_',num2str(lambda_1),'_sparsity_', ...
        num2str(lambda_2),'_regC_',num2str(lambda_3),'_regW_',num2str(lambda),'_trad_test10.mat'))
    Y_test_pred = [];
    Y_test_meas = [];
    Y_train_pred = [];
    Y_train_meas = [];
    Y_train_est = [];
    strrmi = '/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/Convex_Relaxation/SRS_Aut_CV/Bias/Sweep_reg_B';
   

    for i = 1: size(Y_obt_test,2)
        Y_test_pred = horzcat(Y_test_pred,(Y_obt_test{i})');
        Y_train_pred = horzcat(Y_train_pred,(Y_obt_train{i})');
        Y_test_meas = horzcat(Y_test_meas,(Y_test{i})');
        Y_train_meas = horzcat(Y_train_meas,(Y_train{i})');
        Y_train_est = horzcat(Y_train_est,(Y_est_train{i})');
    end

    figure1  = figure;
    scatter(Y_train_meas',Y_train_pred','r')
    hold on;
    scatter(Y_test_meas',Y_test_pred','g')
    
    axis([min(Y_test_meas)-2 max(Y_test_meas)+2 min(Y_test_meas)-2 max(Y_test_meas)+2])
   
    stur =  strcat('Predictive Performance: Error',num2str(sqrt(mean(abs(Y_test_pred-Y_test_meas).^2/size(Y_test_meas,1)))));
    legend('test','train')
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
    axis([min(Y_train_meas)-2 max(Y_train_meas)+2 min(Y_train_meas)-2 max(Y_train_meas)+2])
    
    stur =  strcat('Predictive Performance: Error',num2str(sqrt((mean(abs(Y_train_meas-Y_train_est).^2/size(Y_train_est,1))))));
    
    legend('train estimated','train')
    title(stur)
    xlabel('Measured')
    ylabel('Predicted')
    
    str1 = strcat(strrmi,'/Plots/Pred_train_',num2str(f),'_net_10_fold_',num2str(lambda_1),'_sparsity_', ...
        num2str(lambda_2),'_regC_',num2str(lambda_3),'_regW_',num2str(lambda),'_trad','.jpg');
    saveas(figure2,str1)
    close all
end