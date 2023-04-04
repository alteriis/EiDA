function metrics = compute_metrics_array(signal)

% this function computes a battery of metrics from the original signals
% puts them into an array

% BASIC
n_features = 20;
metrics = zeros(1,n_features);
% median of signal (it should be 0 mean
metrics(1) = median(signal);
% autocorrelation fcn
[acf,~] = autocorr(signal); % i compute autocorrel function
metrics(2:10) = acf(2:10); % i put vallues from lag 1 to 9
% momenta 2 3 4
metrics(11) = var(signal); % variance should be equal to rms signals are 0 mean
metrics(12) = skewness(signal);
metrics(13) = kurtosis(signal);
% metrics on derivative of signal
delta = signal(2:end)-signal(1:end-1);
metrics(14) = median(delta); % median difference
metrics(15) = mean(abs(delta)); % mean abs difference 
%information theory
metrics(16) = entropy(signal); % entropy
% zero crossing & peaks
metrics(17) = sum(abs(signal)<0.3*var(signal)); % proxy for zero crossing: how much time it stays within 0.1 var signal
metrics(18) = numel(findpeaks(signal)); % number of POSITive peaks
metrics(19) = numel(findpeaks(-signal)); % number of NEGATIVE peaks

% STATISTICAL
metrics(20) = iqr(signal); % inter quantile range: Q3-Q1
metrics(21) = mad(signal); % median abs deviation
% empirical cum.distribution shape. 10 samples
[~,cdf] = ecdf(signal);
step = round(numel(cdf)/10);
approx_cdf = zeros(1,10);
for i=1:10 
    approx_cdf(i) = cdf(step*i);
end
metrics(22:31) = approx_cdf;

% SPECTRAL
spectrum = abs(fft(signal));
len = numel(spectrum);
spectrum = spectrum(1:round(len/2));
metrics(32) = mean(spectrum);
% i divide fft in 10 bins 
step = floor(numel(spectrum)/10);
binned_spectrum = zeros(1,10);
s = sum(spectrum);
for i=1:10 
    binned_spectrum(i) = sum(spectrum((i-1)*step+1:step*i))/s;
end
metrics(33:42) = binned_spectrum;

end