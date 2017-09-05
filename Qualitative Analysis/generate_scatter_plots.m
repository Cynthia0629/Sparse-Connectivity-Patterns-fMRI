strr = '/home/niharika-shimona/Documents/Projects/Autism_Network/Results/Sparse connectivity patterns/5 fold cross validation/ADOS_CV';

f = 9;
load(strcat(strr,'/workspace_',num2str(f),'_net5_test5'))
Y_test_pred = [];
Y_test_meas = [];
Y_train_pred = [];
Y_train_meas = [];

for i = 1: size(Y_obt_test,2)
    Y_test_pred = horzcat(Y_test_pred,Y_obt_test{i}');
    Y_train_pred = horzcat(Y_train_pred,Y_obt_train{i}');
    Y_test_meas = horzcat(Y_test_meas,Y_test{i}');
    Y_train_meas = horzcat(Y_train_meas,Y_train{i}');
end

figure1  = figure;

scatter(Y_test_meas',Y_test_pred','g')
hold on;
scatter(Y_train_meas',Y_train_pred','r')
title('Predictive Performance')

str1 = strcat(strr,'/Predictive_performance',num2str(f),'.jpg');
saveas(figure1,str1)