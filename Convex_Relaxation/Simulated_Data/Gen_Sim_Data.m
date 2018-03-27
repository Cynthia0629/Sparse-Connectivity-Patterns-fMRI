 clearvars -except params set sig_y sig_corr nonz
%% Parameters 
 
 P = 116;
 N = 66 ;
 K = 4;
 p = params.nnz;
 net_ind_1 = randperm(P) ;
 net_ind = reshape(net_ind_1(1:end-p*4),[(P-p*4)/K,K]);

 sigma_w = 0.5*ones(K,1);
 mu_w = zeros(K,1);
 
 sigma_C = 2*ones(K,N);
 mu_C = zeros(K,N);
 
 sigma_corr =params.sig_corr*ones(P,P);
 sigma_y = params.sig_y * ones(N,1);
 
 sigma_B = 0.2* ones(P,K);
 mu_B = zeros(P,K);
 
 %% Initialisations
 
W = abs(normrnd(mu_w,sigma_w));
C = abs(normrnd(mu_C,sigma_C));
% C(C<0)=0;
% C = rand(K,N);
Y = normrnd(C'*W,sigma_y);
 
B = normrnd(mu_B,sigma_B);
 
for k = 1:K
     
     nz_ind = net_ind(:,k);
     b_k = zeros(P,1);
     b_k(nz_ind,:) = 1;
     b_k(net_ind_1(end-p*4+1:end),:) = 1;
     B(:,k) = B(:,k).*b_k;
     
end
 
%B = laprnd(P,K,0,1);
corr = zeros(N,P,P);
 
for n = 1:N
%   B*diag(C(:,n))*B'
    corr(n,:,:) = normrnd(B*diag(C(:,n))*B',sigma_corr);
    Corr_mat = reshape(corr(n,:,:),[size(corr,2),size(corr,3)]);
    corr(n,:,:) = (Corr_mat+ Corr_mat')/2;
end
 
save(strcat('/home/niharika-shimona/Documents/Projects/Autism_Network/Sparse-Connectivity-Patterns-fMRI/Convex_Relaxation/Simulated_Data_2/Simulated_Data',num2str(set),'.mat'),'B','C','Y','W','corr','params')