% this code computes overall metastability for the signal
clear all
% load overall things
addpath('../../saved_calculations/leida/leading_eigenvectors');
addpath('../../saved_calculations/leida/clusters');
addpath('../../saved_calculations/basic');
addpath('../../functions/basic');
addpath('../../functions/leida');
load('global_parameters.mat');

verbose = 0;

lowest_freq = 0.01;
highest_freq = 0.08;
verbose = 0;


overall_metastability_vectors = zeros(n_time_scans,n_subjects);
load('timeseries_availability.mat');

for age = 1:n_time_scans
    for subj = 1:n_subjects
        if ~timeseries_availability(subj,age)
            overall_metastability_vectors(age,subj) = Inf;
        else
            [~,timeseries] = load_rat_matrix(age,subj,verbose);
            timeseries = filter_datamatrix(timeseries,lowest_freq,highest_freq,n_channels,Ts);
            for i=1:n_channels
                timeseries(:,i) = hilbert(timeseries(:,i));
            end
            timeseries = timeseries(2:end-1,:);
            overall_metastability_vectors(age,subj) = obtain_metastability(timeseries,ones(1,n-2),1,0.15);
            
        end
    end
end

%%
overall_metastability_vectors = overall_metastability_vectors'; 
save('/home/k21208334/rat_ageing/matlab/dealteriis/saved_calculations/leida/overall_metastability_vectors','overall_metastability_vectors');



