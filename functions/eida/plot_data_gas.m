function plot_data_gas(timeseries,Ts,leading_eigen, centroid)

% interrogarsi se la dimensionalità (primo e ultimo elem) han senso!

timeseries = timeseries(2:end-1,:);
n = size(timeseries,1);
n_channels = size(timeseries,2);

velocities = timeseries(2:end,:)-timeseries(1:end-1,:);
positions = timeseries(2:end,:);

minx1 = min(min(positions));
maxx1 = max(max(positions));
miny1 = min(min(velocities));
maxy1 = max(max(velocities));

reconf_speeds = zeros(n-1,1);
for i = 2:n
    c = corrcoef(leading_eigen(:,i),leading_eigen(:,i-1));
    reconf_speeds(i-1) = c(2,1);
end

masses = sum(abs(leading_eigen),1);
masses = masses(2:end);
moment = reconf_speeds'.*masses;

position = (centroid)*(leading_eigen);
position = position(2:end);
position = position';
moment = moment';


miny2 = min(moment);
maxy2 = max(moment);
minx2 = min(position);
maxx2 = max(position);
miny3 = min(reconf_speeds);
maxy3 = max(reconf_speeds);

colors = hsv(44);

figure('units','normalized','outerposition',[0 0 1 1]);
subplot(2,3,[1 4])
for j=1:n_channels
    plot((2:n)*Ts,timeseries(2:end,j)+(j-1)*ones(n-1,1),'linewidth',1,'color',colors(j,:))
    yticks('');
    xlabel('Time(s)')
    ylabel('Channel')
    hold on
end
hold off

xlabel('time');
ylabel('signal');


for i=1:n-1
    subplot(2,3,5)
    hold off
    for j = 1:n_channels
        plot(positions(i,j),velocities(i,j),'.','color',colors(j,:));
        hold on
        xlim([minx1 maxx1]);
        ylim([miny1 maxy1]);
        grid on
    end
    
    xlabel('position');
    ylabel('velocity');
    subplot(2,3,[1 4])
    xline(i*Ts);
    
    subplot(2,3,2)
    plot(position(i),moment(i),'.','color','red');
    xlim([minx2 maxx2]);
    ylim([miny2 maxy2]);
    xlabel('position hilbert');
    ylabel('moment hilbert ');
    grid on
    hold on
    
    % istantantous conn matrix with window of 3
    
    lower_bound = max(i-1,1);
    upper_bound = min(i+1,n-1);
    corr = corrcoef(timeseries(lower_bound:upper_bound,:));
    subplot(2,3,3)
    imagesc(corr);
    title('intelligent istantaneous correlation');
    
    subplot(2,3,6)
    imagesc(leading_eigen(:,i)*leading_eigen(:,i)');
    
    pause(0.1)
    
end


end