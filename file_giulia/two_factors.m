function [f1,f2] = two_factors(num)

v = factor(num);

while length(v) > 2
    if mod(length(v), 2) == 0
        v = v(1:2:end) .* v(2:2:end);
    else if length(v) == 3
            v = [v(1)*v(2) v(3)];
    else
        v = [v(1) v(3:2:end) .* v(2:2:end)];
    end

    end

end

 f1 = v(1);
 f2 = v(2);
end



