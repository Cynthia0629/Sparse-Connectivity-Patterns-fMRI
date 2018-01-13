
load('Real_Data_SRSTotal_cont.mat')

corr1 = zeros(size(corr));

for i  = 1:size(corr,1)
    
    %h = histogram(reshape(corr(i,:,:),[116,116]),50);
    %ind = find(h.BinCounts == max(h.BinCounts));
    %val = h.BinLimits(1) + (floor(mean(ind))-1) * h.BinWidth;
    val = median(reshape(corr(i,:,:),[116*116,1]));
    corr1(i,:,:) = corr(i,:,:) - val* ones(1,116,116);
    
end

corr = corr1;

save('Real_Data_SRSTotal_cont_median.mat','corr','Y')
