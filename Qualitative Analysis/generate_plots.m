for i = 1:size(B_gd,2)
    
    close all
    
    figure1 = figure; subplot(1,2,1)
    
    imagesc(B_gd{i})
    colormap('jet')
    colorbar
    title('connections matrix')
    
    subplot(1,2,2)
    imagesc(C_gd{i})
    colormap('jet')
    colorbar
    title('coefficients matrix')
    
    img_filename  = strcat(st,'/figure_conn_',num2str(i),'.jpg');
    saveas(figure1,img_filename)

end