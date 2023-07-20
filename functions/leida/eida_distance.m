function dist = eida_distance(v1,v2)

% This function rebuilds the full matrix from the stacked eigenvectors and
% compute the distance as the cosine distance between the rebuilt upper
% triangular matrices 

dimensionality = numel(v1)/2;

matrix1 = v1(1:dimensionality)*v1(1:dimensionality)'+v1(dimensionality+1:end)*v1(dimensionality+1:end)';
matrix2 = v2(1:dimensionality)*v2(1:dimensionality)'+v2(dimensionality+1:end)*v2(dimensionality+1:end)';

dist = pdist([matrix1(:)';matrix2(:)'],'cosine');

end