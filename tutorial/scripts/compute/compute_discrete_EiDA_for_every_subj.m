%%

clear 
addpath('../../functions/eida');
addpath('../../functions/basic');


% please specify source folder and destionation folder
source_folder = '../../data/example_fmri_eigenvectors'; 
destination_folder = '../../data/example_fmri_discrete_eida';

% please specify n of clusters
n_clusters = 4;
N = 44; % number of signals

%% discrete EiDA (clustering of eigenvectors)

elements_in_dir = dir(source_folder);
eigenvectors_concatenated = []; % discrete EiDa does clustering of all the eigenvectors concatenated for a group
list_names = {}; % I will do this list to save for each separate timeseries the timeseries of 
% states and the distances 
durations = []; % i need durations of eigenvector timeseries

for i=1:numel(elements_in_dir)
    if numel(elements_in_dir(i).name)>3 && strcmp(elements_in_dir(i).name(end-2:end),'mat')
        eigenvectors = struct2cell(load([source_folder '/' elements_in_dir(i).name]));
        list_names{end+1} = elements_in_dir(i).name;
        eigenvectors = eigenvectors{1};
        durations = [durations size(eigenvectors,2)];
        eigenvectors_concatenated = [eigenvectors_concatenated;eigenvectors(1:N,:)']; % i transpose because k means wants this format. Note that I'm taking only the leading eigenvvetor
    end
end

% note: here I am using just the leading eigenvector (indeed I take
% eigenvectors(1:N). to perform classic MAtlab implemented kmeans. If you
% want to run the clustering as in the paper, DONT STACK the 2
% eigenvectors, it will not work. You will have to run the discrete eida
% algorithm (see functions of the paper)

[idx, centroids, sum_distances, d]=kmeans(eigenvectors_concatenated,n_clusters,'Distance','Cosine','Replicates',300,'MaxIter',400,'Display','final','Options',statset('UseParallel',1));

for i=1:numel(list_names)
    state_timeseries = idx(sum(durations(1:i-1))+1:sum(durations(1:i)));
    state_distances = d(sum(durations(1:i-1))+1:sum(durations(1:i)),:);
    save([destination_folder '/' list_names{i}(1:end-4) '_discrete_eida_timeseries_n_clusters=' num2str(n_clusters)],'state_timeseries','state_distances');

end


save([destination_folder sprintf('/discrete_eida_centroids_n_clusters=%d',n_clusters)],'centroids','sum_distances');
