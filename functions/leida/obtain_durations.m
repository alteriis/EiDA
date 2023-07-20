function durations = obtain_durations(occurrences,n_clusters)
%Here I just see how long every cluster state lasts
durations = zeros(1,n_clusters);
for i=1:n_clusters
    connected_components = bwconncomp(occurrences==i);
    for j=1:connected_components.NumObjects
        durations(i) = durations(i)+numel(connected_components.PixelIdxList{j});
    end
    durations(i) = durations(i)/connected_components.NumObjects;
end

end

