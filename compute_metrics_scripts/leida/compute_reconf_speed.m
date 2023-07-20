clear all
% load overall things
addpath('../../saved_calculations/leida/2_leading_eigenvectors');
addpath('../../saved_calculations/basic');
addpath('../../functions');
addpath('../../functions/leida');
load('global_parameters.mat');

mean_reconf_speeds_vectors = zeros(n_subjects,n_time_scans);
std_reconf_speeds_vectors = zeros(n_subjects,n_time_scans);

for age=1:n_time_scans
    
    for i=1:n_subjects
        if isfile(sprintf('../../saved_calculations/leida/2_leading_eigenvectors/2_leading_eigenvectorsT%d_subject%d.mat',age,i))
            load(sprintf('2_leading_eigenvectorsT%d_subject%d.mat',age,i));
            [~,s] = visualize_phase_space_connectivity_eigenvalues_new_algo(leading_eigen);
            mean_reconf_speeds_vectors(i,age) = mean(s);
            std_reconf_speeds_vectors(i,age) = std(s);
        else
            mean_reconf_speeds_vectors(i,age) = Inf;
            std_reconf_speeds_vectors(i,age) = Inf;
        end
        
    end
    
    save('../../saved_calculations/leida/overall_mean_reconf_speed_vectors.mat','mean_reconf_speeds_vectors');
    save('../../saved_calculations/leida/overall_std_reconf_speed_vectors.mat','std_reconf_speeds_vectors');

end



