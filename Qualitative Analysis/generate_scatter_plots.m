strrm = '/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/baseline/SRS_Cont_mean_CV';

for f =6:17
    
    pause on
    pause(0.1)
    clearvars -except f strrm
    load(strcat(strrm,'/workspace_non_neg_2_',num2str(f),'_net_10_fold_testC10'))
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

    figure1  = figure;

    scatter(Y_test_meas',Y_test_pred','g')
    hold on;
    scatter(Y_train_meas',Y_train_pred','r')
   
    stur =  strcat('Predictive Performance: Error',num2str(mean(error_test)));
    legend('test','train')
    title(stur)
    xlabel('Measured')
    ylabel('Predicted')

    str1 = strcat(strrm,'/Plots/C_Predictive_performance',num2str(f),'.jpg');
    saveas(figure1,str1)
    close all;
    
    figure2  = figure;
    scatter(Y_train_meas',Y_train_est','b') 
    hold on;
    scatter(Y_train_meas',Y_train_pred','r')
   
    stur =  strcat('Predictive Performance: Error',num2str(mean(error_train_est)));
    
    legend('train estimated','train')
    title(stur)
    xlabel('Measured')
    ylabel('Predicted')
    
    str1 = strcat(strrm,'/Plots/C_Predictive_performance_recovered_train',num2str(f),'.jpg');
    saveas(figure2,str1)
    close all
end

clearvars -except strrm 

for f =6:17
    
    pause on
    pause(0.1)
    clearvars -except f strrm
    load(strcat(strrm,'/workspace_non_neg_2_',num2str(f),'_net_10_fold_test10'))
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

    figure1  = figure;

    scatter(Y_test_meas',Y_test_pred','g')
    hold on;
    scatter(Y_train_meas',Y_train_pred','r')
   
    stur =  strcat('Predictive Performance: Error',num2str(mean(error_test)));
    legend('test','train')
    title(stur)
    xlabel('Measured')
    ylabel('Predicted')

    str1 = strcat(strrm,'/Plots/Predictive_performance',num2str(f),'.jpg');
    saveas(figure1,str1)
    close all;
    
    figure2  = figure;
    scatter(Y_train_meas',Y_train_est','b') 
    hold on;
    scatter(Y_train_meas',Y_train_pred','r')
   
    stur =  strcat('Predictive Performance: Error',num2str(mean(error_train_est)));
    
    legend('train estimated','train')
    title(stur)
    xlabel('Measured')
    ylabel('Predicted')
    
    str1 = strcat(strrm,'/Plots/Predictive_performance_recovered_train',num2str(f),'.jpg');
    saveas(figure2,str1)
    close all
end