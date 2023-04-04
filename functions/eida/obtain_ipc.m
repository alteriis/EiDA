function ipc = obtain_ipc(timeseries_HILBERT,idx,n_clusters,threshold_occurrence,treshold) % remember to use this fcn you should give hilbert trnasform of timeseries!!!
% this calculates the istantaneous phase coherence. It does it for every
% different clusters, but you can also do it altogether by giving as idx a
% vector of ones


ipc = zeros(1,n_clusters);
occurrences_clusters = obtain_fractional_occurrences(idx,n_clusters);


for i=1:n_clusters
    timeseries_belonging_cluster = timeseries_HILBERT(idx==i,:);
    Z = sum(exp(1i*timeseries_belonging_cluster),2)/(size(timeseries_belonging_cluster,1)); % abs(mean(sum of e itheta(t)))
    if(occurrences_clusters(i)>threshold_occurrence) % if i don't have enough of that state...makes no sense to compute meta
        ipc(i) = mean(angle(Z(abs(Z) > treshold)));  % the mean angle when sincro is high
    else
        ipc(i) = NaN;
    end
    %     RSN_SYNC(i) = mean(Z);  % this would be for the synchrony
end


end
