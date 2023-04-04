function output = filter_datamatrix(timeseries,lowest_freq,highest_freq,n_channels,Ts)
%This function filters all the data in the data matrix according to the
%frequency limits

output = zeros(size(timeseries));
for i=1:n_channels
    output(:,i)=bandpass(timeseries(:,i),[lowest_freq highest_freq],1/Ts);
end

end

