function est_Y = Compute_Scores(C_pat,C,K,Y,lambda_3,lambda,corr,sigma,w_p,p)

est_Y = zeros(size(corr,1),1);

alpha = pinv(K+(lambda_3/lambda)*eye(size(C,2)))*Y;        

for n = 1: size(corr,1)
    for j = 1: size(C,2)

%                [F_j,~] = Ker_NL(C_pat(:,n),C(:,j),sigma,w_p);
                [F_j,~] = Ker_NL(C_pat(:,n),C(:,j),sigma,w_p,p);
                est_Y(n) = est_Y(n) + alpha(j)*F_j;

    end
end

end
