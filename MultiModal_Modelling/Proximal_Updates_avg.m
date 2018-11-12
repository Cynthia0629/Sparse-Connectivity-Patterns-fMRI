function [D_upd,lamb_upd] = Proximal_Updates_avg(corr,lamb,Q,D,B_upd,B_avg_upd,C_upd,lr)

num_iter_max = 100;
parfor k= 1:size(lamb,1)
        
     Corr_k = reshape(corr(k,:,:),[size(corr,2),size(corr,3)]);
     lamb_k =reshape(lamb(k,:,:),[size(lamb,2),size(lamb,3)]);
     Q_k =reshape(Q(k,:,:),[size(Q,2),size(Q,3)]);
     D_k_init = reshape(D(k,:,:),[size(D,2),size(D,3)]);
     C_k = C_upd(:,k);
     
     for c=1:num_iter_max
               
%         D_k = (B_upd*diag(C_upd(:,k))+ 2*Corr_k*B_upd - lamb_k)*pinv(eye(size(B_upd'*B_upd))+2*(B_upd'*B_upd));
        
%         grad_D_T1 = -2*(Q_k.*(Corr_k-B_avg_upd))*B_upd - lamb_k + B_upd*diag(C_upd(:,k));       
%         D_k = grad_desc(grad_D_T1,B_upd,Q_k,0.01,D_k_init);
        
        options = optimoptions('fmincon','Algorithm','trust-region-reflective','SpecifyObjectiveGradient',true);
        D_k = fmincon([@(D_pat)obj_func_d(D_pat,(Corr_k-B_avg_upd),B_upd,Q_k,lamb_k,C_k)],D_k_init,[],[],[],[],[],[],[],options);


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


function [F,G] = obj_func_d(D_pat,Corr_k,B_upd,Q_k,lamb_k,C_k)

F = norm(Corr_k-Q_k.*(D_pat*B_upd'),'fro').^2 + trace(lamb_k'*(D_pat-B_upd*diag(C_k))) + 0.5*norm(D_pat-B_upd*diag(C_k),'fro')^2;
G = 2*Q_k.*(Q_k.*(D_pat*B_upd')-Corr_k)*B_upd -lamb_k + B_upd*diag(C_k) +D_pat;

end
