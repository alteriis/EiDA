function metastab = obtain_metastability(timeseries_HILBERT,idx,n_clusters,threshold_occurrence) % remember to use this fcn you should give hilbert trnasform of timeseries!!!

metastab = zeros(1,n_clusters);
occurrences_clusters = obtain_fractional_occurrences(idx,n_clusters);


for i=1:n_clusters
    timeseries_belonging_cluster = timeseries_HILBERT(idx==i,:);
    Z = abs(sum(exp(1i*timeseries_belonging_cluster),2)/(size(timeseries_belonging_cluster,1))); % abs(mean(sum of e itheta(t)))
    if(occurrences_clusters(i)>threshold_occurrence) % if i don't have enough of that state...makes no sense to compute meta
        metastab(i) = std(Z);
    else
        metastab(i) = NaN;
    end
    %     RSN_SYNC(i) = mean(Z);  % this would be for the synchrony
end


end