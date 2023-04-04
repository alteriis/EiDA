function [out,sign]= correlate_measures(A,B,toplot)
%CORRELATE_MEASURES this fcn takes 2 matrices and correlates measures


indx = ~ (A == Inf | B == Inf | isnan(A) | isnan(B));
if toplot
    plot(A(indx),B(indx),'.','color','black');
    hold on
    f = fit(A(indx),B(indx),'poly1');
    plot(f);
    
end

out = corr(A(indx),B(indx));
a = A(indx);
b = B(indx);

% shuffling to see significance of correlation 
surrogate_corrs = zeros(1,10000);

for i=1:1000
    a = a(randperm(numel(a)));
    b = b(randperm(numel(b)));
    surrogate_corrs = corr(a,b);
end

threshold = prctile(surrogate_corrs,99.9);
sign = abs(out) > threshold;



end

   
