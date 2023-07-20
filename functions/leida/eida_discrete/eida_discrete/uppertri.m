function culo = uppertri(matrix)

culo = triu(matrix,1);
culo = culo(:);
culo = culo(culo~=0);

end

