% load overall things
clear
close all

addpath('../../saved_calculations/basic');
addpath('../../saved_calculations/leida/clusters_2');
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
addpath('../../functions/leida/eida_discrete/eida_discrete');

load('global_parameters.mat');
load('palette.mat');


%% here i do it with "my" leida 2 clusters
n_clusters = 3;
f=figure;
limits = [-1 1];
clusters_magnitudes = zeros(n_time_scans,n_clusters);

permutations = {[2 1 3],[1 2 3],[2 1 3],[2 3 1]}; % clusters come in random order, so I have to permute them. This will change if you rerun clustering

for age = 1:n_time_scans
    load(sprintf('../../saved_calculations/leida/clusters_full_means/T%d_n_clusters%d.mat',age,n_clusters));
    for cl = 1:n_clusters
        subplot(n_clusters,n_time_scans,n_time_scans*(cl-1)+age);
        index = permutations{age}(cl);
        pl = unpack_matrix(C_out(index,:),n_channels);
        imagesc(pl,limits);
        clusters_magnitudes(index,age) = norm(pl,'fro');
        xticks('');
        yticks('');
    end
end

sgtitle('Leida-clusters');
f.Position = [100 100 400 400];
saveas(f,sprintf('./fig5_NEW_ALGO/clusters%d.svg',n_clusters));
close(f);

% plot(clusters_magnitudes);


%% now I want to rearrange clusters and see the duration..occurrence et al for each of them 

load('3_clusters_fractional_occurrences.mat'); 
load('3_clusters_durations.mat');
load('/home/k21208334/rat_ageing/matlab/dealteriis/saved_calculations/leida/clusters_full_means/3_clusters_metastabilities.mat');

rearranged_cluster_durations = zeros(size(cluster_durations));
rearranged_fractional_occurrences = zeros(size(cluster_durations));
rearranged_cluster_metastabilities = zeros(size(cluster_durations));

for age = 1:n_time_scans 
    for subj = 1:n_subjects
        for i =1:3 
            if(permutations{age}(i) == 1)
                rearranged_cluster_durations(age,:,1) = cluster_durations(age,:,i);
                rearranged_fractional_occurrences(age,:,1) = cluster_fractional_occurrences(age,:,i);
                rearranged_cluster_metastabilities(age,:,1) = cluster_metastabilities(age,:,i);
            elseif(permutations{age}(i) == 2)
                rearranged_cluster_durations(age,:,2) = cluster_durations(age,:,i);
                rearranged_fractional_occurrences(age,:,2) = cluster_fractional_occurrences(age,:,i);
                rearranged_cluster_metastabilities(age,:,2) = cluster_metastabilities(age,:,i);
            else
                rearranged_cluster_durations(age,:,3) = cluster_durations(age,:,i);
                rearranged_fractional_occurrences(age,:,3) = cluster_fractional_occurrences(age,:,i);
                rearranged_cluster_metastabilities(age,:,3) = cluster_metastabilities(age,:,i);
            end
        end
    end
end

for i = 1:n_clusters

    data = squeeze(rearranged_fractional_occurrences(:,:,i)');
    data(data==Inf) = NaN;
    f = figure;
    errorbar([3 5 11 17],nanmean(data),nanstd(data),'color','black','linewidth',1.25);
    hold on
    xticks([3 5 11 17]);
    ytickformat('%.2f')
    set(gca,'fontname','arial')
    set(gca,'fontsize',8.5)
    f.Position = [100 100 115 115];
    saveas(f,sprintf('./fig5_NEW_ALGO/fractional_%d.fig',i));
    close(f);
    nonpar_anova_wilcoxon(data,n_time_scans,sprintf('fractional occurrence of cluster %d',i));

    data = squeeze(rearranged_cluster_durations(:,:,i)');
    data(data==Inf) = NaN;
    f = figure;
    errorbar([3 5 11 17],nanmean(data),nanstd(data),'color','black','linewidth',1.25);
    hold on
    xticks([3 5 11 17]);
    set(gca,'fontname','arial')
    set(gca,'fontsize',8.5)
    f.Position = [100 100 115 115];
    saveas(f,sprintf('./fig5_NEW_ALGO/duration_%d.fig',i));
    close(f);
    nonpar_anova_wilcoxon(data,n_time_scans,sprintf('avg duration of cluster %d',i));

    data = squeeze(rearranged_cluster_metastabilities(:,:,i)');
    data(data==Inf) = NaN;
    f = figure;
    errorbar([3 5 11 17],nanmean(data),nanstd(data),'color','black','linewidth',1.25);
    hold on
    xticks([3 5 11 17]);
    set(gca,'fontname','arial')
    set(gca,'fontsize',8.5)
    f.Position = [100 100 115 115];
    saveas(f,sprintf('./fig5_NEW_ALGO/meta_%d.fig',i));
    close(f);
    nonpar_anova_wilcoxon(data,n_time_scans,sprintf('metastability of cluster %d',i));


end



