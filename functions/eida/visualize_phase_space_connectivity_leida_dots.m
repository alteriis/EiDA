function visualize_phase_space_connectivity_leida_dots(leading_eigen,video)

% RICORDA QUANDO FARAI IL CODICE SU TUTTE LE
% MATRICI DI FILTRARE I DATI PASSA BANDA

n = size(leading_eigen,2);

speeds = abs(leading_eigen(:,2:end)-leading_eigen(:,1:end-1));
positions = abs(leading_eigen(:,2:end));

% we try massa = amplitude dei vettori di corr...vediamo che succede..poi
% si cambia. Velocità = reconf speeds

miny = min(min(speeds));
maxy = max(max(speeds));
minx = min(min(positions));
maxx = max(max(positions));


for i=1:n-1
    subplot(1,2,1)
    imagesc(leading_eigen(:,i)*leading_eigen(:,i)');
    subplot(1,2,2)
    plot(positions(:,i),speeds(:,i),'.','color','red');
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


end

