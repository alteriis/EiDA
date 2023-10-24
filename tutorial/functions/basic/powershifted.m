function powershift = powershifted(matrix,n)
%POWERSHIFTED power spectrum shifted

X = fft(matrix,[],1);
Y = fftshift(X,1);
powershift = abs(Y).^2/n;     % zero-centered power

end

