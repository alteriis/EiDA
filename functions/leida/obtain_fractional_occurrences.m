function fractional = obtain_fractional_occurrences(occurrences,n_clusters)
%Here I just see how long every cluster state lasts

fractional = zeros(1,n_clusters);
for i=1:n_clusters
    fractional(i) = sum(occurrences==i);
end
fractional = fractional/numel(occurrences);
end

