function C_upd = Coefficient_Updates_NL(corr,B_upd,C,D,lamb,alpha,lambda,lambda_2,sigma)

lr =0.01;
C_upd = zeros(size(B_upd,2));
max_iter =200;

parfor m = 1:size(corr,1)
    
    C_m_old = C(:,m);
    D_m = reshape(D(m,:,:),[size(D,2),size(D,3)]);
    lamb_m = reshape(lamb(m,:,:),[size(lamb,2),size(lamb,3)]);
   
    for iter =1: max_iter
        
        grad_C_m= 2*lambda_2*C_m_old;
      
        for i= 1:size(corr,1)
      
       
           [F_i,J_i] = Ker_NL(C_m_old,C(:,i),sigma);
           grad_C_m = grad_C_m - 2*lambda*alpha(i)*J_i + 2*lambda*(alpha(i)^2)*F_i*J_i;
       
           for k= 1:size(corr,1)
          
               if (i~=k)
           
                  [F_k,J_k] = Ker_NL(C_m_old,C(:,k),sigma);
                  grad_C_m = grad_C_m + 2*lambda*alpha(i)*alpha(k)*(F_k*J_i+F_i*J_k);
               
               end
               
           end
       
         end
           % gradient descent update
           grad_C_m = grad_C_m -diag((lamb_m'+D_m')*B_upd)+ C_m_old.* diag(B_upd'*B_upd);
           
           C_m_new = C_m_old -lr*grad_C_m;
           
           %projection step
           C_m_new = max(C_m_new,zeros(size(C_m_new)));
           C_m_old = C_m_new;
           
           if(norm(grad_C_m)<= 10e-04)
               
               break;
               
           end
                  
    end
   
   C_upd(:,m) = C_m_new;
   
end

end