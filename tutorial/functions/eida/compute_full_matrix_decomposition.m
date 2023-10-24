function embedding_vectors = compute_full_matrix_decomposition(timeseries,n_channels,n,verbose)
% this function embeds the full phase locking matrix
% into a 2*n_channels dimensional array. In fact,
% it is possible to show analytically that
% PC = cos(theta) cos(theta)' + sin(theta) sin(theta)'

% 1 filter the data (in another function)

% 2 compute hilbert transform. Then compute phase locking matrix for each
% time point take eigenvector

for i=1:n_channels
    %ts=detrend(signal(seed,:)-mean(signal(seed,:))); ???????!!!
    timeseries(:,i) = angle(hilbert(timeseries(:,i)));
end

embedding_vectors = zeros(2*n_channels,n);

if(verbose)
    figure
end

for t=1:n
    
    c = cos(timeseries(t,:))';
    s = sin(timeseries(t,:))';
    
    if(verbose)
        imagesc(c*c'+s*s');
        pause(0.15)
    end
    
    embedding_vectors(:,t) = [c;s];
    
    
end

embedding_vectors = embedding_vectors(:,2:end-1);

end

