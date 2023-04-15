function leading_eigenvectors = compute_leading_eigen_pearson_mod(timeseries,half_window_size,verbose,group_size, label_names) % YOU CAN EASILY INSERT THE THRESHOLD IF NECESSARY
% here I compute pearson correlation matrices using a sliding window. Then
% I take eigenvectors to do dimensionality reduction

n_channels = size(timeseries,2);
n = size(timeseries,1);

leading_eigenvectors = zeros(n_channels,n);

for t=1:n
    lower_bound = max(t-half_window_size,1);
    upper_bound = min(t+half_window_size,n);
    istantaneous_conn_matrix= corrcoef(timeseries(lower_bound:upper_bound,:));
    if(verbose)
        subplot(1,2,1);
        imagesc(istantaneous_conn_matrix);% here you have to do the same plots as the matrix with hilbert transform, moreover, add the timeseries as I asked
        add_labels (size(group_size,2), group_size, label_names); 
        pause(0.1)
        subplot(1,2,2);
        plot(timeseries);
        title('Signals Over Time'); 
        l = xline(t, 'LineWidth', 2);
        pause(0.1)
        delete(l);
    end
    [v1,~]=eigs(istantaneous_conn_matrix,1); % here you may want to specify more than 1 eigenvector
    leading_eigenvectors(:,t) = v1; 
end


