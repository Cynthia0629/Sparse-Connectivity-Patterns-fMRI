function [B_upd,B_avg_upd,C_upd,D_upd,W_upd,lamb_upd] = alt_min_avg(corr,B,B_avg,C,W,D,lamb,Q,Y,lambda,lambda_1,lambda_2,lambda_3,lr1)
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
      Q_j = reshape(Q(j,:,:),[size(Q,2),size(Q,3)]);
      
      DG = DG + 2*(Q_j.*((Q_j.*(B*D_k')+B_avg-Corr_j))*D_k) -D_k*diag(C(:,j)) +B*diag(C(:,j))*diag(C(:,j))- lamb_j*diag(C(:,j));
  end
  
  if(iter ==1)
      DG_init = DG;
  end
      
  X_mat = B - t*DG/lambda_1;
%   G_mat = (1/t)*(B-wthresh(X_mat,'s',t));
  B = sign(X_mat).*(max(abs(X_mat)-t,0));
  %B = normc(B);
%   if (iter >1)
%       t=t*1.01;
%   end
  
  err_inner= horzcat(err_inner,error_compute_avg(corr,B,B_avg,C,Y,W,D,lamb,Q,lambda,lambda_1,lambda_2,lambda_3));
  fprintf(' At B iteration %d || Error: %f \n',iter,err_inner(iter))   
%   plot(1:iter,err_inner,'b');
%   hold on;
%   drawnow;
%   
  if ((iter>2)&&((max(0,norm(DG,2)/norm(DG_init,2))< 10e-06)||(err_inner(iter)>err_inner(iter-2))))
      break;
  end
  
end 
B_upd = B;
%B_upd = normc(B);

fprintf(' At final B iteration || Error: %f \n',error_compute_avg(corr,B_upd,B_avg,C,Y,W,D,lamb,Q,lambda,lambda_1,lambda_2,lambda_3))   

%% B_avg update

fprintf('Optimise B_avg \n')

B_avg_upd = zeros(size(corr,2),size(corr,3));

for m = 1:size(corr,1)
    
    Corr_m = reshape(corr(m,:,:),[size(corr,2),size(corr,3)]);
    Q_m = reshape(Q(m,:,:),[size(Q,2),size(Q,3)]);
    D_m = reshape(D(m,:,:),[size(D,2),size(D,3)]);
    B_avg_upd = B_avg_upd + Corr_m - Q_m.*(D_m*B_upd');
    
end

B_avg_upd = B_avg_upd/m;
fprintf(' At final B_avg iteration || Error: %f \n',error_compute_avg(corr,B_upd,B_avg_upd,C,Y,W,D,lamb,Q,lambda,lambda_1,lambda_2,lambda_3))   

%% C update

fprintf('Optimise C \n')

% quadratic prog solver: x = quadprog(H,f,A,b)
C_upd = Quadratic_Updates(corr,B_upd,W,D,lamb,Y,lambda,lambda_2);

fprintf(' Step C || Error: %f \n',error_compute_avg(corr,B_upd,B_avg_upd,C_upd,Y,W,D,lamb,Q,lambda,lambda_1,lambda_2,lambda_3));
%% W update
% epsil = 10e-06;
if lambda~= 0
    
    fprintf('Optimise W \n')
    W_upd = ((C_upd*C_upd')+(lambda_3/lambda)*eye(size(C*C')))\(C_upd*Y);
    fprintf(' Step W || Error: %f \n',error_compute_avg(corr,B_upd,B_avg_upd,C_upd,Y,W_upd,D,lamb,Q,lambda,lambda_1,lambda_2,lambda_3));
else 
    W_upd =zeros(size(W));
end


%% Dn's and lambda matrix update
fprintf('Optimise D and lambda \n')
D_upd = zeros(size(D));
lamb_upd = zeros(size(lamb));

[D_upd,lamb_upd] = Proximal_Updates_avg(corr,lamb,Q,D,B_upd,B_avg_upd,C_upd,lr1);

fprintf(' Step D || Error: %f \n',error_compute_avg(corr,B_upd,B_avg_upd,C_upd,Y,W_upd,D_upd,lamb_upd,Q,lambda,lambda_1,lambda_2,lambda_3));
       
end
     

   
    