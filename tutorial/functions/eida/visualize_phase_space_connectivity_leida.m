function [position, moment] = visualize_phase_space_connectivity_leida(leading_eigen, centroid,video,interactive,toplot)

% RICORDA QUANDO FARAI IL CODICE SU TUTTE LE
% MATRICI DI FILTRARE I DATI PASSA BANDA


n = size(leading_eigen,2);

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

if toplot
    % we try massa = amplitude dei vettori di corr...vediamo che succede..poi
    % si cambia. Velocità = reconf speeds
    
    miny = min(moment);
    maxy = max(moment);
    minx = min(position);
    maxx = max(position);
    
    
    for i=1:n-1
        subplot(1,2,1)
        imagesc(leading_eigen(:,i)*leading_eigen(:,i)');
        subplot(1,2,2)
        plot(position(i),moment(i),'.','color','red');
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
    if(interactive)
        while 1
            subplot(1,2,2)
            [x,y] = ginput;
            distances = zeros(1,n-1);
            for i=1:n-1
                distances(i) = norm([x,y]-[position(i),moment(i)]);
            end
            index = find(distances == min(distances));
            subplot(1,2,1)
            imagesc(leading_eigen(:,index)*leading_eigen(:,index)');
            subplot(1,2,2)
            hold off
            plot(position,moment,'.','color','red');
            hold on
            plot(position,moment,'color','red','linewidth',0.25);
            hold on
            plot(position(index),moment(index),'*','color','blue','linewidth',2);
            xlim([minx maxx]);
            ylim([miny maxy]);
        end
    else
        subplot(1,2,2)
        distances = zeros(1,n-1);
        subplot(1,2,1)
        imagesc(centroid'*centroid);
        title('Phase Locking centroid');
        subplot(1,2,2)
        hold off
        plot(position,moment,'.','color','blue','linewidth',1.5);
        hold on
        plot(position,moment,'color','red','linewidth',0.25);
        xlim([minx maxx]);
        ylim([miny maxy]);
        title('Phase space Pattern');
        xlabel('Position');
        ylabel('Momentum');
    end
end
end

