function out = reconf_slowness(leading_eigen)
%RECONF_SLOWNESS you give the leading eigs, it gives 
% you the avg correlation among neighbor eigens, ie the 
% slowness of reconfiguration process

correls = zeros(1,size(leading_eigen,2)-1);

for k = 1:size(leading_eigen,2)-1
    correls(k) = corr(leading_eigen(:,k),leading_eigen(:,k+1));
end

out = mean(correls);

end

