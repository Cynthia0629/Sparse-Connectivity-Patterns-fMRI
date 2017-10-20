function Leave_One_out(set,n)

    st  = '/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/CV_Parallel/SRS_Cont_CV';
    addpath('/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI')
    fold = 66;
    load(strcat(st,'/data_',num2str(fold),'.mat'))
    fprintf(st)
    fprintf('\n')


    %% Initialising parameters
    
    m= 116;
    B_init = -1+2*rand(m,n);
    C_init = rand(n,size(Y_train{set},1));
    W_init = rand(n,1);


    lr1 = 0.0001;
    lr2 = 0.001;
    lambda = 1;
    lambda_1 =2;
    lambda_2 =1;
    lambda_3 =1;

    [B_gd,C_gd,W_gd] = gradient_descent_runner(corr_train{set},B_init,C_init,W_init,Y_train{set},lambda,lambda_1,lambda_2,lambda_3,lr1,lr2);

    B_thresh = B_gd.*(B_gd<0.1*(min(min(B_gd)))) + B_gd.*(B_gd>0.1*(max(max(B_gd))));
    str1 = strcat(st,'/workspace_',num2str(n),'_net_',num2str(fold),'_set_',num2str(set));
    str2 = strcat(str1,'.mat');
    save(str2)
    
    %% Testing 

    clearvars -except str1 st set;
    load(str1)
    load(strcat(st,'/data_',num2str(fold),'.mat'))

    C_gd_test = quad_estimate_C(B_gd,lambda_2,corr_test{set});
    C_gd_train = quad_estimate_C(B_gd,lambda_2,corr_train{set});
    Y_obt_test = C_gd_test'*W_gd;
    Y_obt_train = C_gd'*W_gd;
    Y_est_train = C_gd_train'*W_gd;
    error_test = norm(Y_obt_test-Y_test,'fro')/size(Y_test,1);
    error_train = norm(Y_obt_train-Y_train,'fro')/size(Y_train,1);
    error_train_est = norm(Y_est_train-Y_train,'fro')/size(Y_train,1);
    

    str2  = strcat(str1,'_test',num2str(fold),'.mat');
    save(str2,'C_gd_test','C_gd_test','Y_obt_train','Y_obt_test','Y_est_train','error_test','error_train','error_train_est','str2')
   
end   