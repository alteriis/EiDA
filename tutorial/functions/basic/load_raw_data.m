function [token,data] = load_rat_matrix(age,subj,verbose)

%LOAD_RAT_MATRIX this function has in input the time point of the analysis
%(1 to4) 
%and the subject number (1 to 48). It loads the raw data

if (subj<10)
    filename = sprintf('/data/project/brain/RESILIENT/AGEING/T%d/derived/A0%d/rs/sub-A0%d_ses-T%d_desc-warpedtoRESILIENT_bold.nii.gz',age,subj,subj,age);
else
    filename = sprintf('/data/project/brain/RESILIENT/AGEING/T%d/derived/A%d/rs/sub-A%d_ses-T%d_desc-warpedtoRESILIENT_bold.nii.gz',age,subj,subj,age);
end


if exist(filename)
    data = niftiread(filename);
    token = 1;
else
    data = [];
    token =0;
    if verbose fprintf('Data unavailable: rat %d, T%d\n',subj,age); end
end


end


