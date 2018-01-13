function err = error_compute(corr,B,B_hat,C,C_hat,Y,W,lambda,lambda_1,lambda_2,lambda_3,lambda_4)
%%Computes the error at the current interation given the values of the iterates at the instant

err = 0;

for n = 1:size(corr,1)

    X = reshape((corr(n,:,:)),[size(corr,2),size(corr,3)]) -B_hat - B*diag(C(:,n))*B'-diag(C_hat(:,n)); 
    err = err + norm(X,'fro').^2;
 
end

err = err + lambda_1* norm(B,1) + lambda* norm(C'*W-Y,2).^2 + lambda_2* norm(C,'fro').^2+ lambda_3*norm(W,'fro').^2+lambda_4*norm(eye(size(B'*B))-(B'*B),'fro').^2;

end