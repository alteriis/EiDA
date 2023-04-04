function averaged_matrices = compute_averaged_matrices(n_time_scans,n_subjects,who,verbose)
%COMPUTE_AVERAGED_MATRICES gives me a cell with 4 matrices. If we input
%'all', Each matrix will be
% the average of all the data from all the rats, regardless of everything.
% verbose commands if I want to display if unable to colelct data 

if (strcmp(who,'all'))
    averaged_matrices = cell(1,n_time_scans);
    for i=1:n_time_scans
        [~,data] = load_rat_matrix(i,1,verbose);
        averaged_matrices{i} = data;
        divider = 1;
        for j=2:n_subjects
            [token,data] = load_rat_matrix(i,j,verbose);
            if token
                averaged_matrices{i} = averaged_matrices{i} + data;
                divider = divider+1;
            end
        end
        averaged_matrices{i} = averaged_matrices{i}/divider;
    end
else
    averaged_matrices = 0;
end
end

