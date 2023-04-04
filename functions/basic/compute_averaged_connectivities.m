function averaged_connectivities = compute_averaged_connectivities(n_time_scans,n_subjects,who,verbose,measure);
%COMPUTE_AVERAGED_MATRICES gives me a cell with 4 matrices. If we input
%'all', Each matrix will be
% the average of all the data from all the rats, regardless of everything.
% verbose commands if I want to display if unable to colelct data 

% i'll do a lot of ifs because each case has different things, for example
% whe have pearson, minfo with k = 3, but we could have minfo with
% different k. K is a parameter for minfo, see details in the code that
% computes mutual information

if (strcmp(who,'all'))
    averaged_connectivities = cell(1,n_time_scans);
    for i=1:n_time_scans
        [~,data] = load_rat_matrix(i,1,verbose);
        averaged_connectivities{i} = compute_connectivities(data,measure);
        divider = 1;
        for j=2:n_subjects
            [token,data] = load_rat_matrix(i,j,verbose);
            if token
                averaged_connectivities{i} = averaged_connectivities{i} + compute_connectivities(data,measure);
                divider = divider+1;
            end
        end
        averaged_connectivities{i} = averaged_connectivities{i}/divider;
    end
    
    
    
else
    averaged_connectivities = 0;
end
end




