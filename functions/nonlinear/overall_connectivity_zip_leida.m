function ov_conn_zip = overall_connectivity_zip_leida(data)
%calculate binarized connectivity matrices over time and calculate zip
%complexity index on them 

n_channels = size(data,2);
n = size(data,1);

patterns = compute_leida_matrices_vectorized(data,n_channels,n,0);
patterns = patterns(:);
save('patterns.mat','patterns');
gzip('patterns.mat');
s = dir('patterns.mat.gz');
filesize = s.bytes;
delete patterns.mat
delete patterns.mat.gz
ov_conn_zip = filesize;

end


