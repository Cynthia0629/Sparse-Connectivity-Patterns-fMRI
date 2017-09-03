function plot_qual_res(B_gd,C_gd)
%%Visualise qualitative results for algorithmic run
b = zeros(size(B_gd,2),1);
c = zeros(size(B_gd,2),1);

for i= 1:size(B_gd,2)
    
 b(i) = norm(B_gd(:,i));
 c(i) = norm(C_gd(i,:));
    
end
b.^2.*c
figure;
plot(1:i,b,'r')
hold on;
plot(1:i,c,'g')
legend('Networks','Coefficients')
title('Qualitative Comparisons')
hold off;
end