function [D_upd,lamb_upd] = Proximal_Updates_NL(corr,lamb,B_upd,C_upd,lr)

num_iter_max = 100;
parfor k= 1:size(lamb,1)
        
     Corr_k = reshape(corr(k,:,:),[size(corr,2),size(corr,3)]);
     lamb_k =reshape(lamb(k,:,:),[size(lamb,2),size(lamb,3)]);
     
     for c=1:num_iter_max
               
       D_k = (B_upd*diag(C_upd(:,k))+ 2*Corr_k*B_upd - lamb_k)*pinv(eye(size(B_upd'*B_upd))+2*(B_upd'*B_upd));
         
       lamb_k = lamb_k + (0.75^(c-1))*lr*(D_k - B_upd*diag(C_upd(:,k)));
        
        if (c ==1)
            grad_norm_init = norm(D_k - B_upd*diag(C_upd(:,k)),2);
        end
        
        if (norm(D_k - B_upd*diag(C_upd(:,k)),2)/grad_norm_init<10e-06)
           break;
        end
        %lr1=lr1*0.5;
        
     end
     
     lamb_upd(k,:,:)= lamb_k;
     D_upd(k,:,:) =D_k;
     
end



end
