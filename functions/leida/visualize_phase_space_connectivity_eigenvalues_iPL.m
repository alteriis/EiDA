function [positions, reconf_speeds] = visualize_phase_space_connectivity_eigenvalues_iPL(vectors)




n = size(vectors,2);
n_channels = size(vectors,1)/2;
reconf_speeds = zeros(n-1,1);
positions = zeros(n-1,1);



for i = 2:n
    
    v1_i = vectors(1:n_channels,i);
    v2_i = vectors(n_channels+1:end,i);
    lambda_i = norm(v1_i)^2;
    
    v1_im1 = vectors(1:n_channels,i-1);
    v2_im1 = vectors(n_channels+1:end,i-1);

    iPL_i = v1_i*v1_i' + v2_i*v2_i'; % rebuild the iPL matrix with eigens at time t
    iPL_im1 = v1_im1*v1_im1' + v2_im1*v2_im1'; % same at time t minus 1
    
    reconf_speeds(i-1) = 1-abs(corr(uppertri(iPL_i),uppertri(iPL_im1)));
    positions(i-1) = lambda_i;

end

% I put no plot here!

end



function culo = uppertri(matrix)

culo = triu(matrix,1);
culo = culo(:);
culo = culo(culo~=0);

end