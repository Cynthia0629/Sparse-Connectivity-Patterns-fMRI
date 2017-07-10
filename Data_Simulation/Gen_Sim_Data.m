 clear all
%% Parameters 
 
 P = 116;
 N = 60 ;
 K = 4;
 
 net_ind = randperm(P) ;
 net_ind = reshape(net_ind,[P/K,K]);

 sigma_w = 0.9*ones(K,1);
 mu_w = ones(K,1);
 
 sigma_C = 0.01*ones(K,N);
 mu_C = ones(K,N);
 
 sigma_corr = 0.01*ones(P,P);
 sigma_y = ones(N,1);
 
 sigma_B = 0.2* ones(P,K);
 mu_B = zeros(P,K);
 
 %% Initialisations
 
W = normrnd(mu_w,sigma_w);
C = normrnd(mu_C,sigma_C);
% C(C<0)=0;
% C = rand(K,N);
Y = normrnd(C'*W,sigma_y);
 
B = normrnd(mu_B,sigma_B);
 
for k = 1:K
     
     nz_ind = net_ind(:,k);
     b_k = zeros(P,1);
     b_k(nz_ind,:) = 1;
     B(:,k) = B(:,k).*b_k;
     
end
 
corr = zeros(N,P,P);
 
for n = 1:N
    B*diag(C(:,n))*B'
    corr(n,:,:) = normrnd(B*diag(C(:,n))*B',sigma_corr);
     
end
 
save('Simulated_Data.mat','B','C','Y','W','corr')