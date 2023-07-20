function average_ipl = compute_average_ipl_matrix(vectors)


n = size(vectors,2);
n_channels = size(vectors,1)/2;

average_ipl = zeros(n_channels,n_channels);

for i=1:n
c = vectors(1:n_channels,i);
s = vectors(n_channels+1:end,i);
average_ipl = average_ipl + c*c' + s*s';
end

average_ipl = average_ipl/n;

end