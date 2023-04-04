%%

clear 
addpath('../../functions/eida');
addpath('../../functions/basic');


% please specify source folder and destionation folder
source_folder = '../../data/us_economy_eida'; 
destination_folder = '../../data/us_economy_continuous_eida';

%% PROVA A FARLO ANCHE QUI E NEGLI STEP PRECEDENTI CON LIST NAME!

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












