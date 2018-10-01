function C_upd = Coefficient_Updates_NL(corr,B_upd,C,Y,D,lamb,alpha,lambda,lambda_2,sigma)
%%updates for coefficient- inputs to the kernel ridge regression

% initialisation
lr =0.001;
C_upd = zeros(size(C));
max_iter =150;

parfor m = 1:size(corr,1)
    
    D_m = reshape(D(m,:,:),[size(D,2),size(D,3)]);
    lamb_m = reshape(lamb(m,:,:),[size(lamb,2),size(lamb,3)]);
   
    for iter =1: max_iter
        
        if (iter ==1)
            C_m_old = C(:,m);
        end
        
        %reg. term contribution
        grad_C_m= 2*lambda_2*C_m_old;
      
        % const. term contribution
        grad_C_m = grad_C_m -diag((lamb_m'+D_m')*B_upd)+ C_m_old.* diag(B_upd'*B_upd);
      
        % kernel function expansion contributions
        for i= 1:size(corr,1)
           
            [F_i,J_i] = Ker_NL(C_m_old,C(:,i),sigma);
           
            % self terms
            grad_C_m = grad_C_m - 2*lambda*(alpha(i)*J_i).*Y(m) + 2*lambda*alpha(i)^2*J_i*F_i ;
       
            for k= 1:size(corr,1)
                                             
                  % cross terms
                  if (i~=k)
                    [F_k,J_k] = Ker_NL(C_m_old,C(:,k),sigma);
                    grad_C_m = grad_C_m + lambda*alpha(i)*alpha(k)*(F_k*J_i+F_i*J_k);
                  end        
               
            end
       
        end
           
        
           
           %gradient descent update
           C_m_new = C_m_old -lr*(0.75)^(iter-1)*grad_C_m;
           
           %projection step
           C_m_new = max(C_m_new,zeros(size(C_m_new,1),1));
           
           %check if step is causing objective decrease
           if(((C_m_new-C_m_old)'* grad_C_m)>0)
                   
                   fprintf('\n coefficient:  %d Iteration: %d . Increase in function value!',m,iter)
           end
               
           % exit condition
           if(iter >1 &&(norm(grad_C_m)<= 10e-06))
               
               C_upd(:,m) = C_m_new;
               
               
               
               break;
               
           end
           
           %update
           C_m_old = C_m_new;
    end
           
    C_upd(:,m) = C_m_old;
    
end

end            
    