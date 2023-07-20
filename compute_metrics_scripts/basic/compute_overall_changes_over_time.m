clear all, close all

% these are general features of the data. I'll save them into "global
% parameters"
addpath('../../saved_calculations/basic');
addpath('../../functions/basic');

n_time_scans = 4;
n_subjects = 48;
Ts = 2.75;
n = 350; 
verbose = 1;
n_channels = 44;

save('../../saved_calculations/basic/global_parameters.mat','n_time_scans','n_subjects','Ts','n','n_channels');

%% Pearson and Connectivity Domain 
% Here I work on averaged connectivity matrices

% i calculate average connectivity matrices to see overall effects. 
who = 'all';
measure = 'rsquared';
averaged_rsquared_connectivities = compute_averaged_connectivities(n_time_scans,n_subjects,who,verbose,measure);
save('../../saved_calculations/basic/averaged_rsquared_connectivities.mat','averaged_rsquared_connectivities');
