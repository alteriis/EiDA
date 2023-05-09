function [f1,f2] = two_factors(num)

% This function is used to creata a number of plots decided by the user and
% divides the screen in a balanced manner.
% It takes advantage of the function isprime and then
% multiplies the prime factors amongst themselves until only two are left

% considers the base case where the number requested is 1
if num == 1
    f1 = 1;
    f2 = 1;
    return 
end

% considers the base case where the number requested is 2
if num == 2
    f1 = 1;
    f2 = 2;
    return 
end

% considers the case where the number is prime, the division may not be
% efficient e.g. 17 = 1 * 17so we add one to make the number even and then 
% feed it to the function --> 17+1 = 18 = 3 * 6 (more balanced)
if isprime(num) == 1
    num = num+1;
end

v = factor(num); 

% if the number only has two factors (apart from itself and one) then the
% function is done and we assign the numbers
if length(v) == 2
    f1 = v(1);
    f2 = v(2);

else
% otherwise we multiply the prime factors amongst themselves until we get
% to just two

    while length(v) > 2
        if mod(length(v), 2) == 0
            v = v(1:2:end) .* v(2:2:end);
        else if length(v) == 3
        % here we're accounting for the fact that our number has an odd
        % number of prime factors, we multiply the first two numbers by
        % each other as the numbers are sorted in ascending order and this
        % should give us a more balanced grid 
                v = [v(1)*v(2) v(3)];
        else
            v = [v(1) v(3:2:end) .* v(2:2:end)];
        end

        end

    end

    f1 = v(1);
    f2 = v(2);
end
end




