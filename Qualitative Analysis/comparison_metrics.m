clear all
close all

n = 10;
fold = 5;
error_comp_train =[];
error_comp_test =[];

%%  Generate network plots

st = '/home/niharika-shimona/Documents/Projects/Autism_Network/Sparse-Connectivity-Patterns-fMRI/ADOS_CV';
load(strcat(st,'/workspace_',num2str(n),'_net_test',num2str(fold),'.mat'))
fprintf(st)
fprintf('\n')
error_comp_train = vertcat(error_comp_train,error_train');
error_comp_test = vertcat(error_comp_test,error_test');
generate_plots;

st = '/home/niharika-shimona/Documents/Projects/Autism_Network/Sparse-Connectivity-Patterns-fMRI/SRS_Aut_CV';
load(strcat(st,'/workspace_',num2str(n),'_net_test',num2str(fold),'.mat'))
fprintf(st)
fprintf('\n')
error_comp_train = vertcat(error_comp_train,error_train');
error_comp_test = vertcat(error_comp_test,error_test');
generate_plots;

st = '/home/niharika-shimona/Documents/Projects/Autism_Network/Sparse-Connectivity-Patterns-fMRI/SRS_Cont_CV';
load(strcat(st,'/workspace_',num2str(n),'_net_test',num2str(fold),'.mat'))
fprintf(st)
fprintf('\n')
error_comp_train = vertcat(error_comp_train,error_train');
error_comp_test = vertcat(error_comp_test,error_test');
generate_plots;

%% Generate box plots
close all;

figure1 = figure; subplot(1,2,1)
origin =[];

for i = 1:10
    origin =  vertcat(origin,'ADOS    ');
end
for i = 1:10
    origin =  vertcat(origin, 'SRS_Aut ');
end
for i= 1:10
    origin = vertcat(origin,'SRS_Cont');
end

boxplot(error_comp_train,origin)
xlabel('Dataset')
ylabel('training error')

subplot(1,2,2)
boxplot(error_comp_test,origin)
xlabel('Dataset')
ylabel('training error')

saveas(figure1,'Box_plots.jpg')
