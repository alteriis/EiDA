function ov_conn_zip = overall_connectivity_zip(data)
%calculate binarized connectivity matrices over time and calculate zip
%complexity index on them 

n_channels = size(data,2);
n = size(data,1);

patterns = compute_binarized_vectors_pearson(data,n_channels,n,8,0.65,0);
patterns = patterns(:);
save('patterns.mat','patterns');
gzip('patterns.mat');
s = dir('patterns.mat.gz');
filesize = s.bytes;
delete patterns.mat
delete patterns.mat.gz
ov_conn_zip = filesize;

end


