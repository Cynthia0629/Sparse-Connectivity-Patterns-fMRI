

aal_atlas = load_nii('/home/niharika-shimona/nsalab-mceh/Users/ndsouza4/Projects/Autism_Network/code/aal_MNI_V4.nii');
%aal_atlas_patient = load_nii('/home/niharika-shimona/Documents/Projects/Autism_Network/Data/7E1EC9C11EC972A7/0335/20071214/Functionals/fsnwc50fwepia.nii.gz');
folder = '/home/niharika-shimona/nsalab-mceh/Users/ndsouza4/Projects/Autism_Network/Results/Sparse connectivity patterns/10_fold_CV_new/23-10-2017/mod_2/SRS_Cont_CV' ;

mkdir(strcat(folder,'/Nii_Files'))
for ind = 12
    
    str1 = strcat(folder,'/workspace_',num2str(ind),'_net_10_fold.mat');
    load(str1)
    aal_atlas_new = aal_atlas;
    aal_atlas_new.img = double(zeros(size(aal_atlas.img)));
    
    for k= 1:size(B_thresh,2)
        
        for m = 1:size(B_thresh{k},2) 
            b = B_gd{k}(:,m);
            
            node_map = b;
                
            for u = 1:116
                l = find(aal_atlas.img==u);           
                aal_atlas_new.img(l) = double(b(u));  
          
            end
          

            str3 = strcat(folder,'/Nii_Files/Node_map_net_',num2str(ind),'_set_',num2str(k),'_net_no_',num2str(m),'.nii.gz');
            aal_atlas_new.hdr.dime.datatype = 16;
            save_nii(aal_atlas_new,str3)
        end
    end
end
