 clear all
%% Parameters 
 
 P = 116;
 N = 66;
 K = 4;
 p = 0;
 perc =0.25;
 net_ind_1 = randperm(P) ;
 net_ind = reshape(net_ind_1(1:end-p*4),[(P-p*4)/K,K]);

 sigma_w = 0.5*ones(K,1);
 mu_w = zeros(K,1);
 
 sigma_C = 4*ones(K,N);
 mu_C = zeros(K,N);
 
 sigma_corr =0.8*ones(P,P);
 sigma_y = ones(N,1);
 
 sigma_B = 0.2* ones(P,K);
 mu_B = zeros(P,K);
 
Q = zeros(N,P,P);

for i = 1:N
    
    A = rand(P);
    SymA = (A+A')/2 ;
    Q(i,:,:) = reshape(double(SymA>perc),[1,P,P]);
    
end
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
 
corr = zeros(N,P,P);
 
for n = 1:N
    B*diag(C(:,n))*B'
    Q_n = reshape(Q(n,:,:),[P,P]);
    corr(n,:,:) = normrnd(Q_n.*(B*diag(C(:,n))*B'),sigma_corr);
    Corr_mat = reshape(corr(n,:,:),[size(corr,2),size(corr,3)]);
    corr(n,:,:) = (Corr_mat+ Corr_mat')/2;
end
 
save('Simulated_Data_multimodal.mat','B','C','Y','W','corr','Q')