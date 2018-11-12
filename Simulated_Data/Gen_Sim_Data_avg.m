 clearvars -except params set sig_y sig_corr nonz
%% Parameters 
 
 P = 116;
 N = 58 ;
 K = 4;
 p = params.nnz;
 net_ind_1 = randperm(P) ;
 net_ind = reshape(net_ind_1(1:end-p*4),[(P-p*4)/K,K]);

 sigma_C = 2*ones(K,N);
 mu_C = [zeros(K,N/2),zeros(K,N/2)];
 
 sigma_corr =params.sig_corr*ones(P,P);
 sigma_y = ones(N,1);
 
 sigma_B = 0.2* ones(P,K);
 mu_B = zeros(P,K);
 
%  B_avg = (rand(P)).* (1-eye(P)) +eye(P);
%  B_avg = (B_avg + B_avg')/2;

B_avg = zeros(P,P);
 %% Initialisations
 
C = abs(normrnd(mu_C,sigma_C));
% C(C<0)=0;
% C = rand(K,N);

phi_C = [];

for i = 1:size(C,2)
   
    f_c_i = poly_ker(C(:,i));
    phi_C = horzcat(phi_C,f_c_i');
    
end

sigma_w = 0.5*ones(size(phi_C,1),1);
mu_w = zeros(size(phi_C,1),1);
W = abs(normrnd(mu_w,sigma_w));

Y = normrnd(phi_C'*W,params.sig_y.*(phi_C'*W));

B = normrnd(mu_B,sigma_B);
 
for k = 1:K
     
     nz_ind = net_ind(:,k);
     b_k = zeros(P,1);
     b_k(nz_ind,:) = 1;
     b_k(net_ind_1(end-p*4+1:end),:) = 1;
     B(:,k) = B(:,k).*b_k;
     
end
 
corr = zeros(N,P,P);
 
for n = 1:N
%     B*diag(C(:,n))*B'
    
    corr_mat_temp = B_avg+B*diag(C(:,n))*B';
    
    corr(n,:,:) = normrnd(corr_mat_temp,sigma_corr*max(max(corr_mat_temp)));
    Corr_mat = reshape(corr(n,:,:),[size(corr,2),size(corr,3)]);
    corr(n,:,:) = (Corr_mat+ Corr_mat')/2;
    
end
 
filename = strcat('/home/niharika-shimona/Documents/Projects/Autism_Network/Sparse-Connectivity-Patterns-fMRI/Simulated_Data/Simulated_Data_set_polybias_',num2str(set),'.mat');
save(filename,'B','B_avg','C','Y','W','corr','params')