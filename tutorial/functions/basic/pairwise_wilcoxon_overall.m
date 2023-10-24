function pairwise_wilcoxon_overall(matrix,n_time_scans,name_statistic)
%PAIRWISE_WILCOXON_OVERALL you give a matrix, it returns pairwise wilcoxon
%tests for each couple of columns. In this case it discards rows where one
%of the two data are INF

for i=1:(n_time_scans-1)
    m = matrix(:,i:i+1);
    M = [];
    for j=1:size(m,1)
        if((m(j,1)+m(j,2)) ~= Inf && ~isnan(m(j,1)+m(j,2)))
            M = [M;[m(j,1) m(j,2)]];
        end
    end
    %now I have created a matrix with only the common element. I an now do
    %wilcoxon 
    p = signrank(M(:,1),M(:,2));
    fprintf([sprintf('T%d vs T%d',i,i+1),'\nstatistic = ',name_statistic,'\nwilcoxon p value = ',num2str(p),'\n        ---------']);
    fprintf('\n');
end
end

