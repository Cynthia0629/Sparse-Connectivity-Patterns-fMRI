function D_k = grad_desc(grad_D_T1,B_upd,Q_k,lr1,D_init)
%computes the gradient descent update for proximal variable D_n
lr = lr1;

D_k = D_init;
max_iter=150;

for i  = 1:max_iter
    
    grad_iter = grad_D_T1 + 2*(Q_k.*(Q_k.*(D_k*B_upd')))*B_upd +D_k;
     
    if (i==1)
        
        grad_iter_norm_init = norm(grad_iter,'fro');
         
    end
    
    fprintf('\n Iteration: %d || Gradient Value: %f ',i,norm(grad_iter,'fro'));
    
    D_k = D_k - lr*grad_iter;

    if (norm(grad_iter,'fro')/grad_iter_norm_init < 10e-04)
        break;
    end
    
end

end