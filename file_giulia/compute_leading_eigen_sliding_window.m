function leading_eigenvectors = compute_leading_eigen_sliding_window(timeseries,half_window_size,verbose, data_specific_info, num_eigen) 
% here I compute pearson correlation matrices using a sliding window. Then
% I take eigenvectors to do dimensionality reduction

% data_specific_info is a cell that contains n subcells where n corresponds
% to the number of groups. Each subcell has two values, the first is the
% name of the group and the second is the size of that group

if num_eigen > 2*half_window_size
    error('Number of requested eigenvectors is too large');
end

s = floor(2* sqrt(half_window_size));

n_channels = size(timeseries,2);
n = size(timeseries,1);
m = size(data_specific_info,2);

leading_eigenvectors = zeros(n_channels*num_eigen,n);

% we extract the group size and labels for each individual group from the cell 
g_size = zeros(1,m);
label_names = cell(1,m,1);

for i=1:m
    g_size(i) = cell2mat(data_specific_info{1,i}(1,2));
    label_names(i) = data_specific_info{1,i}(1,1);
end 

if(verbose)
    figure('units','normalized','outerposition',[0 0 1 1]); %this sets the figure to be full screen
end

for t=1:n
    lower_bound = max(t-half_window_size,1);
    upper_bound = min(t+half_window_size,n);
    istantaneous_conn_matrix= corrcoef(timeseries(lower_bound:upper_bound,:));

     % Gathering eigenvectors (columns of v) and eigenvalues (diagonal of a)
    [v,a] = eigs(istantaneous_conn_matrix,num_eigen);

    eigen_val = diag(a);

    for i = 1:num_eigen
        v(:,i) = v(:,i) * sqrt(eigen_val(i));
    end

    for k = 1:num_eigen
       leading_eigenvectors((k-1)*n_channels+1:k*n_channels, t) = v(:,k);
    end

    if(verbose)
        % [left bottom width height]
        subplot('Position', [0.06 0.15 0.40 0.3])
        imagesc(timeseries);
        add_labels(g_size, label_names, gca);
        title('Instantaneous Connectivity Matrix');
        
        subplot('Position', [0.55 0.15 0.44 0.3])
        visualise_time_course(timeseries, data_specific_info);
        xline(t, 'LineWidth', 2);
        hold off; 
        title('Signals Over Time');

        for i = 1:num_eigen
            subplot(s,ceil(s/2),i)
            imagesc(leading_eigenvectors((i-1)*n_channels+1:i*n_channels)'*leading_eigenvectors((i-1)*n_channels+1:i*n_channels));
            graph_title = sprintf('v%d', i);
            title(graph_title);
        end
       
        end
        
        
    end

end



