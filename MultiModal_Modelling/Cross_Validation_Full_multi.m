clearvars -except net lambda_2 lambda_1 lambda_3 lambda scale st offs scale thresh cvf

fold =5;

filename = strcat(st,'/Thresh_',num2str(thresh),'/data_',num2str(fold),'.mat');
filename1 = strcat(st,'/Thresh_',num2str(thresh),'/data_out_',num2str(fold),'.mat');

if exist(filename,'file')
    load(filename)
else
    load(filename1)
end

fprintf(st)
fprintf('\n')

%% Initialise
lr1 = 0.001; 
% lambda = 1;
% lambda_1 = 20;    
% %  lambda_22 =0.5;
% %  lambda_21 =2;
% % lambda_2 =0.1;
% lambda_3 =1;
offs_A =0;
scale_A =1;

  %% Initialising parameters
tic;
for i = cvf
      
   m= size(corr_train{i},2);
    
   B_init = sprandn(m,net,0.4);    
   B_avg_init = reshape(mean(corr_train{i},1),size(corr_train{i},2),size(corr_train{i},3));
   C_init =  abs(randn(net,size(corr_train{i},1)));
   lamb_init = zeros(size(corr_train{i},1),m,net);
   W_init =randn(net,1);
   
   D_init = initD(B_init,C_init);
   
   Y_train{i} = Y_train{i} + offs;
   Y_train{i} = Y_train{i}* scale;
   
   Y_test{i} = Y_test{i} + offs;
   Y_test{i} = Y_test{i}* scale;
   
  

   fprintf('\n Fold: %d, sparsity penalty : %f; networks: %d \n',i,lambda_1,net)
   fprintf('\n tradeoff penalty: %f, C penalty : %f; W penalty: %f \n',lambda,lambda_2,lambda_3)
    
   input_mat  = corr_train{i};
%        [B_gd{i},B_avg_gd{i},C_gd{i},W_gd{i},D_gd{i},lamb_gd{i}]  = gradient_descent_runner_avg(corr_train{i},B_init,B_avg_init,C_init,W_init,D_init,Y_train{i},lamb_init,Q_train{i},lambda,lambda_1,lambda_2,lambda_3,lr1);
     [B_gd_cv,C_gd_cv,W_gd_cv,D_gd_cv,lamb_gd_cv]  = gradient_descent_runner(input_mat,B_init,C_init,W_init,D_init,Y_train{i},lamb_init,Q_train{i},lambda,lambda_1,lambda_2,lambda_3,lr1);
 
end

toc;
str1 = strcat(st,'/Thresh_',num2str(thresh),'/workspace_out_',num2str(net),'_net_',num2str(fold),'_fold_',num2str(lambda_1),'_sparsity_',num2str(lambda_2),'_regC_',num2str(lambda_3),'_regW_',num2str(lambda),'_trad/');

if exist(str1,'dir')
   cd(str1) 
else    
   mkdir(str1)
   cd(str1) 

end

str2 = strcat(num2str(cvf),'_cv_f','.mat');
     
save(str2)
toc;

cd ..

