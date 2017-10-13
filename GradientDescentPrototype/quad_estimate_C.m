function C_upd = quad_estimate_C(B_upd,B_hat,lambda_2,corr,W,lambda)

C_upd = zeros(size(B_upd,2),size(corr,1));
for m = 1:size(corr,1)
   
    H = 2*((B_upd'*B_upd).^2  +lambda*(W*W')+ lambda_2* eye(size(B_upd'*B_upd)));
    Corr_mat = reshape(corr(m,:,:),[size(corr,2),size(corr,3)]);
    B_hat_mat = reshape(B_hat(m,:,:),[size(corr,2),size(corr,3)]);
    M = -2*(B_upd'*(Corr_mat-B_hat_mat)*B_upd);
    f = diag(M) ;
    A = -eye(size(C_upd,1));
    b = zeros(size(C_upd,1),1);
    c_m = quadprog(H,f,A,b);
    C_upd(:,m) = c_m;
end

end