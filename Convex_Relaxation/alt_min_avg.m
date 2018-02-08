function [B_upd,B_avg_upd,C_upd,D_upd,W_upd,lamb_upd] = alt_min_avg(corr,B,B_avg,C,W,D,lamb,Y,lambda,lambda_1,lambda_2,lambda_3,lr1)
%%Given the current values of the iterates, performs a single step of
%%gradient descent using alternating minimisation
num_iter_max =100;


%% B update
fprintf('Optimise B \n')

t =0.0005;

err_inner = [];
for iter = 1:num_iter_max
  
  DG = zeros(size(B));
  
  for j = 1:size(corr,1)
      
      Corr_j = reshape(corr(j,:,:),[size(corr,2),size(corr,3)]);
      D_k = reshape(D(j,:,:),[size(D,2),size(D,3)]);
      lamb_j =reshape(lamb(j,:,:),[size(lamb,2),size(lamb,3)]);
  
      DG = DG -2*(Corr_j-B_avg)*D_k +2*B*(D_k'*D_k) -D_k*diag(C(:,j)) +B*diag(C(:,j))*diag(C(:,j))- lamb_j*diag(C(:,j));
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
  
  err_inner= horzcat(err_inner,error_compute_avg(corr,B,B_avg,C,Y,W,D,lamb,lambda,lambda_1,lambda_2,lambda_3));
  fprintf(' At B iteration %d || Error: %f \n',iter,err_inner(iter))   
%   plot(1:iter,err_inner,'b');
%   hold on;
%   drawnow;
%   
  if ((iter>2)&&(norm(DG,2)/norm(DG_init,2)< 10e-06))
      break;
  end
  
end 

B_upd = normc(B);
%% B_avg update
fprintf('Optimise B_avg \n')

B_avg_upd = zeros(size(B_avg));

for l = 1:size(corr,1)
    
    Corr_l = reshape(corr(l,:,:),[size(corr,2),size(corr,3)]);
    D_l = reshape(D(l,:,:),[size(D,2),size(D,3)]);
    B_avg_upd = B_avg_upd + Corr_l - D_l*B_upd'; 
    
end

B_avg_upd = B_avg_upd/l ;
fprintf(' Step B_avg || Error: %f \n',error_compute_avg(corr,B_upd,B_avg_upd,C,Y,W,D,lamb,lambda,lambda_1,lambda_2,lambda_3));

%% C update

fprintf('Optimise C \n')

% quadratic prog solver: x = quadprog(H,f,A,b)
C_upd = zeros(size(C));
for m = 1:size(corr,1)
   
    H = 2*(diag(diag(B_upd'*B_upd))+ lambda*(W*W')+ lambda_2* eye(size(B_upd'*B_upd)));
    
    D_m = reshape(D(m,:,:),[size(D,2),size(D,3)]);
    lamb_m =reshape(lamb(m,:,:),[size(lamb,2),size(lamb,3)]);
    
    L1 = 2*D_m'*B_upd;
    L2 = lamb_m'*B_upd;
    
    f = -diag(L1) - diag(L2) -2*lambda*Y(m)*W;
    
    A = -eye(size(C,1));
    b = zeros(size(C,1),1);
    
    c_m = quadprog(H,f,A,b);
    C_upd(:,m) = c_m;
end

fprintf(' Step C || Error: %f \n',error_compute_avg(corr,B_upd,B_avg_upd,C_upd,Y,W,D,lamb,lambda,lambda_1,lambda_2,lambda_3));
%% W update
% epsil = 10e-06;
fprintf('Optimise W \n')
W_upd = pinv(C_upd*C_upd'+ 2*lambda_3*eye(size(C*C')))*(C_upd*Y);
fprintf(' Step W || Error: %f \n',error_compute_avg(corr,B_upd,B_avg_upd,C_upd,Y,W_upd,D,lamb,lambda,lambda_1,lambda_2,lambda_3));

%% Dn's and lambda matrix update
fprintf('Optimise D \n')
D_upd = zeros(size(D));
lamb_upd = zeros(size(lamb));
for k= 1:size(lamb,1)
        
     Corr_k = reshape(corr(k,:,:),[size(corr,2),size(corr,3)]);
     lamb_k =reshape(lamb(k,:,:),[size(lamb,2),size(lamb,3)]);
     
     for c=1:num_iter_max
               
        D_k = (B_upd*diag(C_upd(:,k))+ 2*(Corr_k-B_avg_upd)*B_upd - lamb_k)*pinv(eye(size(B_upd'*B_upd))+2*(B_upd'*B_upd));
        lamb_k = lamb_k + lr1*(D_k - B_upd*diag(C_upd(:,k)));
        
        if (c ==1)
            grad_norm_init = norm(D_k - B_upd*diag(C_upd(:,k)),2);
        end
        
        if (norm(D_k - B_upd*diag(C_upd(:,k)),2)/grad_norm_init<10e-06)
           break;
        end
        
     end
     
     lamb_upd(k,:,:)= lamb_k;
     D_upd(k,:,:) =D_k;
     lr1=lr1*0.5;
end
fprintf(' Step D || Error: %f \n',error_compute_avg(corr,B_upd,B_avg_upd,C_upd,Y,W_upd,D_upd,lamb_upd,lambda,lambda_1,lambda_2,lambda_3));
       
end
     

   
    