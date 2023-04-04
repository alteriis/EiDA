function visualize_all_vectors(timeseries,n_channels,n,Ts)

% this is not to compute things is just to visualize. Therefore 
% I work here

lowest_freq = 0.01;
highest_freq = 0.08;

timeseries = filter_datamatrix(timeseries,lowest_freq,highest_freq,n_channels,Ts);


for i=1:n_channels
    %ts=detrend(signal(seed,:)-mean(signal(seed,:))); ???????!!!
    timeseries(:,i) = angle(hilbert(timeseries(:,i)));
end

leading_eigenvectors = zeros(n_channels,n);


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
    eig1 = eig1/sqrt((eig1'*eig1)); % normalize 
    eig2 = eig2/sqrt((eig2'*eig2));
    
    % find the one with biggest eig
    
    lambda1 = gamma+B1*xi;
    lambda2 = gamma+B2*xi;
    
   % make eigens such that they recreate matrix
   
   eig1 = eig1*sqrt(lambda1);
   eig2 = eig2*sqrt(lambda2);
   
   if(lambda2>lambda1)
       tmp = eig2;
       eig2 = eig1;
       eig1 = tmp;
   end
   
   subplot(2,3,1)
   imagesc(P);
   title('Hilbert Matrix');
   subplot(2,3,4)
   imagesc(eig1*eig1'+eig2*eig2');
   title('REconstructed with Eigs (should be perfect!)');
   subplot(2,3,2)
   imagesc(c*c');
   title('Cosine Vector');
   subplot(2,3,5)
   imagesc(s*s');
   title('Sine Vector');
   subplot(2,3,3)
   imagesc(eig1*eig1');
   title('Biggest Eig');
   subplot(2,3,6)
   imagesc(P);
   title('Smallest Eig');

   pause(2)

end


end


