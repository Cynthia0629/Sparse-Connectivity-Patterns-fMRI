function [B_upd,C_upd,K_upd,D_upd,lamb_upd] = alt_min_NL(corr,B,C,K,D,lamb,Y,lambda,lambda_1,lambda_2,lambda_3,lr1,sigma)
%%Given the current values of the iterates, performs a single step of
%%gradient descent using alternating minimisation
num_iter_max =100;


%% B update
fprintf('Optimise B \n')

t =0.0001;

err_inner = [];

 
for iter = 1:num_iter_max
  
  DG = zeros(size(B));
  
  for j = 1:size(corr,1)
      
      Corr_j = reshape(corr(j,:,:),[size(corr,2),size(corr,3)]);
      D_k = reshape(D(j,:,:),[size(D,2),size(D,3)]);
      lamb_j =reshape(lamb(j,:,:),[size(lamb,2),size(lamb,3)]);
     
      DG = DG + 2*(((B*D_k')-Corr_j)*D_k) -D_k*diag(C(:,j)) +B*diag(C(:,j))*diag(C(:,j))- lamb_j*diag(C(:,j));
  end
  
  if(iter ==1)
      DG_init = DG;
  end
      
  X_mat = B - t*DG/lambda_1;
  B = sign(X_mat).*(max(abs(X_mat)-t,0));

 
  err_inner= horzcat(err_inner,error_compute_NL(corr,B,C,K,Y,D,lamb,lambda,lambda_1,lambda_2,lambda_3,1));
  fprintf(' At B iteration %d || Error: %f \n',iter,err_inner(iter))   
%   plot(1:iter,err_inner,'b');
%   hold on;
%   drawnow;
  
  if ((iter>2)&&((max(0,norm(DG,2)/norm(DG_init,2))< 10e-06)||(err_inner(iter)>err_inner(iter-2))))
      break;
  end
  
end 
B_upd = B;
%B_upd = normc(B);

fprintf(' At final B iteration || Error: %f \n',error_compute_NL(corr,B_upd,C,K,Y,D,lamb,lambda,lambda_1,lambda_2,lambda_3,1))   



%% C update

fprintf('Optimise C \n')
% update coefficients
% quadratic prog solver: x = quadprog(H,f,A,b)

alpha = pinv(K+(lambda_3/lambda)*eye(size(C,2)))*Y;
C_upd = Coefficient_Updates_NL(corr,B_upd,C,Y,D,lamb,alpha,lambda,lambda_2,sigma);


fprintf(' Step C || Error: %f \n',error_compute_NL(corr,B_upd,C_upd,K,Y,D,lamb,lambda,lambda_1,lambda_2,lambda_3,1));

%% Compute Kernel

K_upd = compute_kernel(C_upd,sigma);
fprintf(' Rank of Kernel Matrix: %d \n', rank(K_upd))

fprintf(' Step W || Error: %f \n',error_compute_NL(corr,B_upd,C_upd,K_upd,Y,D,lamb,lambda,lambda_1,lambda_2,lambda_3,1));


%% Dn's and lambda matrix update
fprintf('Optimise D and lambda \n')

%proximal variables update
[D_upd,lamb_upd] = Proximal_Updates_NL(corr,lamb,B_upd,C_upd,lr1);

fprintf(' Step D || Error: %f \n',error_compute_NL(corr,B_upd,C_upd,K_upd,Y,D_upd,lamb_upd,lambda,lambda_1,lambda_2,lambda_3,1));
       
end
     

   
    