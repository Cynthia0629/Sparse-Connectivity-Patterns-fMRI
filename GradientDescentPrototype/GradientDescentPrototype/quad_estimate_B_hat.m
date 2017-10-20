function B_hat_upd = quad_estimate_B_hat(B_upd,C_upd,corr)

B_hat_upd = zeros(size(corr));

for m = 1:size(corr,1)
   
    H = 2*eye(size(corr,2)*size(corr,3));
    
    Corr_mat = reshape(corr(m,:,:),[size(corr,2),size(corr,3)]);
    f = -2*reshape((Corr_mat-B_upd*diag(C_upd(:,m))*B_upd'),[1,size(corr,2)*size(corr,3)]) ;
    b_hat_m = quadprog(H,f);
    B_hat_upd(m,:,:) = reshape(b_hat_m,[size(corr,2),size(corr,3)]);
end

end