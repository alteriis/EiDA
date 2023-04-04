function eff_conn = calculate_norm_connectivity(data)
%CALCULATE_AVG_CONNECTIVITY this function takes as input the data (whatever
%data, we just need that it is arranged in columns, so each column is a
%time signal. It calculates the frobenius norm of connectivity matrix, but
%we can change if necessary

R = corrcoef(data);
eff_conn = norm(R,'fro');

end

