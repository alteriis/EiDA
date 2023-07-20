clear all
% load overall things
addpath('../../saved_calculations/basic');
addpath('../../functions/basic');
addpath('../../functions/leida');
load('global_parameters.mat');

verbose = 0;

%% Compute EIDA with both eigenvectors

lowest_freq = 0.01;
highest_freq = 0.08;

for i=1:n_time_scans
    for j=1:n_subjects
        [token,timeseries] = load_rat_matrix(i,j,verbose); % iniziamo a fare così
        if(token)
            timeseries = filter_datamatrix(timeseries,lowest_freq,highest_freq,n_channels,Ts);
            leading_eigen = compute_2_leading_eigen(timeseries,n_channels,n,verbose);
            name = sprintf('T%d_subject%d',i,j);
            save(['../../saved_calculations/leida/2_leading_eigenvectors/2_leading_eigenvectors' name '.mat'],'leading_eigen');
            fprintf('saved_T%d, rat %d\n',i,j);
        end
    end
end
