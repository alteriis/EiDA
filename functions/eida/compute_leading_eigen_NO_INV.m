function leading_eigenvectors = compute_leading_eigen_NO_INV(timeseries,n_channels,n,verbose)
%this is a modification from Fran's function. She does slightly different
%processings that I discarded at the moment

% 1 filter the data (in another function)

% 2 compute hilbert transform. Then compute phase locking matrix for each
% time point take eigenvector

for i=1:n_channels
    %ts=detrend(signal(seed,:)-mean(signal(seed,:))); ???????!!!
    timeseries(:,i) = angle(hilbert(timeseries(:,i)));
end

leading_eigenvectors = zeros(n_channels,n);

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
    
    [v1,~]=eigs(phase_lock_matrix,1);
    % no inversion of eigenvector here!
    leading_eigenvectors(:,t) = v1;
    
    
end

leading_eigenvectors = leading_eigenvectors(:,2:end-1);

end

