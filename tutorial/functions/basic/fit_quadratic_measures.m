function [f,gof] = fit_quadratic_measures(A,B,toplot)
%CORRELATE_MEASURES this fcn takes 2 matrices and correlates measures


indx = ~ (A == Inf | B == Inf | isnan(A) | isnan(B));
[f,gof] = fit(A(indx),B(indx),'poly2');
if toplot
    plot(A(indx),B(indx),'.','color','black');
    hold on
    plot(f);  
end


end

   
