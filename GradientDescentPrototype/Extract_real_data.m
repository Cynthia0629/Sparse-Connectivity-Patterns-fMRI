clear all

load('/home/niharika-shimona/Documents/Projects/Autism_Network/code/Dimensionality-Reduction/Datasets_SRS.TotalRaw.Score.mat')

%x_aut = vertcat(x_aut,x_cont);
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
    Corr_mat = reshape(corr(i,:,:),[size(corr,2),size(corr,3)]);
    [V,D] = eig(Corr_mat);
    v1 = V(:,end);
    d1 = D(end,end);
    corr(i,:,:) = Corr_mat-v1*d1*v1';
end

Y= y_cont;
%Y = vertcat(y_aut,y_cont);

save('/home/niharika-shimona/Documents/Projects/Autism_Network/Sparse-Connectivity-Patterns-fMRI/Data_Simulation/Real_Data_SRSTotal_cont_sub.mat','Y','corr')