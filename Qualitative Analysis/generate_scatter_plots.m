strrm = '/home/niharika-shimona/Documents/Projects/Autism_Network/Results/Sparse connectivity patterns/10_fold_CV_new/mod_3/SRS_CA_CV_eq';

for f =16:19
    clearvars -except f strrm
    load(strcat(strrm,'/workspace_',num2str(f),'_net_10_fold_testC10'))
    Y_test_pred = [];
    Y_test_meas = [];
    Y_train_pred = [];
    Y_train_meas = [];
    Y_train_est = [];
   

    for i = 1: size(Y_obt_test,2)
        Y_test_pred = horzcat(Y_test_pred,(Y_obt_test{i}(size(Y_obt_test{i},1)/2 +1:end))');
        Y_train_pred = horzcat(Y_train_pred,(Y_obt_train{i}(size(Y_obt_train{i},1)/2 +1:end))');
        Y_test_meas = horzcat(Y_test_meas,(Y_test{i}(size(Y_obt_test{i},1)/2 +1:end))');
        Y_train_meas = horzcat(Y_train_meas,(Y_train{i}(size(Y_obt_train{i},1)/2 +1:end))');
        Y_train_est = horzcat(Y_train_est,(Y_est_train{i}(size(Y_obt_train{i},1)/2 +1:end))');
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

    str1 = strcat(strrm,'/Plots/C_Predictive_performance_cont_',num2str(f),'.jpg');
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
    
    str1 = strcat(strrm,'/Plots/C_Predictive_performance_recovered_train_cont_',num2str(f),'.jpg');
    saveas(figure2,str1)
    
end