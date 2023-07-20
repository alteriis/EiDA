function plot_eigenvector(eig,first,rescale,singlefigure)

eig = eig/rescale; % i want a decent maximum of 1

if singlefigure
    f=figure;
end
h = stem(eig,'Marker','none','linewidth',4);
if(first)
    h.Color = [103 58 183]/255;
else
    h.Color = [67 160 71]/255;
end
ylim([-1 1]);
axis off
if singlefigure
    f.Position = [100 100 450 100];
end

end