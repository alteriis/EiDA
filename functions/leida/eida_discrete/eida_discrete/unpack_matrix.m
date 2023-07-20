function matrix = unpack_matrix(m,dim)

matrix = ones(dim,dim);
ind = 1;
for column=2:dim
    for row=1:column-1
        matrix(row,column) = m(ind);
        matrix(column,row) = m(ind);
        ind = ind+1;
    end
end

end

