 function err = error_compute_NL(corr,B,C,Y,D,lamb,lambda,lambda_1,lambda_2,lambda_3,flag)
%%Computes the error at the current interation given the values of the iterates at the instant

fit_err = 0;
const_err =0 ;
aug_lag_err =0;

est_Y = zeros(size(Y));
err_W_reg =0;

for n = 1:size(corr,1)
    
    D_n = reshape(D(n,:,:),[size(D,2),size(D,3)]);
    lamb_n = reshape(lamb(n,:,:),[size(lamb,2),size(lamb,3)]);
     
    X = reshape((corr(n,:,:)),[size(corr,2),size(corr,3)]) -D_n*B'; 
    fit_err = fit_err + norm(X,'fro').^2;
    
    const_err = const_err + trace(lamb_n'*(D_n-B*diag(C(:,n))));
    aug_lag_err = aug_lag_err +0.5*norm((D_n-B*diag(C(:,n))),'fro').^2;
    
    if (flag)
        
        sigma =sqrt(1);
        K = compute_kernel(C,sigma);
        alpha = pinv(K+(lambda_3/lambda)*eye(size(C,2)))*Y;

        [F_n,~] = Ker_NL(C(:,n),C(:,n),sigma);
        err_W_reg = err_W_reg + (alpha(n)).^2* F_n;
    
        for j = 1:size(corr,1)
        
            est_Y(n) = est_Y(n) + alpha(j)*Ker_NL(C(:,n),C(:,j),sigma);
        
            if (j~=n)
            
                [F_j,~] = Ker_NL(C(:,n),C(:,j),sigma);
                err_W_reg = err_W_reg + 2*alpha(n)*alpha(j)*F_j;
        
            end

        
        end
    else
        
        est_Y=Y;
        
    end
end



err = fit_err + const_err + aug_lag_err + lambda_1* norm(B,1) + lambda* norm(est_Y-Y).^2 + lambda_2* norm(C,'fro').^2+ lambda_3*err_W_reg;

end