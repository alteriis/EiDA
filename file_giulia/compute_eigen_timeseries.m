function [eigenvectors,eigenvalues] = compute_eigen_timeseries(timeseries,verbose, num_eigen)

% This function computes the timecourse of the 2 eigenvectors. They are scaled by sqrt of
% eigenvalues in order to recompose the full matrix. If verbose is true, plots a video of the iPL
% matrix. 

% timeseries must be a matrix. Each column is a signal. Each row is a time
% point. 

% detrend signal if needed 
if num_eigen > 2
   error('num_eigen must not be larger than 2');
end

n_channels = size(timeseries,2);
n = size(timeseries,1);

if (verbose)
    figure()
end

% compute hilbert transform for each signal Then compute phase locking matrix for each
% time point take eigenvector

for i=1:n_channels
    timeseries(:,i) = angle(hilbert(timeseries(:,i)));
end

eigenvectors = zeros(num_eigen*n_channels,n);
eigenvalues = zeros(1,n);

for t=1:n

    % for each time point, compute the iPL matrix, and the c and s vectors (see paper) that 
    % allow the computation of eigenvalues and eigenvectors
    
    c = cos(timeseries(t,:))';
    s = sin(timeseries(t,:))';
    iPL = c*c' + s*s';
    
    %I use analytical method to compute eigenvalues and eigenvectors (see
    % paper), by defining these quantitites
    
    sigma = s'*s;
    gamma = c'*c;
    xi = c'*s;
    delta = (gamma-sigma)^2+4*xi^2;

    B1 = ((sigma-gamma)+sqrt(delta))/(2*xi);
    B2 = ((sigma-gamma)-sqrt(delta))/(2*xi);
    
    v1 = c + B1*s;
    v2 = c + B2*s;
    v1 = v1/sqrt((v1'*v1)); % normalize eigenvectors. 
    v2 = v2/sqrt((v2'*v2));
    
    % find eigenvalues
    
    lambda1 = gamma+B1*xi;
    lambda2 = gamma+B2*xi;
    eigenvalues(t) = lambda1; % save biggest eigenvalue. The other is just n_channels-lambda1
    
    % scale eigenvectors by eigenvalues so that if I do v1*v1'+v2*v2' I
    % recreate the iPL matrix
    
    v1 = v1*sqrt(lambda1);
    v2 = v2*sqrt(lambda2);
    
    % we switch eigenvectors such that v1 is the leading one (the one with bigger eigenvalue) 

    if(lambda2>lambda1)
        tmp = v2;
        v2 = v1;
        v1 = tmp;
        eigenvalues(t) = lambda2;
    end
    
    % Eigenvectors multiplied by -1 are still eigenvectors. Thus, we invert
    % them if needed in order to have a timeseries of eigenvectors which
    % are all positively correlated. 

    if t>1 && (corr(v1,eigenvectors(1:n_channels,t-1))<0)
        v1 = -v1;
    end
    
    if t>1 && (corr(v2,eigenvectors(n_channels+1:end,t-1))<0)
        v2 = -v2;
    end
   
    % stack eigenvectors

    eigenvectors(:,t) = [v1; v2];
    
    % if verbose, plot matrix
    if(verbose)
        subplot(2,3,1);
        imagesc(iPL);
        title(sprintf('iPL matrix, lambda1 = %d',lambda1));
        subplot(2,3,4);
        imagesc(v1*v1'+v2*v2');
        title('reconstructed');
        subplot(2,3,2);
        imagesc(v1*v1');
        title('v1');
        subplot(2,3,5);
        imagesc(v2*v2');
        title('v2');
        pause(0.15);

        subplot(2,3,3);
        imagesc(timeseries);
        % add_labels (m, g_size, label_names); 
        title('Instantaneous Connectivity Matrix')
        pause(0.15)

        subplot(2,3,6);
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
end


% discard first and last timepoint as they are not meaningful 

eigenvectors = eigenvectors(:,2:end-1);
eigenvalues = eigenvalues(2:end-1);

end

