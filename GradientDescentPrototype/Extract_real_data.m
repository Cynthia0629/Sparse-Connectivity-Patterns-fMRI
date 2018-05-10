clear all

load('/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/Data_Simulation/praxis_errors.mat')

% x_aut = vertcat(x_aut,x_cont);
N = size(x_aut,1);
P = 116;

corr = zeros(N,P,P);

for i = 1:N
    count =1;
    for j=1:116
       
        corr(i,j,j) = 1.0;
        
        for k=j+1:116
            
            corr(i,j,k) =x_cont(i,count);
            corr(i,k,j) =x_cont(i,count);
            
            count = count+1;
            
        end
    end
    [V,D] = eig(reshape(corr(i,:,:),P,P));
    d_max = find(diag(D) ==max(diag(D)));
    corr(i,:,:) = corr(i,:,:)- reshape(D(d_max,d_max)*V(:,d_max)*V(:,d_max)',[1,P,P]);
    
end


Y = y_cont;

save('Real_Data_Praxis_Cont.mat','Y','corr')