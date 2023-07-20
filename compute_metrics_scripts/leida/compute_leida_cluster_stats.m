% this code computes the statistics for the leida clusters
clear 
% load overall things
addpath('../../saved_calculations/leida/leading_eigenvectors');
addpath('../../saved_calculations/leida/clusters');
addpath('../../saved_calculations/basic');
addpath('../../functions/basic');
addpath('../../functions/leida');
load('global_parameters.mat');


%% 
n_clusters = 3;
cluster_fractional_occurrences = zeros(n_time_scans,n_subjects,n_clusters);
cluster_durations = zeros(n_time_scans,n_subjects,n_clusters);
cluster_metastabilities = zeros(n_time_scans,n_subjects,n_clusters); %metastab for separate clusters
load('timeseries_availability.mat');

for age = 1:n_time_scans
    load(sprintf('/home/k21208334/rat_ageing/matlab/dealteriis/saved_calculations/leida/clusters_full_means/T%d_n_clusters%d.mat',age,n_clusters));
    for subj = 1:n_subjects
        if ~timeseries_availability(subj,age)
            cluster_fractional_occurrences(age,subj,:) = inf(1,n_clusters);
            cluster_durations(age,subj,:) = inf(1,n_clusters);
            cluster_metastabilities(age,subj,:) = inf(1,n_clusters);
        else
            load(sprintf('2_leading_eigenvectorsT%d_subject%d.mat',age,subj)); %need to load eigenvectors to recompute meta
            [eigenvalues,~,~,~] = visualize_phase_space_connectivity_eigenvalues(leading_eigen);

            occurrences = obtain_cluster_timeseries(age,subj,timeseries_availability,idx_out,n-2); % I say n-2 because in the timeseries we remove first and alst element
            cluster_durations(age,subj,:) = Ts*obtain_durations(occurrences,n_clusters); % nota lei nel suo codice fa una cosa un po' diversa...da discutere...
            cluster_fractional_occurrences(age,subj,:) = obtain_fractional_occurrences(occurrences,n_clusters);
            cluster_metastabilities(age,subj,:) = obtain_state_metastabilities(occurrences,eigenvalues,n_clusters);
        end
    end
end
        
% save('/home/k21208334/rat_ageing/matlab/dealteriis/saved_calculations/leida/clusters_full_means/3_clusters_fractional_occurrences','cluster_fractional_occurrences');
% save('/home/k21208334/rat_ageing/matlab/dealteriis/saved_calculations/leida/clusters_full_means/3_clusters_durations','cluster_durations');
save('/home/k21208334/rat_ageing/matlab/dealteriis/saved_calculations/leida/clusters_full_means/3_clusters_metastabilities','cluster_metastabilities');