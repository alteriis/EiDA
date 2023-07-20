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

%% insert what subject, what age you want
age = 1;
subj = 2;

[~,timeseries] = load_rat_matrix(age,subj,0);
visualise_time_course(timeseries,Ts,1,1,0);
set(findall(gca, 'Type', 'Line'),'LineWidth',2);
ax = gca;
axis off

transf = hilbert(timeseries);
figure
visualise_time_course(angle(transf),Ts,.18,1,0);
set(findall(gca, 'Type', 'Line'),'LineWidth',2);
ax2 = gca;

linkaxes([ax ax2]);

%%

load('matrix_decompositionT1_subject2.mat');
time_start = 110;

for i = 1:10
    figure
    c = matrix_decomposition(1:n_channels,time_start+i);
    s = matrix_decomposition(n_channels+1:end,time_start+i);
    imagesc(c*c'+s*s');
    axis off
    f = gcf;
    saveas(f,sprintf('./fig1/ipl%d.svg',i));
    close(f);
end

