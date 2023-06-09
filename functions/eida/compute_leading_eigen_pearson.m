function leading_eigenvectors = compute_leading_eigen_pearson(timeseries,half_window_size,verbose) % YOU CAN EASILY INSERT THE THRESHOLD IF NECESSARY
% here I compute pearson correlation matrices using a sliding window. Then
% I take eigenvectors to do dimensionality reduction

n_channels = size(timeseries,2);
n = size(timeseries,1);

leading_eigenvectors = zeros(n_channels,n);

if(verbose)
    figure
end

for t=1:n
    lower_bound = max(t-half_window_size,1);
    upper_bound = min(t+half_window_size,n);
    istantaneous_conn_matrix= corrcoef(timeseries(lower_bound:upper_bound,:));

    if(verbose)
        imagesc(istantaneous_conn_matrix); % here you have to do the same plots as the matrix with hilbert transform, moreover, add the timeseries as I asked
        pause(0.15)
    end
    [v1,~]=eigs(istantaneous_conn_matrix,1); % here you may want to specify more than 1 eigenvector
    leading_eigenvectors(:,t) = v1; 

end


end

