function nonpar_anova_wilcoxon(matrix,n_time_scans,name_statistic)
% you give a matrix, it does nonparametric anova to 
% see if there are differences in groups. Than performs
% pairwise wilcoxon. NOTE HERE IM DOING IT ONLY WITH SURVIVORS

matrix(matrix == Inf) = NaN;
idx = ~isnan(matrix(:,end));

matrix = matrix(idx,:); % I take only survivors at T4
[panova,tbl,~] = kruskalwallis(matrix); % this is nonparametric ANOVA
fprintf(['\n                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\nmeasure: ' name_statistic]);
fprintf(sprintf('\nNonparametric ANOVA (kruskal wallis) p-value: %d',panova));
fprintf('\n');
fprintf('\n');
tbl = cell2table(tbl,'VariableNames',{'Source' 'SS' 'df' 'MS' 'Chi-sq' 'Prob>Chi-sq'});
disp(tbl(2:end,:));
fprintf('\n');
for i=1:(n_time_scans-1)
    %now I have created a matrix with only the common element. I an now do
    %wilcoxon 
    p = signrank(matrix(:,i),matrix(:,i+1));
    fprintf([sprintf('T%d vs T%d',i,i+1),'  wilcoxon p value = ',num2str(p),'\n        ---------']);
    fprintf('\n');
end
fprintf('\nmeans:');
fprintf('%d ',nanmean(matrix));
fprintf('\nstds:');
fprintf('%d ',nanstd(matrix));

end

