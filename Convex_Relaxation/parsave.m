function parsave(fname, B_gd,B_avg_gd,C_gd,W_gd,D_gd,lamb_gd, ...
       corr_train,corr_test,Y_train,Y_test, ...
       B_init,B_avg_init,C_init,W_init,D_init,lamb_init, ...
       lambda,lambda_1,lambda_2,lambda_3,lr1)
save(fname,  'B_gd','B_avg_gd','C_gd','W_gd','D_gd','lamb_gd', ...
       'corr_train','corr_test','Y_train','Y_test', ...
       'B_init','B_avg_init','C_init','W_init','D_init','lamb_init', ...
       'lambda','lambda_1','lambda_2','lambda_3','lr1')
end