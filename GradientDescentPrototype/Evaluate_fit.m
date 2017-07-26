error = 4:1:30;

for n= 4:30
    str1 = strcat('/home/niharika-shimona/Documents/Projects/Autism_Network/Sparse-Connectivity-Patterns-fMRI/ADOS_runs/workspace_qp_',num2str(n),'_net.mat');
    load(str1)
    error(n-3) = norm(C_gd'*W_gd-Y);
end

figure; plot(4:1:30,error)
title('Error vs networks')
xlabel('no of networks')
ylabel('Frobenius norm Error')