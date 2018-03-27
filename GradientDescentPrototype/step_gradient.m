function [B_upd,B_hat_upd,C_upd,C_hat_upd,W_upd] = step_gradient(corr,B,B_hat,C,C_hat,W,Y,lambda,lambda_1,lambda_2,lambda_3,lambda_4,lr1)
%%Given the current values of the iterates, performs a single step of
%%gradient descent using alternating minimisation
num_iter_max =100;
%% B update
fprintf('Optimise B')
err =[];
% plot(0,0)

for i = 1:num_iter_max
    
    grad_B = zeros(size(B));
    err= horzcat(err,error_compute(corr,B,B_hat,C,C_hat,Y,W,lambda,lambda_1,lambda_2,lambda_3,lambda_4));
    fprintf('\n B update iteration %d || error: %f ',i,err(i));
    
%     plot(1:i,err,'r')
%     title('Algorithmic run')
%     xlabel('Iteration number')
%     ylabel('Objective value')
%     drawnow;
    for n = 1:size(corr,1)
        A_n = diag(C(:,n));
        Corr_mat = reshape(corr(n,:,:),[size(corr,2),size(corr,3)]);
        %B_hat_mat = reshape(B_hat(n,:,:),[size(corr,2),size(corr,3)]);
        grad_B = grad_B - 4* (Corr_mat-B_hat-diag(C_hat(:,n)))*B*A_n + 4*B*A_n*(B'*B)*A_n;
    end

    grad_B = grad_B -lambda_4*4*B+lambda_4*4*(B*B')*B;

    
    signum_B = sign(B);
    k = (signum_B==0);
    r = -1 + (2)*rand(size(signum_B));
    signum_B = signum_B + r.*k;

    B_upd = B - lr1*(grad_B + lambda_1* signum_B);

    if  (i==1)
       grad_B_init = grad_B;         
    end
    %B_upd = B - lr1*(grad_B + 2*lambda_1* B);
    lr1 = lr1*0.1;
    
    if ((i>1) && ((abs(norm(grad_B+lambda_1* signum_B,2)/norm(grad_B_init)) < 10e-04) || err(i-1)<= err(i)))      
        B_upd = normc(B_upd);
        break;
    end
    
    B_upd = normc(B_upd);
    B = B_upd;        
   
end


%% B_hat update

%B_hat_upd = quad_estimate_B_hat(B_upd,C,corr);
B_hat_upd = zeros(size(corr,2),size(corr,3));
for q = 1:size(corr,1)
    B_hat_upd = B_hat_upd-B*diag(C(:,q))*B'-diag(C_hat(:,q));
end
B_hat_upd = B_hat_upd./q ;
B_hat_upd = B_hat_upd + reshape(mean(corr,1),[size(corr,2),size(corr,3)]);


%% C update

% quadratic prog solver: x = quadprog(H,f,A,b)
C_upd = zeros(size(C));
for m = 1:size(corr,1)
   
    H = 2*((B_upd'*B_upd).^2 + lambda*(W*W')+ lambda_2* eye(size(B_upd'*B_upd)));
    Corr_mat = reshape(corr(m,:,:),[size(corr,2),size(corr,3)]);
    %B_hat_mat = reshape(B_hat(m,:,:),[size(corr,2),size(corr,3)]);
    M = -2*(B_upd'*(Corr_mat-B_hat_upd-diag(C_hat(:,m)))*B_upd);
    f = diag(M) -2*lambda*Y(m)*W;
    A = -eye(size(C,1));
    b = zeros(size(C,1),1);
    c_m = quadprog(H,f,A,b);
    C_upd(:,m) = c_m;
end
%% C_hat update

C_hat_upd = zeros(size(C_hat));
% for m = 1:size(corr,1)
%    
%     H = 2*eye(size(corr,2));
%     Corr_mat = reshape(corr(m,:,:),[size(corr,2),size(corr,3)]);
%     M = -2*(Corr_mat-B_upd*diag(C_upd(:,m))*B_upd'-B_hat);
%     f = diag(M);
%     A = -eye(size(C_hat,1));
%     b = zeros(size(C_hat,1),1);
%     c_m = quadprog(H,f,A,b);
%     C_hat_upd(:,m) = c_m;
% end
%% W update
% epsil = 10e-06;
%W_upd = max(pinv(C_upd*C_upd'+ 2*lambda_3*eye(size(C*C')))*(C_upd*Y),zeros(size(W)));
W_upd = pinv(C_upd*C_upd'+ (lambda_3/lambda)*eye(size(C*C')))*(C_upd*Y);

end