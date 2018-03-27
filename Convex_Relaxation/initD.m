function D_init = initD(B_init,C_init)

for j = 1:size(C_init,2)
    D_init(j,:,:) = B_init*diag(C_init(:,j));
end 

end