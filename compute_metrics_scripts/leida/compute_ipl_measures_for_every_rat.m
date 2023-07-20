clear all
% load overall things
addpath('../../saved_calculations/basic');
addpath('../../saved_calculations/leida/clusters');
addpath('../../saved_calculations/leida/leading_eigenvectors_continuous');
addpath('../../saved_calculations/leida/full_matrix_decomposition');
addpath('../../functions/basic');
addpath('../../functions/leida');
addpath('../../functions/nonlinear');
load('global_parameters.mat');
load('timeseries_availability.mat');
verbose = 0;

%%

overall_ipl_frobenius_vectors = inf(n_subjects,n_time_scans);
averaged_ipl_connectivities = cell(1,n_time_scans);

for age = 1:n_time_scans
    avg_ipl = zeros(n_channels,n_channels);
    for subj = 1:n_subjects
        if(timeseries_availability(subj,age))
            load(sprintf('matrix_decompositionT%d_subject%d.mat',age,subj));
            ipl = compute_average_ipl_matrix(matrix_decomposition);
            avg_ipl = avg_ipl+ipl.^2;
            overall_ipl_frobenius_vectors(subj,age) = norm(ipl,'fro');
        end
    end
    avg_ipl = avg_ipl/sum(timeseries_availability(:,age));
    averaged_ipl_connectivities{age}  = avg_ipl;
end

save('/home/k21208334/rat_ageing/matlab/dealteriis/saved_calculations/nonlinear/overall_ipl_frobenius_vectors.mat','overall_ipl_frobenius_vectors');
save('/home/k21208334/rat_ageing/matlab/dealteriis/saved_calculations/basic/averaged_ipl_connectivities.mat','averaged_ipl_connectivities');


