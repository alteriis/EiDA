% load overall things
clear 

addpath('../../saved_calculations/basic');
addpath('../../saved_calculations/leida/clusters');
addpath('../../saved_calculations/leida/leading_eigenvectors');
addpath('../../saved_calculations/leida/full_matrix_decomposition');
addpath('../../saved_calculations/leida/2_leading_eigenvectors');
addpath('../../functions/basic');
addpath('../../functions/graphics');
load('global_parameters.mat');
load('palette.mat');
addpath('../../saved_calculations/nonlinear');
addpath('../../saved_calculations/leida');
addpath('../../functions/nonlinear');
addpath('../../functions/leida');
addpath('../basic');

%% correlate measures

load('overall_eig_meta_vectors.mat');
load('overall_metastability_vectors.mat');
f = figure;
[result_fit,gof] = fit_quadratic_measures(overall_eig_meta_vectors,overall_metastability_vectors,1);
xlabel('eigenvalue metastability')
ylabel('metastability')
ytickformat('%.2f')
set(gca,'fontname','arial') 
set(gca,'fontsize',8.5)
f.Position = [100 100 226 226];
legend off
saveas(f,'./fig4/metastab_correlation.fig');
fprintf('adj rsq = %d \n',gof.adjrsquare)
close(f);

%% Plot trajectories of spectral metastability
f = figure;
plot_trajectories(overall_eig_meta_vectors);
ylabel('spectral metastability');
set(gca,'fontname','arial');
set(gca,'fontsize',8.5)
f.Position = [100 100 226 226];
legend off
saveas(f,'./fig4/spectral_metastability.fig');
close(f);
nonpar_anova_wilcoxon(overall_eig_meta_vectors,n_time_scans,'spectral metastability');
%% Plot trajectories of normal metastability
f = figure;
plot_trajectories(overall_metastability_vectors);
ylabel('metastability');
set(gca,'fontname','arial');
set(gca,'fontsize',8.5)
f.Position = [100 100 226 226];
saveas(f,'./fig4/metastability.fig');
close(f);
nonpar_anova_wilcoxon(overall_metastability_vectors,n_time_scans,'metastability');

