function leading_eigenvectors = compute_leading_eigen_pearson_mod(timeseries,half_window_size,verbose, data_specific_info, num_eigen) 
% here I compute pearson correlation matrices using a sliding window. Then
% I take eigenvectors to do dimensionality reduction

% data_specific_info is a cell that contains n subcells where n corresponds
% to the number of groups. Each subcell has two values, the first is the
% name of the group and the second is the size of that group

if num_eigen > 2*half_window_size
   error('Number of requested eigenvectors is too large');
end

n_channels = size(timeseries,2);
n = size(timeseries,1);
m = size(data_specific_info,2);

% we extract the group size of each individual group from the cell 
g_size = zeros(1,m);
for i=1:m
    g_size(i) = cell2mat(data_specific_info{1,i}(1,2));
end 

% we extract the labels for each individual group from the cell 
label_names = cell(1,m,1);
for i=1:m
    label_names(i) = data_specific_info{1,i}(1,1);
end

leading_eigenvectors = zeros(n_channels,n);

for t=1:n
    lower_bound = max(t-half_window_size,1);
    upper_bound = min(t+half_window_size,n);
    istantaneous_conn_matrix= corrcoef(timeseries(lower_bound:upper_bound,:));
    if(verbose)

        subplot(1,2,1);
        imagesc(istantaneous_conn_matrix);% here you have to do the same plots as the matrix with hilbert transform, moreover, add the timeseries as I asked
        add_labels (m, g_size, label_names); 
        title('Instantaneous Connectivity Matrix')
        pause(0.1)

        subplot(1,2,2);
        plot(timeseries);
        title('Signals Over Time')

        for t = 1:length(timeseries)
            if t == 1
                l = xline(t, 'LineWidth', 2);
            else
                set(l, 'Value', t);
            end
            pause(0.1);
        end
        delete(l);
    end

    [v,~]=eigs(istantaneous_conn_matrix,num_eigen); 

    for k = 1:num_eigen % I'm not sure if this part is at all correct 
        leading_eigenvectors(:,t) = v(k);
    end
    

end

