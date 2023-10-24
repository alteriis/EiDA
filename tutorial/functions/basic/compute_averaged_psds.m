function [averaged_psds,fshift] = compute_averaged_psds(n_time_scans,n_subjects,fs,n,who,verbose)
%COMPUTE_AVERAGED_MATRICES gives me a cell with 4 matrices. If we input
%'all', Each matrix will be
% the average of all the data from all the rats, regardless of everything.
% Verbose if is 1 we say what data were unable to upload

if (strcmp(who,'all'))
    averaged_psds = cell(1,n_time_scans);
    for i=1:n_time_scans
        [~,data] = load_rat_matrix(i,1,verbose);
        averaged_psds{i} = powershifted(data,n);
        divider = 1;
        for j=2:n_subjects
            [token,data] = load_rat_matrix(i,j,verbose);
            if token
                averaged_psds{i} = averaged_psds{i} + powershifted(data,n);
                divider = divider+1;
            end
        end
        averaged_psds{i} = averaged_psds{i}/divider;
        averaged_psds{i} = mean(averaged_psds{i},2);
    end
    fshift = (-n/2:n/2-1)*(fs/n); % zero-centered frequency range
else
    averaged_psds = 0;
    fshift = 0;
end
end

