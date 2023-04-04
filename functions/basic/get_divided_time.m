function times = get_divided_time(N)

if N<48
    times = 0;
    return 
end

% first find how many partitions we are doing

lengths = zeros(1,15);
for i=1:15
    lengths(i) = 3*(2^(i-1));  
end

n_partitions=0;
while floor(N/lengths(n_partitions+1))>=2
    n_partitions=n_partitions+1;
end

% sto indexando male in futuro il suo primo elemento deve essere il totale!
lengths = flip(lengths(1:n_partitions)); % i will work in decreasing order

% now we create our cell array with all the partitions. The first is the
% trivial partition

times = cell(1,n_partitions+1);
times{1} = 1:N;

% the second one is that I have them centered. So i should take half of the
% rest on the left and half on the right

rest = N-(floor(N/lengths(1))*lengths(1)); % i calculate how many time points are "missing" 
first_blanks = round(rest/2);

matrix = zeros(floor(N/lengths(1)),lengths(1));
for i=1:floor(N/lengths(1))
    matrix(i,:) = first_blanks+lengths(1)*(i-1)+1:first_blanks+lengths(1)*i;
end

times{2} = matrix;

for i=2:n_partitions
    
    matrix = [];
    first = times{i}(1,1)+floor(lengths(i)/2); % qua ce un problema nell'indexing perche fatto male. I use floor because the last element is odd, is 3, and I wandthe first to be just the one ahead
    if(first-lengths(i) >= 0)
        first = first-lengths(i);
    end
    
    j=1;
    while first+lengths(i)*j <= N
        matrix(j,:) = first+lengths(i)*(j-1)+1:first+lengths(i)*j;
        j = j+1;
    end
    
    times{i+1} = matrix;
end




end