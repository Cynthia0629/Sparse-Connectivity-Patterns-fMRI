function parsave(fname, B_gd,B_hat_gd,C_gd,W_gd, ...
       corr_train,corr_test,Y_train,Y_test, ...
       B_init,B_hat_init,C_init,W_init, ...
       lambda,lambda_1,lambda_2,lambda_3,lr1)
save(fname,  'B_gd','B_hat_gd','C_gd','W_gd', ...
       'corr_train','corr_test','Y_train','Y_test', ...
       'B_init','B_hat_init','C_init','W_init', ...
       'lambda','lambda_1','lambda_2','lambda_3','lr1')
end