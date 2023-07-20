%% load overall things
clear
close all

addpath('../../saved_calculations/basic');
addpath('../../saved_calculations/leida/clusters_full_means');
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

%%




n_clusters_tot = 10;
sum_squared = zeros(n_clusters_tot,n_time_scans);


for age=1:n_time_scans
    % load all eigenvectors to compute distances
    leading_eigenvectors_concatenated = [];
    for i=1:n_subjects
        if isfile(sprintf('../../saved_calculations/leida/2_leading_eigenvectors/2_leading_eigenvectorsT%d_subject%d.mat',age,i))
            load(sprintf('2_leading_eigenvectorsT%d_subject%d.mat',age,i));
            leading_eigen = leading_eigen';
            leading_eigenvectors_concatenated = [leading_eigenvectors_concatenated; leading_eigen];
        end
    end
    for n_clusters = 1:n_clusters_tot
        load(sprintf('../../saved_calculations/leida/clusters_full_means/T%d_n_clusters%d.mat',age,n_clusters));
        distances = zeros(size(leading_eigenvectors_concatenated,1),1);
        for i =1:size(leading_eigenvectors_concatenated,1)
            distances(i) = eida_distance_centroid_eigen(C_out(idx_out(i),:)',leading_eigenvectors_concatenated(i,:)');
        end
        sum_squared(n_clusters,age) = mean(distances);
        fprintf('\n done n clusters %d age %d',n_clusters,age);
    end
end
%%

f=figure;
plot(mean(sum_squared,2),'Color','black','LineWidth',1.2);
xline(3,'color','red');
set(gca,'fontname','arial')
set(gca,'fontsize',8.5)
f.Position = [100 100 115 115];
saveas(f,'./additional_1/elbow.fig');
close(f);


