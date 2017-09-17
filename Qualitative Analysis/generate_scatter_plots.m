strr = '/home/niharika-shimona/Documents/Projects/Autism_Network/Results/Sparse connectivity patterns/CV_Parallel/ADOS_CV/';

for f = 10
    clearvars -except f strr
    load(strcat(strr,'/workspace_',num2str(f),'_net_66_rec_test66'))
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

    str1 = strcat(strr,'/Plots/Predictive_performance_',num2str(f),'.jpg');
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
    
    str1 = strcat(strr,'/Plots/Predictive_performance_recovered_train_',num2str(f),'.jpg');
    saveas(figure2,str1)
    
end