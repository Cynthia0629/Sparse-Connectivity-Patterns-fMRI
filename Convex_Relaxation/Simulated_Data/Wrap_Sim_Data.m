
set =1;

for sig_y = 0.2
    for sig_corr = 0.01:0.05:0.8
        for nonz = 4:2:18
            
            params.sig_y =sig_y;
            params.sig_corr =sig_corr;
            params.nnz = nonz;
            Gen_Sim_Data;
            set = set+1;
        end
    end
end