function bin_eigenvectors = compute_binarized_vectors_pearson(timeseries,n_channels,n,half_window_size,threshold,verbose)
% This fcn computes for each time point a binarized matrix with only +1 0
% or -1 if I have significant positive, non significant, or significant
% negative connectivity


bin_eigenvectors = logical(zeros(n_channels*(n_channels-1)/2,n));

if(verbose)
    figure
end

for t=1:n
    istantaneous_conn_matrix = zeros(n_channels,n_channels);
    for i=1:n_channels
        for j=i:n_channels
            lower_bound = max(t-half_window_size,1);
            upper_bound = min(t+half_window_size,n);
            corr = corrcoef(timeseries(lower_bound:upper_bound,i),timeseries(lower_bound:upper_bound,j));
            corr = corr(2,1);           
            istantaneous_conn_matrix(i,j) = corr;
        end
    end
    for i=2:n_channels
        for j=1:i-1
            istantaneous_conn_matrix(i,j) = istantaneous_conn_matrix(j,i);
        end
    end
    %BINARIZE THE DATA 
    istantaneous_conn_matrix = abs(istantaneous_conn_matrix) > threshold;
    if(verbose)
        imagesc(istantaneous_conn_matrix);
        pause(0.15)
    end
    
    % take only upper triangular part
    M = istantaneous_conn_matrix;
    D = diag(M);
    v1 = squareform((M-diag(D)).');
    bin_eigenvectors(:,t) = v1;
   
end


end

