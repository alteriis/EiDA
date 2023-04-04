% you just need the timeseries organized in matrices (.mat). This script
% will compute the time evolution of the two eigenvectors and store it in a
% destination folder with same names and '_eida' at the end
% Data should be organized in matlab matrices, each row is a timepoint, each column is a different signal (e.g. channel,region,...)

clear 
addpath('../../functions/eida');
addpath('../../functions/basic');

% please specify source folder and destionation folder
source_folder = '../../data/us_economy'; 
destination_folder = '../../data/us_economy_eigenvectors';

% please specify passband requirements and sampling time 
Ts = 1;
lowest_freq = 0.01;
highest_freq = 0.15;

%%

elements_in_dir = dir(source_folder); % this is such that user just needs to put data in the folder

for i=1:numel(elements_in_dir)
    if numel(elements_in_dir(i).name)>3 && strcmp(elements_in_dir(i).name(end-2:end),'mat') % verify if it's the correct data ending in .mat
        timeseries = struct2cell(load([source_folder '/' elements_in_dir(i).name]));
        timeseries = timeseries{1};
        timeseries = bandpass(timeseries,[lowest_freq highest_freq],1/Ts); % filter timeseries
        [eigenvectors,~] = compute_eigen_timeseries(timeseries,1);
        % save_eigenvector evolution in the destination folder
        save([destination_folder '/' elements_in_dir(i).name(1:end-4) '_eigenvectors'],'eigenvectors');
    end

end

