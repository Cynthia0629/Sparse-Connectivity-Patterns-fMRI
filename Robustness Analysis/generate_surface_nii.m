

aal_atlas = load_nii('/home/niharika-shimona/Documents/Projects/Autism_Network/Data/7E1EC9C11EC972A7/aal_MNI_V4.nii');


for ind = 7
    
    folder = '/home/niharika-shimona/Documents/Projects/Autism_Network/Results/Sparse connectivity patterns/10_fold_CV_new/v2/ADOS_CV' ;
    str1 = strcat(folder,'/workspace_',num2str(ind),'_net_10_fold_test10.mat');
    load(str1)
    aal_atlas_new = aal_atlas;
    aal_atlas_new.img = double(zeros(size(aal_atlas.img)));
    
    for k= 1:size(B_thresh,2)
        
        for m = 1:size(B_thresh{k},2) 
            b = B_gd{k}(:,m);
            
            node_map = b;
                
            for u = 1:116
                l = find(aal_atlas.img==u);           
                aal_atlas_new.img(l) = double(b(u)*100);  
          
            end
          

            str3 = strcat(folder,'/Nii_Files/Node_map_net_',num2str(ind),'_set_',num2str(k),'_net_no_',num2str(m),'.nii');
            save_nii(aal_atlas_new,str3)
        end
    end
end
