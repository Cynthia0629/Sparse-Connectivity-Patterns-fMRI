function K = compute_kernel(C,sigma)

N = size(C,2);
K = zeros(N);

for i= 1:N
    for j=i:N
        
        c_i = C(:,i);
        c_j = C(:,j);
        
        [K(i,j),~] = Ker_NL(c_j,c_i,sigma);
  
    end
end

K = K + K'-diag(diag(K));
end