function K = compute_kernel(C,sigma)
%compute kernel matrix K

N = size(C,2);
K = zeros(N);

for i= 1:N
    for j=i:N
      
        c_i = C(:,i);
        c_j = C(:,j);
        
        [K(i,j),~] = Ker_NL(c_j,c_i,sigma);
        K(j,i) =K(i,j);
        
    end
end


end