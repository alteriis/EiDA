%% this produces additional material regarding the figure. In particular, 
% we have the study of position and reconf speed of the full iPL, not separate eigenvectors

% load overall things
clear 

addpath('../../saved_calculations/basic');
addpath('../../saved_calculations/leida/clusters');
addpath('../../saved_calculations/leida');
addpath('../../saved_calculations/leida/leading_eigenvectors');
addpath('../../saved_calculations/leida/full_matrix_decomposition');
addpath('../../saved_calculations/leida/2_leading_eigenvectors');
addpath('../../functions/basic');
addpath('../../functions/graphics');
load('global_parameters.mat');
load('palette.mat');
addpath('../../saved_calculations/nonlinear');
addpath('../../functions/nonlinear');
addpath('../../functions/leida');

%%
% insert what subject, what age you want

subj = 2;
f3 = figure;
axes3 =  [];

for i = 1:4

age = i;
load(sprintf('2_leading_eigenvectorsT%d_subject%d.mat',age,subj));

[p,m] = visualize_phase_space_connectivity_eigenvalues_new_algo(leading_eigen);

subplot(1,4,i)
plot(p,m,'.','linewidth',0.25,'color','black');
hold on
plot(mean(p),mean(m),'+','color','red','linewidth',1);
xlim([-1 45]);
normx = 0.1;
normy = 44*normx/(1.1+normx);
ylim([-normx 1.1]);
xticks([0 22 44]);
yticks([0 0.5 1]);

if i==1
    xlabel('position')
    ylabel('reconf speed')
end

[y,x] = ksdensity(p);
plot(x,(normx)*y/0.2-normx,'linewidth',1,'color','black');
[y,x] = ksdensity(m);
plot(45-normy*y/6,x,'linewidth',1,'color','black');
set(gca,'fontname','arial');
axes3(i) = gca;
end

linkaxes(axes3);
f3.Position = [100 100 750 150];
saveas(f3,sprintf('./fig3_NEW_ALGO/phase_space_pdf_rat%d.fig',subj));
close(f3);


%% Plot evolution of std reconf speed as a fcn of age,

load('overall_std_reconf_speed_vectors.mat');
std_reconf_speeds_vectors(std_reconf_speeds_vectors==Inf) = NaN;

f = figure;
errorbar([3 5 11 17],nanmean(std_reconf_speeds_vectors),nanstd(std_reconf_speeds_vectors),'color',colorv1,'linewidth',1.25);
xticks([3 5 11 17]);
yl = ylim;
yticks([yl(1) 0.5*yl(1)+0.5*yl(2) yl(2)]);
set(gca,'fontname','arial') 
f.Position = [100 100 200 200];
xlabel('age (months)');
ylabel('std reconf speed')
saveas(f,'./fig3_NEW_ALGO/std_speed_evolution.fig');
close(f);
nonpar_anova_wilcoxon(std_reconf_speeds_vectors,n_time_scans,'std reconf speed')

%% Plot evolution of mean reconf speed as a fcn of age,

load('overall_mean_reconf_speed_vectors.mat');
mean_reconf_speeds_vectors(mean_reconf_speeds_vectors==Inf) = NaN;

f = figure;
errorbar([3 5 11 17],nanmean(mean_reconf_speeds_vectors),nanstd(mean_reconf_speeds_vectors),'color',colorv1,'linewidth',1.25);
xticks([3 5 11 17]);
yl = ylim;
yticks([yl(1) 0.5*yl(1)+0.5*yl(2) yl(2)]);
set(gca,'fontname','arial') 
f.Position = [100 100 200 200];
xlabel('age (months)');
ylabel('avg reconf speed')
saveas(f,'./fig3_NEW_ALGO/mean_speed_evolution.fig');
close(f);
nonpar_anova_wilcoxon(mean_reconf_speeds_vectors,n_time_scans,'mean reconf speed')

