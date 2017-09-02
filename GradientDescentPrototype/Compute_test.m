function C_gd_test = Compute_test(B_gd,corr_test)
%computes the coefficient matrix C_gd_test for the patients in the held out
%test dataset

B_left = pinv(B_gd);
B_right = pinv(B_gd');

C_gd_test = zeros(size(B_gd,2),size(corr_test,1));

for i = 1:size(corr_test,1)
    
    C_n = B_left*reshape(corr_test(i,:,:),[size(corr_test,2),size(corr_test,3)])*B_right;
    C_gd_test(i,:) = diag(C_n)';
    
end

end