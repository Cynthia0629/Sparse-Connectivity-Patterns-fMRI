function [B_upd,C_upd,C_hat_upd,W_upd] = step_gradient_mod3(corr,B,C,C_hat,W,Y,lambda,lambda_1,lambda_2,lambda_3,lambda_4,lr1)
%%Given the current values of the iterates, performs a single step of
%%gradient descent using alternating minimisation
num_iter_max =100;
%% B update
fprintf('Optimise B')
err =[];
% plot(0,0)
B_hat = eye(size(corr,2));
for i = 1:num_iter_max
    
    grad_B = zeros(size(B));
    err= horzcat(err,error_compute_mod3(corr,B,C,C_hat,Y,W,lambda,lambda_1,lambda_2,lambda_3,lambda_4));
    fprintf('\n B update iteration %d || error: %f ',i,err(i));
    
%     plot(1:i,err,'r')
%     title('Algorithmic run')
%     xlabel('Iteration number')
%     ylabel('Objective value')
%     drawnow;
    for n = 1:size(corr,1)
        A_n = diag(C(:,n));
        Corr_mat = reshape(corr(n,:,:),[size(corr,2),size(corr,3)]);
        B_hat = eye(size(corr,2));
        grad_B = grad_B - 4* (Corr_mat-B_hat*diag(C_hat(:,n))*B_hat')*B*A_n + 4*B*A_n*(B'*B)*A_n;
    end

    grad_B = grad_B -lambda_4*4*B+lambda_4*4*(B*B')*B;
    
    signum_B = sign(B);
    k = (signum_B==0);
    r = -1 + (2)*rand(size(signum_B));
    signum_B = signum_B + r.*k;

    B_upd = B - lr1*(grad_B + lambda_1* signum_B);
    lr1 = lr1*0.1;
    B_upd = normc(B_upd);
    if ((i>1) && (abs(err(i)-err(i-1))< 10e-06 || err(i-1)<= err(i)))      
        break;
    end
    
    if ((i>1)&&err(i)<= err(i-1))
        B = B_upd;
    end
    
end

%% C update

% quadratic prog solver: x = quadprog(H,f,A,b)
C_upd = zeros(size(C));
for m = 1:n
   
    H = 2*((B_upd'*B_upd).^2 + lambda*(W*W')+ lambda_2* eye(size(B_upd'*B_upd)));
    Corr_mat = reshape(corr(m,:,:),[size(corr,2),size(corr,3)]);
    M = -2*(B_upd'*(Corr_mat-B_hat*diag(C_hat(:,m))*B_hat')*B_upd);
    f = diag(M) -2*lambda*Y(m)*W;
    A = -eye(size(C,1));
    b = zeros(size(C,1),1);
    c_m = quadprog(H,f,A,b);
    C_upd(:,m) = c_m;
end

%% C_hat update

C_hat_upd = zeros(size(C_hat));
for m = 1:n
   
    H = 2*B_hat;
    Corr_mat = reshape(corr(m,:,:),[size(corr,2),size(corr,3)]);
    M = -2*(Corr_mat-B_upd*diag(C_upd(:,m))*B_upd');
    f = diag(M);
    A = -eye(size(C_hat,1));
    b = zeros(size(C_hat,1),1);
    c_m = quadprog(H,f,A,b);
    C_hat_upd(:,m) = c_m;
end

%% W update
% epsil = 10e-06;
W_upd = pinv(C_upd*C_upd'+ 2*lambda_3*eye(size(C*C')))*(C_upd*Y);


end