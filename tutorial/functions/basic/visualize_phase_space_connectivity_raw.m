function visualize_phase_space_connectivity_raw(timeseries,video)

% i want timeseries where each columns is a time point. Each row a signal

n = size(timeseries,2);

timeseries = normalize(timeseries,2);
centroid = corrcoef(timeseries');
centroid = centroid/norm(centroid(:));

position = zeros(1,n);
momentum = zeros(1,n);


for i=2:n
    ist_matrix = timeseries(:,i)*timeseries(:,i)';
    position(i) = ist_matrix(:)'*centroid(:);
    ist_matrix_im1 = timeseries(:,i-1)*timeseries(:,i-1)';
%     momentum(i) = corr(ist_matrix(:),ist_matrix_im1(:));
    % other alternative
    momentum(i) = corr(timeseries(:,i),timeseries(:,i-1));
end

miny = min(momentum);
maxy = max(momentum);
minx = min(position);
maxx = max(position);


for i=1:n-1
    subplot(1,2,1)
    imagesc(timeseries(:,i)*timeseries(:,i)');
    subplot(1,2,2)
    plot(position(i),momentum(i),'.','color','red');
    xlim([minx maxx]);
    ylim([miny maxy]);
    xlabel('position');
    ylabel('moment');
    grid on
    hold on
    if video
        pause(0.15);
    end
end


end

