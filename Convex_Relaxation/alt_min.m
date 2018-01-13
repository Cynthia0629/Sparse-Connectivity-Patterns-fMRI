function [B_upd,C_upd,D_upd,W_upd,lamb_upd] = alt_min(corr,B,C,W,D,lamb,Y,lambda,lambda_1,lambda_2,lambda_3)
%%Given the current values of the iterates, performs a single step of
%%gradient descent using alternating minimisation
num_iter_max =1000;


%% B update
fprintf('Optimise B \n')

t = 1/lambda_1;

err_inner = [];
for iter = 1:num_iter_max
  DG = zeros(size(B));
  for j = 1:size(corr,1)
    
      Corr_j = reshape(corr(j,:,:),[size(corr,2),size(corr,3)]);
      D_k = reshape(D(j,:,:),[size(D,2),size(D,3)]);
      lamb_j =reshape(lamb(j,:,:),[size(lamb,2),size(lamb,3)]);
  
      DG = DG -2*Corr_j*D_k +2*B*(D_k'*D_k) -D_k*diag(C(:,j)) +B*diag(C(:,j))*diag(C(:,j))- lamb_j*diag(C(:,j));
  end
  
  X_mat = B - t*DG;
  G_mat = (1/t)*(B-wthresh(X_mat,'s',t));
  B = B - t*0.001*G_mat;
  %B = normc(B);
  if (norm(DG,2)< 10e-06)
      break;
  end
  
  err_inner= horzcat(err_inner,error_compute(corr,B,C,Y,W,D,lamb,lambda,lambda_1,lambda_2,lambda_3));
  fprintf(' At B iteration %d || Error: %f \n',iter,err_inner(iter))
  plot(1:iter,err_inner,'b');
  hold on;
  drawnow;
end 

B_upd = B;
%% C update

fprintf('Optimise C \n')

% quadratic prog solver: x = quadprog(H,f,A,b)
C_upd = zeros(size(C));
for m = 1:size(corr,1)
   
    H = 2*(diag(diag(B_upd'*B_upd))+ lambda*(W*W')+ lambda_2* eye(size(B_upd'*B_upd)));
    
    D_m = reshape(D(m,:,:),[size(D,2),size(D,3)]);
    lamb_m =reshape(lamb(m,:,:),[size(lamb,2),size(lamb,3)]);
    
    L1 = 2*D_m'*diag(C(:,m));
    L2 = 2*lamb_m'*B_upd;
    
    f = -diag(L1) - diag(L2) -2*lambda*Y(m)*W;
    
    A = -eye(size(C,1));
    b = zeros(size(C,1),1);
    
    c_m = quadprog(H,f,A,b);
    C_upd(:,m) = c_m;
end

%% W update
% epsil = 10e-06;
fprintf('Optimise W \n')
W_upd = pinv(C_upd*C_upd'+ 2*lambda_3*eye(size(C*C')))*(C_upd*Y);

%% Dn's and lambda matrix update

D_upd = zeros(size(D));
lamb_upd = zeros(size(lamb));
for k= 1:size(lamb,1)
        
     Corr_k = reshape(corr(k,:,:),[size(corr,2),size(corr,3)]);
     lamb_k =reshape(lamb(k,:,:),[size(lamb,2),size(lamb,3)]);
     
     for c=1:num_iter_max
               
        D_k = (diag(C_upd(:,k))*B_upd'+ 2*Corr_k*B_upd - lamb_k)*pinv(eye(size(B_upd'*B_upd)+B_upd'*B_upd));
        lamb_k = lamb_k + lr1*(D_k - B*diag(C(k,:)));
        
        if (norm(D_k - B*diag(C(k,:)))<10e-06)
           break;
        end
        
     end
     
     lamb_upd(k,:,:)= lamb_k;
     D_upd(k,:,:) =D_k;
end
       
end
     

   
    