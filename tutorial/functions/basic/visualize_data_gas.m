function [positions,speeds,ellipsoidness] = visualize_data_gas(timeseries,toplot,video)

% RICORDA QUANDO FARAI IL CODICE SU TUTTE LE
% MATRICI DI FILTRARE I DATI PASSA BANDA

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

% we try massa = amplitude dei vettori di corr...vediamo che succede..poi
% si cambia. Velocità = reconf speeds

if(toplot)
    
    miny = min(min(speeds));
    maxy = max(max(speeds));
    minx = min(min(positions));
    maxx = max(max(positions));
    
    maxr = max(max(rhos));
    col = summer(n);
    col2 = winter(n);
    
    
    for i=1:n-1
        subplot(3,2,[1 3])
        % plot in polar coordinates
        
        plot(rhos(:,i),phis(:,i),'.','color',col2(i,:));
        xlim([0 maxr]);
        ylim([-pi pi]);
        
        grid on
        hold on
        if video
            pause(0.15);
            hold off
        end
        
        subplot(3,2,[2 4])
        
        plot(positions(:,i),speeds(:,i),'.','color',col(i,:));
        xlim([minx maxx]);
        ylim([miny maxy]);
        xlabel('position');
        ylabel('momentum');
        grid on
        hold on
        if video
            pause(0.15);
            hold off
        end
        
    end
    
    subplot(3,2,[5 6]);
    plot(ellipsoidness);
    title(mean(ellipsoidness));
    
end
end

