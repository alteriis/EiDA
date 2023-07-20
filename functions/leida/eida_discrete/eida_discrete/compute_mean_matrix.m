function output = compute_mean_matrix(matrices)

n = size(matrices,1);
dimensionality = size(matrices,2)/2;


avg_matrix = zeros(dimensionality,dimensionality); %i could take upprtri to make faster...

for i = 1:n
    v1 = matrices(i,1:dimensionality)';
    v2 = matrices(i,dimensionality+1:end)';
    reconstructed_matrix = v1*v1'+v2*v2';
    avg_matrix = avg_matrix + reconstructed_matrix;
end

output = uppertri(avg_matrix./n);

end

