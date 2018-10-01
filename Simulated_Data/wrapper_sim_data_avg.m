set =1;

for sig_y =0.05
    for sig_corr = 0.2
        for nonz = 0
            
            params.sig_y =sig_y;
            params.sig_corr =sig_corr;
            params.nnz = nonz;
            Gen_Sim_Data_avg;
            set = set+1;
        end
    end
end