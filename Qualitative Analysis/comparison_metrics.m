clear all
close all

f = 9;
fold = 5;
error_comp_train =[];
error_comp_test =[];

%%  Generate network plots

str = '/home/niharika-shimona/Documents/Projects/Autism_Network/Results/Sparse connectivity patterns/5 fold cross validation/ADOS_CV';
load(strcat(str,'/workspace_',num2str(f),'_net5_test',num2str(fold),'.mat'))
fprintf(str)
fprintf('\n')

for i =1:size(error_train,1)
    error_comp_train = vertcat(error_comp_train,abs(Y_obt_train{i}-Y_train{i}));
    error_comp_test = vertcat(error_comp_test,abs(Y_obt_test{i}-Y_test{i}));
end
k1 = size(error_comp_train,1);
k11 = size(error_comp_test,1);
%generate_plots;

str = '/home/niharika-shimona/Documents/Projects/Autism_Network/Results/Sparse connectivity patterns/5 fold cross validation/SRS_Aut_CV';
load(strcat(str,'/workspace_',num2str(f),'_net5_test',num2str(fold),'.mat'))
fprintf(str)
fprintf('\n')

for i =1:size(error_train,1)
    error_comp_train = vertcat(error_comp_train,abs(Y_obt_train{i}-Y_train{i}));
    error_comp_test = vertcat(error_comp_test,abs(Y_obt_test{i}-Y_test{i}));
end

k2 = size(error_comp_train,1)-k1;
k21= size(error_comp_test,1)-k11;
%generate_plots;

str = '/home/niharika-shimona/Documents/Projects/Autism_Network/Results/Sparse connectivity patterns/5 fold cross validation/SRS_Cont_CV';
load(strcat(str,'/workspace_',num2str(f),'_net5_test',num2str(fold),'.mat'))
fprintf(str)
fprintf('\n')

for i =1:size(error_train,1)
    error_comp_train = vertcat(error_comp_train,abs(Y_obt_train{i}-Y_train{i}));
    error_comp_test = vertcat(error_comp_test,abs(Y_obt_test{i}-Y_test{i}));
end
k3 = size(error_comp_train,1)-k2-k1;
k31 =size(error_comp_test,1)-k21-k11;
%generate_plots;

%% Generate box plots
close all;

figure1 = figure; subplot(1,2,1)
origin_train =[];

for i = 1:k1
    origin_train =  vertcat(origin_train,'ADOS    ');
end
for i = 1:k2
    origin_train =  vertcat(origin_train, 'SRS_Aut ');
end
for i= 1:k3
    origin_train = vertcat(origin_train,'SRS_Cont');
end

origin_test =[];

for i = 1:k11
    origin_test =  vertcat(origin_test,'ADOS    ');
end
for i = 1:k21
    origin_test =  vertcat(origin_test, 'SRS_Aut ');
end
for i= 1:k31
    origin_test = vertcat(origin_test,'SRS_Cont');
end


boxplot(error_comp_train,origin_train)
xlabel('Dataset')
ylabel('training error')

subplot(1,2,2)
boxplot(error_comp_test,origin_test)
xlabel('Dataset')
ylabel('training error')

img_name = strcat('Box_plots_',num2str(f),'.jpg');
saveas(figure1,img_name);
