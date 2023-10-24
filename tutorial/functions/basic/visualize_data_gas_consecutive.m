function visualize_data_gas_consecutive(timeseries,timestart,ntimes)

% RICORDA QUANDO FARAI IL CODICE SU TUTTE LE
% MATRICI DI FILTRARE I DATI PASSA BANDA

div = 5;

n = size(timeseries,2);


speeds = timeseries(:,2:end)-timeseries(:,1:end-1);
positions = timeseries(:,2:end);

% polar coordinates
rhos = sqrt(positions.^2+speeds.^2);
phis = atan2(speeds,positions);

ellipsoidness = zeros(1,n-1);
for i = 1:n-1
    ellipsoidness(i) = abs(corr(positions(:,i),speeds(:,i)));
end

miny = mean(min(speeds,[],1));
maxy = mean(max(speeds,[],1));
minx = mean(min(positions,[],1));
maxx = mean(max(positions,[],1));

stepx = maxx-minx;
stepy = maxy-miny;

ellipsoidness = rescale(ellipsoidness,-stepy*ntimes/div+stepy, -stepy*ntimes/div+2*stepy);

for i=timestart:ntimes+timestart
    
    plot(i*stepx+positions(:,i),speeds(:,i),'.','color','red');
    hold on
end

% plot(stepx*(timestart:timestart+ntimes),ellipsoidness(timestart:timestart+ntimes));

xlim([timestart*stepx timestart*stepx+ntimes*stepx]);
ylim([-stepy*ntimes/div stepy*ntimes/div]);

end


