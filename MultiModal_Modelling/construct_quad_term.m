function H_hat = construct_quad_term(B_upd,Q_mat)
%%function for estimation of the quadratic matrix term for the multimodal
%%case


H_hat = zeros(size(B_upd,2));

for i = 1:size(B_upd,2)
    
    T1 = B_upd(:,i)*B_upd(:,i)';
    
    for j = i:size(B_upd,2)
        
        T2 = B_upd(:,j)*B_upd(:,j)';
        
        H_hat(i,j) = sum(sum(((T1.*T2).*Q_mat).*Q_mat));
        H_hat(j,i) = H_hat(i,j);
        
    end
end

%symmetrise

end