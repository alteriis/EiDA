function output = obtain_cluster_timeseries(age,subj,availability_matrix,clusters,duration)
%OBTAIN_CLUSTER_TIMESERIES this function I give the subject and the number
% of clusters of the clustering and returns the timeseries for the specific
% rat at the specific age. Availability matrix is a 48x4 matrix where I
% have 0 if there is no availability for that data otherwise 1. Duration is
% the time series duration. In our case 348 because clusters miss first and
% last element of timeseries

if availability_matrix(subj,age) == 0
    output = 0;
    return
else
    number_of_preceding = sum(availability_matrix(1:subj-1,age)); % this should work even when subject is 1
    output = clusters(duration*number_of_preceding+1:(number_of_preceding+1)*duration);
     
end

end

