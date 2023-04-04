function leading_eigenvectors = compute_leading_eigen_anal(timeseries,n_channels,n,verbose)
% computes leading eigs analytically!

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
    
    eig1 = c + B1*s;
    eig2 = c + B2*s;
    eig1 = eig1/(eig1'*eig1); % normalize 
    eig2 = eig2/(eig2'*eig2);
    
    % find the one with biggest eig
    
    lambda1 = mean((P*eig1)./eig1);
    lambda2 = mean((P*eig2)./eig2);
    
    if(lambda1 > lambda2)
          v1 = eig1;
          lambda = lambda1;
    else
          v1 = eig2;
          lambda = lambda2;
    end
    
    if t>1 && (corr(v1,leading_eigenvectors(:,t-1))<0)
        v1 = -v1;
    end
    
    leading_eigenvectors(:,t) = v1*sqrt(lambda);
    
    if(verbose)
        imagesc(P);
        pause(0.15)
    end

end

leading_eigenvectors = leading_eigenvectors(:,2:end-1);

end

