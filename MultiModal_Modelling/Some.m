
for thresh= 0:0.2:0.2
for  lambda_2 =[0.2:0.2:0.5]
for lambda_1 = 10
lambda_3 =1.2;lambda =1.2;net=8;
sta = '/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/MultiModal_Modelling/Training_runs/Non_Avg/Values/Thresh_';
st = strcat(sta,num2str(thresh))
test_script_non_avg
clearvars -except lambda lambda_1 lambda_2 lambda_3 net offs st thresh
end
end
end