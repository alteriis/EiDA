% load overall things
clear 

addpath('../../saved_calculations/basic');
addpath('../../saved_calculations/leida/clusters');
addpath('../../saved_calculations/leida/leading_eigenvectors');
addpath('../../saved_calculations/leida/full_matrix_decomposition');
addpath('../../saved_calculations/leida/2_leading_eigenvectors');
addpath('../../functions/basic');
addpath('../../functions/graphics');
addpath('../../saved_calculations/nonlinear');
addpath('../../saved_calculations/leida');
addpath('../../functions/nonlinear');
addpath('../../functions/leida');
addpath('../basic');

load('global_parameters.mat');
load('palette.mat');

%%

load('averaged_ipl_connectivities.mat');
load('averaged_rsquared_connectivities.mat');

bound = max([max(max(averaged_ipl_connectivities{1})) max(max(averaged_ipl_connectivities{2})) max(max(averaged_ipl_connectivities{3})) max(max(averaged_ipl_connectivities{4}))]);
bound2 = max([max(max(averaged_rsquared_connectivities{1})) max(max(averaged_rsquared_connectivities{2})) max(max(averaged_rsquared_connectivities{3})) max(max(averaged_rsquared_connectivities{4}))]);
bound = max(bound,bound2);

f = figure;
for i = 1:n_time_scans
    subplot(1,n_time_scans,i);
    imagesc(averaged_ipl_connectivities{i},[0 bound]);
    axis off
end

f.Position = [100 100 1000 200];
saveas(f,'./fig2/ipl_matrices.fig');
close(f);


f = figure;
for i = 1:n_time_scans
    subplot(1,n_time_scans,i);
    imagesc(averaged_rsquared_connectivities{i},[0 bound]);
    axis off
end

f.Position = [100 100 1000 200];
saveas(f,'./fig2/correlation_matrices.fig');
close(f);

f = figure;
colorbar
saveas(f,'./fig2/colorbar.svg');
close(f);

%%

for i = 1:n_time_scans
    fprintf('\ncorrelation t%d, %.4d',i,corr(averaged_rsquared_connectivities{i}(:),averaged_ipl_connectivities{i}(:)));
end

%% plot matrices 
load('overall_ipl_frobenius_vectors.mat');
overall_ipl_frobenius_vectors(overall_ipl_frobenius_vectors==Inf) = NaN;
f = figure;
errorbar([3 5 11 17],nanmean(overall_ipl_frobenius_vectors),nanstd(overall_ipl_frobenius_vectors),'color','black','linewidth',1.25);
hold on
xticks([3 5 11 17]);
set(gca,'fontname','arial') 
f.Position = [100 100 200 200];
xlabel('age (months)');
ylabel('norm of average ipl matrix')
saveas(f,'./fig2/ipl_norm_evolution.fig');
close(f);
nonpar_anova_wilcoxon(overall_ipl_frobenius_vectors,n_time_scans,'FC index for ipl matrix')

load('average_frobenius_connectivities.mat');
average_frobenius_connectivities(average_frobenius_connectivities==Inf) = NaN;
f = figure;
errorbar([3 5 11 17],nanmean(average_frobenius_connectivities),nanstd(average_frobenius_connectivities),'color','black','linewidth',1.25);
hold on
xticks([3 5 11 17]);
set(gca,'fontname','arial') 
f.Position = [100 100 200 200];
xlabel('age (months)');
ylabel('norm of correlation matrix')
saveas(f,'./fig2/correlation_norm_evolution.fig');
close(f);
nonpar_anova_wilcoxon(average_frobenius_connectivities,n_time_scans,'FC index correlation matrix')

%% 

f = figure;
[r,sign]=correlate_measures(average_frobenius_connectivities,overall_ipl_frobenius_vectors,1);
legend off
set(gca,'fontname','arial') 
f.Position = [100 100 200 200];
xlabel('correlation matrix norm');
ylabel('average ipl matrix norm');
fprintf('\ncorrelation = %d,significance=%d',r,sign);
saveas(f,'./fig2/correlation.fig');
close(f);





