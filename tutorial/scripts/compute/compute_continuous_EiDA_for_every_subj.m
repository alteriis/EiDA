%%

clear 
addpath('../../functions/eida');
addpath('../../functions/basic');


% please specify source folder and destionation folder
source_folder = '../../data/example_fmri_eigenvectors'; 
destination_folder = '../../data/example_fmri_continuous_eida';

%% compute the quantities of interest, position and reconfiguration speed, for the 2 eigenvectors (fig 6 of the paper)
% note that the 1st eigenvalue (position) can also be an output of the
% compute eigen timeseries function. Remember that if you want the 2nd
% eigenvalue, that's just N-1st eigenvalue, where N is number of channels,
% for the iPL matrix. 

elements_in_dir = dir(source_folder);

for i=1:numel(elements_in_dir)
    if numel(elements_in_dir(i).name)>3 && strcmp(elements_in_dir(i).name(end-2:end),'mat')
        eigenvectors = struct2cell(load([source_folder '/' elements_in_dir(i).name]));
        eigenvectors = eigenvectors{1};
        [p1,p2,s1,s2] = continuous_eida(eigenvectors);
        % save_eigenvector evolution in the destination folder
        save([destination_folder '/' elements_in_dir(i).name(1:end-4) '_continuous_eida'],'p1','p2','s1','s2');
    end
end












