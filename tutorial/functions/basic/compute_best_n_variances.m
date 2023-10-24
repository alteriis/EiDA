function output = compute_best_n_variances(data,n)

variances = [];

for i = 1:size(data,1)
    for j = 1:size(data,2)
        for k = 1:size(data,3)
            variances = [variances var(data(i,j,k,:))];
        end
    end
end

variances = sort(variances,'descend');
output = variances(1:n);

end

