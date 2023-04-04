function infomatrix = m_info_matrix(data,k)
%M_INFO_MATRIX this function takes as input the data (whatever
%data, we just need that it is arranged in columns, so each column is a
%time signal. It calculates a matrix which is the mutual information
%between signals. It calculates onlhy the upper triangular part

% what is k? It is the clustering parameter for calculating mutual
% information (see documentation about mi_cont_cont
% NOTE it requires to download the package in "downloaded minfo"

addpath('./downloaded_minfo');

n_signals = size(data,2);
infomatrix = zeros(n_signals,n_signals);

for i=1:n_signals
    for j=i:n_signals
        infomatrix(i,j) = mi_cont_cont(data(:,i),data(:,j),k);
    end
end

end
