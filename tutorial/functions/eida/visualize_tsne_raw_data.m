function visualize_tsne_raw_data(timeseries)

timepoints = tsne(timeseries,'NumDimensions',3);
n = size(timepoints,1);

figure
for i=1:n
    plot3(timepoints(i,1),timepoints(i,2),timepoints(i,3),'.','color','red');
    xlim([-15 15]);
    ylim([-60 40]);
    zlim([-15 20]);
    xlabel('tsne1');
    ylabel('tsne2');
    zlabel('tsne3');
    grid on
    hold on 
    pause(0.2);
end

end
