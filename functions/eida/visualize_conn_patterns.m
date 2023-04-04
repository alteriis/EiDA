function visualize_conn_patterns(timeseries, half_window_size)

n = size(timeseries,1);
correlations = zeros(size(timeseries,1),size(timeseries,2));

for i=1:n
    lower_bound = max(1,i-half_window_size);
    upper_bound = min(i+half_window_size,n);
    corr = corrcoef(timeseries(lower_bound:upper_bound,:));
    [v,~] = eigs(corr,1);
    correlations(i,:) = v;
end

toplot = tsne(correlations,'NumDimensions',3);

minx = min(toplot(:,1));
maxx = max(toplot(:,1));
miny = min(toplot(:,2));
maxy = max(toplot(:,2));
minz = min(toplot(:,3));
maxz = max(toplot(:,3));

for i=1:n
    subplot(1,2,1)
    imagesc(correlations(i,:)'*correlations(i,:));
    pause(0.15);
    subplot(1,2,2)
    plot3(toplot(i,1),toplot(i,2),toplot(i,3),'.','color','red');
    xlim([minx maxx]);
    ylim([miny maxy]);
    zlim([minz maxz]);
    xlabel('tsne1');
    ylabel('tsne2');
    zlabel('tsne3');
    grid on
    hold on
end
end
