

aal_atlas = load_nii('/home/niharika-shimona/nsalab-mceh/Users/ndsouza4/Projects/Autism_Network/code/aal_MNI_V4.nii');
%aal_atlas_patient = load_nii('/home/niharika-shimona/Documents/Projects/Autism_Network/Data/7E1EC9C11EC972A7/0335/20071214/Functionals/fsnwc50fwepia.nii.gz');
folder = '/home/niharika-shimona/nsalab-mceh/Users/ndsouza4/Projects/Autism_Network/Convex_Relaxation/ADOS_CV' ;
load(strcat( '/home/niharika-shimona/nsalab-mceh/Users/ndsouza4/Projects/Autism_Network/Convex_Relaxation/ADOS_CV/','B_temp.mat'))
mkdir(strcat(folder,'/Nii_Files'))
for ind = 8
    
    str1 = strcat(folder,'/workspace_out_8_net_10_fold_40_sparsity_0.2_regC__test10.mat');
    load(str1)
    aal_atlas_new = aal_atlas;
    aal_atlas_new.img = double(zeros(size(aal_atlas.img)));
    
    for k= 1
        
        for m = 1:size(B_gd{k},2)
            
            simil = normc(B_ref)'*normc(B_gd{k});
            j = find(abs(simil(m,:))== max(abs(simil(m,:))));
            b = B_gd{k}(:,j);
            
            node_map = sign(simil(m,j))*normc(b);
                
            for u = 1:116
                l = find(aal_atlas.img==u);           
                aal_atlas_new.img(l) = double(node_map(u));  
          
            end
          

            str3 = strcat(folder,'/Nii_Files/Node_map_net_',num2str(ind),'_network_no_',num2str(m),'.nii');
            aal_atlas_new.hdr.dime.datatype = 16;
            save_nii(aal_atlas_new,str3)
        end
    end
end
