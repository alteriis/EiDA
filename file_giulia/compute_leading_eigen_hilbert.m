function [eigenvectors,eigenvalues] = compute_leading_eigen_hilbert(timeseries,verbose, num_eigen, data_specific_info)

% This function computes the timecourse of the 2 eigenvectors. They are scaled by sqrt of
% eigenvalues in order to recompose the full matrix. If verbose is true, plots a video of the iPL
% matrix. 

% timeseries must be a matrix. Each column is a signal. Each row is a time
% point. 

% detrend signal if needed 

% the data_specific_info parameter will be made optional

if num_eigen > 2
   error('num_eigen must not be larger than 2');
end

n_channels = size(timeseries,2);
n = size(timeseries,1);
m = size(data_specific_info,2);

% we extract the group size & label name of each individual group from the cell 
g_size = zeros(1,m);
label_names = cell(1,m,1);
for i=1:m
    g_size(i) = cell2mat(data_specific_info{1,i}(1,2));
    label_names(i) = data_specific_info{1,i}(1,1);
end 

for i=1:n_channels
    timeseries(:,i) = angle(hilbert(timeseries(:,i)));
end

% compute hilbert transform for each signal Then compute phase locking matrix for each
% time point take eigenvector

eigenvectors = zeros(num_eigen*n_channels,n);
eigenvalues = zeros(1,n);

if (verbose)
    figure('units','normalized','outerposition',[0 0 1 1]); %this sets the figure to be full screen
end

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

    % Eigenvectors multiplied by -1 are still eigenvectors. Thus, we invert
    % them if needed in order to have a timeseries of eigenvectors which
    % are all positively correlated. 
    
    if (num_eigen == 2)

        if(lambda2>lambda1)  % we switch eigenvectors such that v1 is the leading one (the one with bigger eigenvalue) 
        tmp = v2;
        v2 = v1;
        v1 = tmp;
        eigenvalues(t) = lambda2;
        end

        if t>1 && (corr(v2,eigenvectors(n_channels+1:end,t-1))<0)
        v2 = -v2;
        end

        eigenvectors(:,t) = [v1; v2]; 

    else

        if t>1 && (corr(v1,eigenvectors(1:n_channels,t-1))<0)
        v1 = -v1;
        end
        
        eigenvectors(:,t) = [v1];
    
    end
 
    % if verbose, plot matrix
    if(verbose)

        subplot(2,3,1);
        imagesc(iPL);
        title(sprintf('iPL matrix, lambda1 = %d',lambda1));
        
        subplot(2,3,2);
        imagesc(v1*v1');
        title('v1');

        if (num_eigen == 2)
            subplot(2,3,3);
            imagesc(v2*v2');
            title('v2');
            pause(0.1);

            subplot(2,3,6);
            imagesc(v1*v1'+v2*v2');
            title('reconstructed');
        
        else
            subplot(2,3,6);
            imagesc(v1*v1');
            title('reconstructed'); % Is is even worth plotting in this case? Because it's just the same as V1
        end

        subplot(2,3,4);
        imagesc(timeseries);
        add_labels(g_size, label_names, gca);
        title('Instantaneous Connectivity Matrix');

        subplot(2,3,5);
        visualise_time_course(timeseries, data_specific_info);
        xline(t, 'LineWidth', 2);
        hold off
        title('Signals Over Time');
    end

   end

% discard first and last timepoint as they are not meaningful 

eigenvectors = eigenvectors(:,2:end-1);
eigenvalues = eigenvalues(2:end-1);

end


