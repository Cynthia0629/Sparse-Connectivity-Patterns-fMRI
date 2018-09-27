for v = 1:14
    
    sim = zeros([100,1]);
    
    for k= 1:100
    
        in_filename = strcat('/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/Convex_Relaxation/Simulated_Data_NonAvg/Sparsity/Simulated_Data_set_',num2str(v),'_out_',num2str(k),'.mat');
        load(in_filename)
        sim(k) = mean(max(abs(normc(B_gd)'*normc(B))));
    end
    
    out_filename =strcat('/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/Convex_Relaxation/Simulated_Data_NonAvg/Sparsity/Errs_',num2str(v));
    save(out_filename,'sim','params')
    
    clearvars
end