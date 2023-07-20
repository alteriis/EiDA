
clear all
% load overall things
addpath('../../saved_calculations/leida/leading_eigenvectors');
addpath('../../saved_calculations/leida/2_leading_eigenvectors');
addpath('../../saved_calculations/basic');
addpath('../../functions/basic');
addpath('../../functions/leida');
addpath('../../functions/leida/eida_discrete/eida_discrete');
load('global_parameters.mat');


n_clusters_tot = 10;


%% Do it with full EiDA (2 eigens) + discrete_eida

for age=1:n_time_scans
    for n_clusters = 1:n_clusters_tot
        leading_eigenvectors_concatenated = [];
        for i=1:n_subjects
            if isfile(sprintf('../../saved_calculations/leida/2_leading_eigenvectors/2_leading_eigenvectorsT%d_subject%d.mat',age,i))
                load(sprintf('2_leading_eigenvectorsT%d_subject%d.mat',age,i));
                leading_eigen = leading_eigen';
                leading_eigenvectors_concatenated = [leading_eigenvectors_concatenated; leading_eigen];
            end
        end

        % I reduced the number of trials...lets discuss parameters set
        [idx_out,C_out,Obj_out] = discrete_eida(leading_eigenvectors_concatenated,n_clusters,1000,10,123,true);
        save(sprintf('../../saved_calculations/leida/clusters_full_means/T%d_n_clusters%d.mat',age,n_clusters),'idx_out','C_out','Obj_out');

    end
end


