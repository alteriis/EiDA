function dist = eida_distance_centroid_eigen(centroid,v) % BE CAREFUL TO DIMENSIONS!!!!

% This function rebuilds the full matrix from the stacked eigenvectors and
% compute the distance as the cosine distance between the rebuilt upper
% triangular matrices 



dimensionality = numel(v)/2;

matrix = v(1:dimensionality)*v(1:dimensionality)'+v(dimensionality+1:end)*v(dimensionality+1:end)';

vectorized = uppertri(matrix);
dist = pdist([centroid';vectorized'],'cosine');

end