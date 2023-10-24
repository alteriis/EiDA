function statistic_vectors = calculate_statistic_vectors(n_time_scans,n_subjects,statistic)
%CALCULATE_STATISTIC_VECTOR It creates 4 vectors, 1 for each time point,
%The vectors are ordered in order of subject. They are stacked in a matrix

statistic_vectors = zeros(n_subjects,n_time_scans);

for i=1:n_time_scans
    for j=1:n_subjects
        [token,data] = load_rat_matrix(i,j,0);
        if token
            statistic_vectors(j,i) = statistic(data);
        else
            statistic_vectors(j,i) = Inf;
        end
    end
    
end




