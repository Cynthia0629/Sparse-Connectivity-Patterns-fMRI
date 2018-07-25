function C_upd = Quadratic_Updates(corr,B_upd,W,D,lamb,Y,lambda,lambda_2)

C_upd = zeros(size(B_upd,2));

parfor m = 1:size(corr,1)
   
    H = diag(diag(B_upd'*B_upd)) + 2*(lambda*(W*W')+ 2*lambda_2* eye(size(B_upd'*B_upd)));
    
    D_m = reshape(D(m,:,:),[size(D,2),size(D,3)]);
    lamb_m =reshape(lamb(m,:,:),[size(lamb,2),size(lamb,3)]);
    
    L1 = D_m'*B_upd;
    L2 = lamb_m'*B_upd;
    
    f = -diag(L1)-diag(L2)-2*lambda*Y(m)*W;
    
    A = -eye(size(B_upd,2));
    b = zeros(size(B_upd,2),1);
    
    c_m = quadprog(H,f,A,b);
    C_upd(:,m) = c_m;
end

end