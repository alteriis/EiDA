function [token,data] = load_rat_matrix(age,subj,verbose)

%LOAD_RAT_MATRIX this function has in input the time point of the analysis
%(1 to4) 
%and the subject number (1 to 48). It loads the parcellated data in a
%matrix where each column is a signal

% NOTE: this could have been done in a more elegant way by saying 
%msg = 'Error occurred.';
%error(msg)

if (subj<10)
    foldername = sprintf('/data/project/brain/RESILIENT/AGEING/T%d/derived/A0%d/rs',age,subj);
    filename = sprintf('sub-A0%d_ses-T%d_atlas-VHandWHSfunctionalv2_desc-bilateral_timecourses.txt',subj,age);
else
    foldername = sprintf('/data/project/brain/RESILIENT/AGEING/T%d/derived/A%d/rs',age,subj);
    filename = sprintf('sub-A%d_ses-T%d_atlas-VHandWHSfunctionalv2_desc-bilateral_timecourses.txt',subj,age);
end

if isfolder(foldername) 
    addpath(foldername);
    if exist(filename)
        data = dlmread(filename);
        token = 1;
    else
        data = [];
        token =0;
        if verbose fprintf('Data unavailable: rat %d, T%d\n',subj,age); end
    end
else
    data = [];
    token =0;
    if verbose fprintf('Data unavailable: rat %d, T%d\n',subj,age); end
end

end

