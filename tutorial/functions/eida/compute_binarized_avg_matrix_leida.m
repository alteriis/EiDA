function avg_bin_matrix = compute_binarized_avg_matrix_leida(timeseries,n_channels,n,verbose,treshold)
%this is a modification from Fran's function. She does slightly different
%processings that I discarded at the moment

% 1 filter the data (in another function)

% 2 compute hilbert transform. Then compute phase locking matrix for each
% time point take eigenvector

for i=1:n_channels
    %ts=detrend(signal(seed,:)-mean(signal(seed,:))); ???????!!!
    timeseries(:,i) = angle(hilbert(timeseries(:,i)));
end

avg_bin_matrix = zeros(n_channels,n_channels);

if(verbose)
    figure
end

for t=1:n
    phase_lock_matrix = zeros(n_channels,n_channels);
    for i=1:n_channels
        for j=i:n_channels
            phase_lock_matrix(i,j) = cos(timeseries(t,i)-timeseries(t,j));
        end
    end
    for i=2:n_channels
        for j=1:i-1
            phase_lock_matrix(i,j) = phase_lock_matrix(j,i);
        end
    end
    if(verbose)
        imagesc(phase_lock_matrix);
        pause(0.15)
    end
    
    phase_lock_matrix = abs(phase_lock_matrix) > treshold;
    avg_bin_matrix = avg_bin_matrix + phase_lock_matrix;
    
end


end

