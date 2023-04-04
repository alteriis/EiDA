function leading_eigenvalues = compute_leading_eigenvalues(timeseries,n_channels,n,verbose)
% computes the 6 leading eigenvalues

for i=1:n_channels
    %ts=detrend(signal(seed,:)-mean(signal(seed,:))); ???????!!!
    timeseries(:,i) = angle(hilbert(timeseries(:,i)));
end

leading_eigenvalues = zeros(6,n);

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
    values=eigs(phase_lock_matrix);

    leading_eigenvalues(:,t) = values;
    
    
end

leading_eigenvalues = leading_eigenvalues(:,2:end-1);

end

