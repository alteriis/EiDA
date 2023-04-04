[token,timeseries] = load_rat_matrix(1,2,0);

continuous_lead = compute_leading_eigen_continuous(timeseries,44,350,0);
lead = compute_leading_eigen(timeseries,44,350,0);
anal_lead = compute_leading_eigen_anal(timeseries,44,350,0);

correlations_continous = zeros(1,347);
correlations = zeros(1,347);
correlations_anal = zeros(1,347);

for i=1:347
    correlations_continous(i) = corr(continuous_lead(:,i),continuous_lead(:,i+1));
    correlations(i) = corr(lead(:,i),lead(:,i+1));
    correlations_anal(i) = corr(anal_lead(:,i),anal_lead(:,i+1));
end

ax1 = subplot(3,1,1);
plot(correlations_continous,'color','red');
title('corrected eigs');
ax2 = subplot(3,1,2);
plot(correlations,'color','red');
title('normal eigs');
ax3 = subplot(3,1,3);
plot(correlations_anal,'color','red');
title('analitical eigs');
linkaxes([ax1 ax2 ax3]);

sgtitle('Reconfiguration Process');
