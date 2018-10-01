 function err = error_compute_NL(corr,B,C,K,Y,D,lamb,lambda,lambda_1,lambda_2,lambda_3,flag)
%%Computes the error at the current interation given the values of the iterates at the instant

fit_err = 0;
const_err =0 ;
aug_lag_err =0;

est_Y = zeros(size(Y));
err_W_reg =0;

for n = 1:size(corr,1)
    
    %select out constraint and correlationterms  
    D_n = reshape(D(n,:,:),[size(D,2),size(D,3)]);
    lamb_n = reshape(lamb(n,:,:),[size(lamb,2),size(lamb,3)]);
     
    %compute correlation fit
    X = reshape((corr(n,:,:)),[size(corr,2),size(corr,3)]) -D_n*B'; 
    fit_err = fit_err + norm(X,'fro').^2;
    
    %compute lagrangian + reg. error
    const_err = const_err + trace(lamb_n'*(D_n-B*diag(C(:,n))));
    aug_lag_err = aug_lag_err +0.5*norm((D_n-B*diag(C(:,n))),'fro').^2;
    
    %Compute error for kernel ridge reg. flag
    if (flag)
        
        sigma =sqrt(1);
        alpha = pinv(K+(lambda_3/lambda)*eye(size(C,2)))*Y;        
        
        for j = 1:size(corr,1)
        
            %sum kernel contributions for nth score estimation
%             [F_j,~] = Ker_NL(C(:,n),C(:,j),sigma);
            F_j = K(n,j);
            est_Y(n) = est_Y(n) + alpha(j)*F_j;
                      
            % regularisation error for regression vector cross terms 
            err_W_reg = err_W_reg + alpha(n)*alpha(j)*F_j;

        
        end
        
    else
        
        est_Y=Y;
        
    end
end

%total error
err = fit_err + const_err + aug_lag_err + lambda_1* norm(B,1) + lambda* norm(est_Y-Y).^2 + lambda_2* norm(C,'fro').^2+ lambda_3*err_W_reg;

end