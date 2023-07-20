function metas = obtain_state_metastabilities(occurrences,eigenvalues,n_clusters)
% Here I see the metastability for each cluster
occurrences = occurrences(2:end); % i remove the first value because the eigenvalue timeseries does.
% it does because it is calculated from the position-reconf speed function,
% which starts from time 2 becuase to define the speed you need time 2 and
% time 1
metas = zeros(1,n_clusters);
for i=1:n_clusters
    metas(i) = std(eigenvalues(occurrences==i));
end

end
