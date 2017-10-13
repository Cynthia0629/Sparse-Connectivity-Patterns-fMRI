strrm = '/home/niharika-shimona/Documents/Projects/Autism_Network/Results/Sparse connectivity patterns/10_fold_CV_new/SRS_CA_CV/C0.01';

for f = 10:11
    clearvars -except f strrm
    load(strcat(strrm,'/workspace_',num2str(f),'_net_10_fold_testC10'))
    Y_test_pred = [];
    Y_test_meas = [];
    Y_train_pred = [];
    Y_train_meas = [];
    Y_train_est = [];
   

    for i = 1: size(Y_obt_test,2)
        Y_test_pred = horzcat(Y_test_pred,Y_obt_test{i}');
        Y_train_pred = horzcat(Y_train_pred,Y_obt_train{i}');
        Y_test_meas = horzcat(Y_test_meas,Y_test{i}');
        Y_train_meas = horzcat(Y_train_meas,Y_train{i}');
        Y_train_est = horzcat(Y_train_est,Y_est_train{i}');
    end

    figure1  = figure;

    scatter(Y_test_meas',Y_test_pred','g')
    hold on;
    scatter(Y_train_meas',Y_train_pred','r')
   
    legend('test','train')
    title('Predictive Performance')
    xlabel('Measured')
    ylabel('Predicted')

    str1 = strcat(strrm,'/Plots/C_Predictive_performance_',num2str(f),'.jpg');
    saveas(figure1,str1)
    close all;
    
    figure2  = figure;
    scatter(Y_train_meas',Y_train_est','b') 
    hold on;
    scatter(Y_train_meas',Y_train_pred','r')
   
    legend('train estimated','train')
    title('Predictive Performance')
    xlabel('Measured')
    ylabel('Predicted')
    
    str1 = strcat(strrm,'/Plots/C_Predictive_performance_recovered_train_',num2str(f),'.jpg');
    saveas(figure2,str1)
    
end