function [positions_1, positions_2, reconf_speeds_1, reconf_speeds_2] = continuous_eida(vectors)


n = size(vectors,2);
n_channels = size(vectors,1)/2;
reconf_speeds_1 = zeros(n-1,1);
positions_1 = zeros(n-1,1);
reconf_speeds_2 = zeros(n-1,1);
positions_2 = zeros(n-1,1);


for i = 2:n
    
    v1_i = vectors(1:n_channels,i);
    v2_i = vectors(n_channels+1:end,i);
    lambda_i = norm(v1_i)^2;
    
    v1_im1 = vectors(1:n_channels,i-1);
    v2_im1 = vectors(n_channels+1:end,i-1);
    
    reconf_speeds_1(i-1) = 1-abs(corr(v1_i,v1_im1));
    reconf_speeds_2(i-1) = 1-abs(corr(v2_i,v2_im1));
    positions_1(i-1) = lambda_i;
    positions_2(i-1) = n_channels - lambda_i;
end


end

