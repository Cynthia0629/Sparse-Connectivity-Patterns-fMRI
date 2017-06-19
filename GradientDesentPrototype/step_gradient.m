function [B_upd,C_upd,W_upd] = step_gradient(corr,B,C,W,Y,lambda,lambda_1,lambda_2,lr1,lr2)
%%Given the current values of the iterates, performs a single step of
%%gradient descent using alternating minimisation

%% B update
grad_B = zeros(size(B));

for n = 1:size(corr,1)
    A_n = diag(C(:,n));
    Corr_mat = reshape(corr(n,:,:),[size(corr,2),size(corr,3)]);
    grad_B = grad_B - 4* Corr_mat*B*A_n + B*A_n*(B'*B)*A_n;
end

signum_B = sign(B);
%k = (signum_B==0);
%r = -1 + (2)*rand(size(signum_B));
%signum_B = signum_B+ r.*k;

B_upd = B - lr1*(grad_B + lambda_1* signum_B);

%% C update

C_1 = zeros(size(C));

B_trans_B = (B_upd'*B_upd); % facilitates inner product computations

for i = 1:size(C_1,1)
    for j = 1:size(C_1,2)
        
        Corr_mat = reshape(corr(j,:,:),[size(corr,2),size(corr,3)]);
        C_1(i,j) = B_upd(:,i)'*Corr_mat*B_upd(:,i)+ 2*C(i,j)*(B_trans_B(i,i)*2);
        for k = 1:size(C_1,1)
            if(k~=i)
                C_1(i,j) = C_1(i,j)+C(k,j)*(B_trans_B(k,i)*2);
            end
        end
    end
end

grad_C = C_1 + lambda*(W)*(C'*W-Y)' + 2*lambda_2*C;

C_upd = C - lr2*grad_C;
C_upd = max(C_upd,0);
%% W update

W_upd = inv(C_upd*C_upd')*(C_upd*Y);


end