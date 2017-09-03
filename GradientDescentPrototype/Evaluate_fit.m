error = 4:1:14;

for n= 4:14
    str1 = strcat('/home/niharika-shimona/Documents/Projects/Autism_Network/Results/Sparse connectivity patterns/SRS_CA_sub_runs/SRS_workspace_qp_',num2str(n),'_net.mat');
    load(str1)
    error(n-3) = norm(C_gd'*W_gd-Y);
end

figure;
plot(4:14,error)
title('Error plot vs no of networks')
xlabel('networks')
ylabel('training error')