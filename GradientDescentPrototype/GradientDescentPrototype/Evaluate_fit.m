error = 4:1:20;

for n= 4:20
    str1 = strcat('/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/Training with orthogonality/Increased_penalty/ADOS_sub/ADOS_workspace_qp_',num2str(n),'_net.mat');
    load(str1)
    error(n-3) = norm(C_gd'*W_gd-Y);
end

figure; plot(4:1:20,error)
title('Error vs networks')
xlabel('no of networks')
ylabel('Frobenius norm Error')