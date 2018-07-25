
clear all 
close all

load('/media/nsalab/Users/avenka14/Legacy/CSAIL_Files/Schiz_BWH/MAT_CONN/Xconn_tot.mat')

conn_strarray = patient(:,1);
a = strmatch('SZ',patient(:,2));

% A_conn = zeros(size(patient,1),size(ConnMat_tot,2),size(ConnMat_tot,2));
A_conn = zeros(size(a,1),size(ConnMat_tot,2),size(ConnMat_tot,2));

count = 1;

for i = 1:size(patient,1)
    
    if strcmp('SZ',patient(i,2))
        
        conn_mat = zeros(size(ConnMat_tot,1),size(ConnMat_tot,2));
        int_conn = Xconn_tot(:,count);
        conn_mat(sqInd) = int_conn';
    
        A_conn(count,:,:) = conn_mat+conn_mat'+ eye(size(conn_mat));
        count = count +1; 
    end
        
end

load('/media/nsalab/Users/avenka14/Legacy/CSAIL_Files/Schiz_BWH/MAT_CONN/Xcorr_tot.mat')

F_corr = zeros(size(A_conn));
count =1;

for i = 1:size(patient,1)
    
    ind = strmatch(patient(i,1),conn_strarray);
    corr_mat = zeros(size(ConnMat_tot,1),size(ConnMat_tot,2));
    
    if ~(isempty(ind))
                
        int_corr = Xcorr_tot(:,ind);
        corr_mat(sqInd) = int_corr';
    
        F_corr(count,:,:) = corr_mat+corr_mat'+ eye(size(corr_mat));
        count = count+1;
        
    end
    
end

save('Real_Data_DTI_fMRI_SZ.mat','A_conn','F_corr')