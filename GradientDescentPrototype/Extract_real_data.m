clear all

load('/home/niharika-shimona/Documents/Projects/Autism_Network/code/Dimensionality-Reduction/Datasets_SRS.TotalRaw.Score.mat')

% x_aut = vertcat(x_aut,x_cont);
N = size(x_cont,1);
P = 116;

corr = zeros(N,P,P);

for i = 1:N
    count =1;
    for j=1:116
       
        corr(i,j,j) = 1.0;
        
        for k=j+1:116
            
            corr(i,j,k) =x_aut(i,count);
            corr(i,k,j) =x_aut(i,count);
            
            count = count+1;
            
        end
    end
    
end


Y = y_cont;

save('Real_Data_SRSTotal_cont.mat','Y','corr')