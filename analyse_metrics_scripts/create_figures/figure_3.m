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

[p1,p2,m1,m2] = visualize_phase_space_connectivity_eigenvalues(leading_eigen);

subplot(1,4,i)
plot(p1,m1,'.','color','blue','linewidth',0.25,'color',colorv1);
hold on
plot(p2,m2,'.','color','red','linewidth',0.25,'color',colorv2);
plot(mean(p1),mean(m1),'+','color','black','linewidth',1);
plot(mean(p2),mean(m2),'+','color','black','linewidth',1);
xlim([-1 45]);
xline(22,'color','black');
normx = 0.1;
normy = 44*normx/(1.1+normx);
ylim([-normx 1.1]);
xticks([0 22 44]);
yticks([0 0.5 1]);

if i==1
    xlabel('position')
    ylabel('reconf speed')
end

[y,x] = ksdensity(p1);
[y1,x1] = ksdensity(p2);
plot(x,(normx)*y/0.2-normx,'linewidth',1,'color',colorv1);
hold on
plot(x1,(normx)*y1/0.2-normx,'linewidth',1,'color',colorv2);

[y,x] = ksdensity(m1);
[y1,x1] = ksdensity(m2);
plot(45-normy*y/6,x,'linewidth',1,'color',colorv1);
hold on
plot(45-normy*y1/6,x1,'linewidth',1,'color',colorv2);
set(gca,'fontname','arial');
axes3(i) = gca;
end

linkaxes(axes3);
f3.Position = [100 100 750 150];
saveas(f3,sprintf('./fig3/phase_space_pdf_rat%d.svg',subj));
close(f3);


%% Plot evolution of momenta as a fcn of age,
load('overall_speed1_vectors.mat');
load('overall_speed2_vectors.mat');

overall_speed1_vectors(overall_speed1_vectors==Inf) = NaN;
overall_speed2_vectors(overall_speed2_vectors==Inf) = NaN;

f = figure;
errorbar([3 5 11 17],nanmean(overall_speed1_vectors),nanstd(overall_speed1_vectors),'color',colorv1,'linewidth',1.25);
hold on
errorbar([3 5 11 17],nanmean(overall_speed2_vectors),nanstd(overall_speed2_vectors),'color',colorv2,'linewidth',1.25);
xticks([3 5 11 17]);
yl = ylim;
ylim('padded');
range = yl(2)-yl(1);
yticks([yl(1)+0.15*range 0.5*yl(1)+0.5*yl(2) yl(2)-0.15*range]);
ytickformat('%.2f')
set(gca,'fontname','arial') 

f.Position = [100 100 200 200];
xlabel('age (months)');
ylabel('reconf speed')
saveas(f,'./fig3/speed_evolution.fig');
close(f);
nonpar_anova_wilcoxon(overall_speed1_vectors,n_time_scans,'speed1')
nonpar_anova_wilcoxon(overall_speed2_vectors,n_time_scans,'speed2')
% plot eigs 

load('overall_eig1_vectors.mat');

overall_eig1_vectors(overall_eig1_vectors==Inf) = NaN;

f = figure;
errorbar([3 5 11 17],nanmean(overall_eig1_vectors),nanstd(overall_eig1_vectors),'color',colorv1,'linewidth',1.25);
hold on
errorbar([3 5 11 17],n_channels-nanmean(overall_eig1_vectors),nanstd(overall_eig1_vectors),'color',colorv2,'linewidth',1.25);
xticks([3 5 11 17]);
yl = ylim;
yticks([yl(1) 0.5*yl(1)+0.5*yl(2) yl(2)]);
set(gca,'fontname','arial') 
f.Position = [100 100 200 200];
xlabel('age (months)');
ylabel('avg eigenvalue')
saveas(f,'./fig3/eig1_evolution.fig');
close(f);
nonpar_anova_wilcoxon(overall_eig1_vectors,n_time_scans,'eig1')

%% Plot Informational Complexity

load('overall_connectivity_zip_leida_vectors.mat');


overall_connectivity_zip_leida_vectors(overall_connectivity_zip_leida_vectors==Inf) = NaN;

f = figure;
errorbar([3 5 11 17],nanmean(overall_connectivity_zip_leida_vectors),nanstd(overall_connectivity_zip_leida_vectors),'color','black','linewidth',1.25);
set(gca,'fontname','arial') 
yl = ylim;
ylim('padded');
range = yl(2)-yl(1);
yticks([yl(1)+0.15*range 0.5*yl(1)+0.5*yl(2) yl(2)-0.15*range]);
ytickformat('%.2f')
f.Position = [100 100 200 200];
xlabel('age (months)');
ylabel('informational complexity')
nonpar_anova_wilcoxon(overall_connectivity_zip_leida_vectors,n_time_scans,'zip complexity')
saveas(f,'./fig3/zip_evolution.fig');

close(f);

%% Show 2 cases of interest where the evolution is different 

[~,timeseries_young] = load_rat_matrix(1,subj,0);
[~,timeseries_old] = load_rat_matrix(4,subj,0);

time_old = 278;
time_young = 108;

load('2_leading_eigenvectorsT1_subject2.mat');
rescale_factor_1 = max(max(leading_eigen(1:n_channels,time_young:time_young+10)));
rescale_factor_2 = max(max(leading_eigen(n_channels+1:end,time_young:time_young+10)));
load('2_leading_eigenvectorsT4_subject2.mat');
if max(max(leading_eigen(1:n_channels,time_old:time_old+10)))>rescale_factor_1
    rescale_factor_1 = max(max(leading_eigen(1:n_channels,time_old:old+10)));
end
if max(max(leading_eigen(n_channels+1:end,time_old:time_old+10)))>rescale_factor_2
    rescale_factor_2 = max(max(leading_eigen(n_channels+1:end,time_old:time_old+10)))>rescale_factor_2;
end


load('2_leading_eigenvectorsT1_subject2.mat');
for i = time_young:time_young+6
    subplot(7,1,i-time_young+1);
    plot_eigenvector(leading_eigen(1:n_channels,i),1,rescale_factor_1,0);
    axis off
end
f = gcf;
saveas(f,'./fig3/young_vector1_evolution.svg');
close(f);

for i = time_young:time_young+6
    subplot(7,1,i-time_young+1);
    plot_eigenvector(leading_eigen(n_channels+1:end,i),0,rescale_factor_2,0);
    axis off
end
f = gcf;
saveas(f,'./fig3/young_vector2_evolution.svg');
close(f);

load('2_leading_eigenvectorsT4_subject2.mat');
for i = time_old:time_old+6
    subplot(7,1,i-time_old+1);
    plot_eigenvector(leading_eigen(1:n_channels,i),1,rescale_factor_1,0);
    axis off
end
f = gcf;
saveas(f,'./fig3/old_vector1_evolution.svg');
close(f);

for i = time_old:time_old+6
    subplot(7,1,i-time_old+1);
    plot_eigenvector(leading_eigen(n_channels+1:end,i),0,rescale_factor_2,0);
    axis off
end
f = gcf;
saveas(f,'./fig3/old_vector2_evolution.svg');
close(f);

%% Visualise time course of interest
f = figure;
set(gca,'fontname','arial') 
f.Position = [100 100 100 500];
visualise_time_course(timeseries_young(time_young-20:time_young+30,:),Ts,1,1);
axis off
saveas(f,'./fig3/young_timeseries.svg');
close(f);

f = figure;
set(gca,'fontname','arial') 
f.Position = [100 100 100 500];
visualise_time_course(timeseries_old(time_old-20:time_old+30,:),Ts,1,1);
axis off
saveas(f,'./fig3/old_timeseries.svg');
close(f);

%% Show when first eigenvector is less than a threshold percentage 

load('overall_eig_min_70_vectors.mat');
load('overall_eig_min_65_vectors.mat');
load('overall_eig_min_60_vectors.mat');
load('overall_eig_min_55_vectors.mat');

overall_eig_min_70_vectors(overall_eig_min_70_vectors==Inf) = NaN;
overall_eig_min_65_vectors(overall_eig_min_65_vectors==Inf) = NaN;
overall_eig_min_60_vectors(overall_eig_min_60_vectors==Inf) = NaN;
overall_eig_min_55_vectors(overall_eig_min_55_vectors==Inf) = NaN;

f = figure;
errorbar([3 5 11 17],nanmean(overall_eig_min_70_vectors),0.5*nanstd(overall_eig_min_70_vectors),'color','black','linewidth',1.25);
hold on
errorbar([3 5 11 17],nanmean(overall_eig_min_65_vectors),0.5*nanstd(overall_eig_min_65_vectors),'color','black','linewidth',1.25);
hold on
errorbar([3 5 11 17],nanmean(overall_eig_min_60_vectors),0.5*nanstd(overall_eig_min_60_vectors),'color','black','linewidth',1.25);
hold on
errorbar([3 5 11 17],nanmean(overall_eig_min_55_vectors),0.5*nanstd(overall_eig_min_55_vectors),'color','black','linewidth',1.25);
xticks([3 5 11 17]);
yticks([0 .5 1]);
set(gca,'fontname','arial') 
f.Position = [100 100 200 200];
xlabel('age (months)');
ylabel('irred index')
f = gcf;
saveas(f,'./fig3/percentage_eig1.fig');
close(f);

%% correlate speeds
[r,sign]=correlate_measures(overall_speed1_vectors,overall_speed2_vectors,1);
xl = xlim;
yl = ylim;
xticks([xl(1) 0.5*xl(1)+0.5*xl(2) xl(2)]);
yticks([yl(1) 0.5*yl(1)+0.5*yl(2) yl(2)]);
legend off
set(gca,'fontname','arial') 
f = gcf;
f.Position = [100 100 200 200];
xl = xlim;
yl = ylim;
xlabel('reconf speed 1');
ylabel('reconf speed 2');
fprintf('correlation = %d,significance=%d',r,sign);
saveas(f,'./fig3/correlation_speed.fig');
close(f);

%% correlate informational complexity with eig1
f = figure;
[r,sign]=correlate_measures(overall_eig1_vectors,overall_connectivity_zip_leida_vectors,1);
xl = xlim;
yl = ylim;
xticks([xl(1) 0.5*xl(1)+0.5*xl(2) xl(2)]);
yticks([yl(1) 0.5*yl(1)+0.5*yl(2) yl(2)]);
legend off
set(gca,'fontname','arial') 
f.Position = [100 100 200 200];
xlabel('first eigenvalue');
ylabel('informational complexity');
ytickformat('%.2f')
xtickformat('%.0f')
fprintf('\ncorrelation = %d,significance=%d',r,sign);
saveas(f,'./fig3/correlation_eig_zip.fig');
close(f);