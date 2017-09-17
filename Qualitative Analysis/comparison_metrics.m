clear all
close all

fold = 66;

%%  Generate network plots

for f = 10
    
    clearvars -except f strr fold
    error_comp_train =[];
    error_comp_train_est =[];
    error_comp_test =[];

    
    strr = '/home/niharika-shimona/Documents/Projects/Autism_Network/Results/Sparse connectivity patterns/CV_Parallel/ADOS_CV';
    load(strcat(strr,'/workspace_',num2str(f),'_net_66_rec_test66'))
    fprintf(strr)
    fprintf('\n')

    for i =1:size(error_train,2)
        error_comp_train = vertcat(error_comp_train,abs(Y_obt_train{i}-Y_train{i}));
        error_comp_train_est = vertcat(error_comp_train_est,abs(Y_est_train{i}-Y_train{i}));
        error_comp_test = vertcat(error_comp_test,abs(Y_obt_test{i}-Y_test{i}));
    end
    k1 = size(error_comp_train,1);
    k11 = size(error_comp_test,1);
    %generate_plots;

    strr = '/home/niharika-shimona/Documents/Projects/Autism_Network/Results/Sparse connectivity patterns/CV_Parallel/SRS_Aut_CV';
    load(strcat(strr,'/workspace_',num2str(f),'_net_66_rec_test66'))
    fprintf(strr)
    fprintf('\n')

    for i =1:size(error_train,2)
        error_comp_train = vertcat(error_comp_train,abs(Y_obt_train{i}-Y_train{i}));
        error_comp_train_est = vertcat(error_comp_train_est,abs(Y_est_train{i}-Y_train{i}));
        error_comp_test = vertcat(error_comp_test,abs(Y_obt_test{i}-Y_test{i}));
    end

    k2 = size(error_comp_train,1)-k1;
    k21= size(error_comp_test,1)-k11;
    %generate_plots;

    strr = '/home/niharika-shimona/Documents/Projects/Autism_Network/Results/Sparse connectivity patterns/CV_Parallel/SRS_Cont_CV';
    load(strcat(strr,'/workspace_',num2str(f),'_net_66_rec_test66'))
    fprintf(strr)
    fprintf('\n')

    for i =1:size(error_train,2)
        error_comp_train = vertcat(error_comp_train,abs(Y_obt_train{i}-Y_train{i}));
        error_comp_test = vertcat(error_comp_test,abs(Y_obt_test{i}-Y_test{i}));
        error_comp_train_est = vertcat(error_comp_train_est,abs(Y_est_train{i}-Y_train{i}));
    end
    k3 = size(error_comp_train,1)-k2-k1;
    k31 =size(error_comp_test,1)-k21-k11;
    %generate_plots;

    %% Generate box plots
    close all;

    origin_train =[];

    for i = 1:k1
        origin_train =  vertcat(origin_train,'A ');
    end
    for i = 1:k2
        origin_train =  vertcat(origin_train, 'SA');
    end
    for i= 1:k3
        origin_train = vertcat(origin_train,'SC');
    end

    origin_test =[];

    for i = 1:k11
        origin_test =  vertcat(origin_test,'A ');
    end
    for i = 1:k21
        origin_test =  vertcat(origin_test, 'SA');
    end
    for i= 1:k31
        origin_test = vertcat(origin_test,'SC');
    end

    figure1 = figure;

    subplot(1,3,1)
    boxplot(error_comp_train,origin_train)
    xlabel('Dataset')
    ylabel('training error')
    
    hold on;
    subplot(1,3,2)
    boxplot(error_comp_train_est,origin_train)
    xlabel('Dataset')
    ylabel('training error from estimation')

    hold on;
    subplot(1,3,3)
    boxplot(error_comp_test,origin_test)
    xlabel('Dataset')
    ylabel('testing error')

    hold on;
    img_name = strcat(strr,'/Box_plots_',num2str(f),'.jpg');
    saveas(figure1,img_name);
end 