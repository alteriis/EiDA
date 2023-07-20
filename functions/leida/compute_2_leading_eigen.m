function [leading_eigenvectors,eigenvalues] = compute_2_leading_eigen(timeseries,n_channels,n,verbose)
% Here I compute 2 eigenvalues, not 1. They are scaled by sqrt of
% eigenvalue and stacked. I use EiDA to compute them. 

% 1 filter the data (in another function)

% 2 compute hilbert transform. Then compute phase locking matrix for each
% time point take eigenvector

for i=1:n_channels
    timeseries(:,i) = angle(hilbert(timeseries(:,i)));
end

leading_eigenvectors = zeros(2*n_channels,n);
eigenvalues = zeros(1,n);

if(verbose)
    figure
end

for t=1:n
    
    c = cos(timeseries(t,:))';
    s = sin(timeseries(t,:))';
    P = c*c' + s*s';
    
    %now let's do them with my method
    
    sigma = s'*s;
    gamma = c'*c;
    xi = c'*s;
    delta = (gamma-sigma)^2+4*xi^2;
    B1 = ((sigma-gamma)+sqrt(delta))/(2*xi);
    B2 = ((sigma-gamma)-sqrt(delta))/(2*xi);
    
    v1 = c + B1*s;
    v2 = c + B2*s;
    v1 = v1/sqrt((v1'*v1)); % normalize
    v2 = v2/sqrt((v2'*v2));
    
    % find eigenvalues
    
    lambda1 = gamma+B1*xi;
    lambda2 = gamma+B2*xi;
    
    % make eigens such that they recreate matrix
    
    v1 = v1*sqrt(lambda1);
    v2 = v2*sqrt(lambda2);
    
    if(lambda2>lambda1)
        tmp = v2;
        v2 = v1;
        v1 = tmp;
    end
    
    if t>1 && (corr(v1,leading_eigenvectors(1:n_channels,t-1))<0)
        v1 = -v1;
    end
    
    if t>1 && (corr(v2,leading_eigenvectors(n_channels+1:end,t-1))<0)
        v2 = -v2;
    end
   
    leading_eigenvectors(:,t) = [v1; v2];
    
    if(verbose)
    subplot(2,2,1);
    imagesc(P);
    title(sprintf('iPL matrix, lambda1 = %d',lambda1));
    subplot(2,2,3);
    imagesc(v1*v1'+v2*v2');
    title('reconstructed');
    subplot(2,2,2);
    imagesc(v1*v1');
    title('v1');
    subplot(2,2,4);
    imagesc(v2*v2');
    title('v2');
    pause(0.5);
    end
end

leading_eigenvectors = leading_eigenvectors(:,2:end-1);

end

