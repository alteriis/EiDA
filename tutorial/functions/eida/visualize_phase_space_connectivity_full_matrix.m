function [positions, momentum] = visualize_phase_space_connectivity_full_matrix(vectors,video,interactive,toplot)

% RICORDA QUANDO FARAI IL CODICE SU TUTTE LE
% MATRICI DI FILTRARE I DATI PASSA BANDA


n = size(vectors,2);
n_channels = size(vectors,1)/2;
reconf_speeds = zeros(n-1,1);
positions = zeros(n-1,1);

%compute centroid (do i wanna threshold?)
centroid = zeros(n_channels,n_channels);
for i=1:n
c = vectors(1:n_channels,i);
s = vectors(n_channels+1:end,i);
% i will put median filter to denoise...let's see
centroid = centroid + wiener2(c*c'+s*s');
end

centroid = centroid/n;
%normalize
centroid = centroid/norm(centroid(:));
% calculate reconf speeds

for i = 2:n
    c = vectors(1:n_channels,i);
    s = vectors(n_channels+1:end,i);
    pc_i = wiener2(c*c'+s*s');
    
    c = vectors(1:n_channels,i-1);
    s = vectors(n_channels+1:end,i-1);
    pc_im1= wiener2(c*c'+s*s');
    
    reconf_speeds(i-1) = corr(pc_i(:),pc_im1(:));
end

momentum = reconf_speeds; % in future we can change!

% i could compute masse sto do momentum but I
% don't at the moment!

%calculate position

for i = 2:n
    c = vectors(1:n_channels,i);
    s = vectors(n_channels+1:end,i);
    pc_i = wiener2(c*c'+s*s');   
    positions(i-1) = pc_i(:)'*centroid(:);
end

if toplot
    % we try massa = amplitude dei vettori di corr...vediamo che succede..poi
    % si cambia. Velocità = reconf speeds
    
    miny = min(momentum);
    maxy = max(momentum);
    minx = min(positions);
    maxx = max(positions);
    
    
    for i=1:n-1
        subplot(1,2,1)
        imagesc(wiener2(vectors(1:n_channels,i)*vectors(1:n_channels,i)'+vectors(n_channels+1:end,i)*vectors(n_channels+1:end,i)'));
        subplot(1,2,2)
        plot(positions(i),momentum(i),'.','color','red');
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
                distances(i) = norm([x,y]-[positions(i),momentum(i)]);
            end
            index = find(distances == min(distances));
            subplot(1,2,1)
            imagesc(wiener2(vectors(1:n_channels,index)*vectors(1:n_channels,index)'+vectors(n_channels+1:end,index)*vectors(n_channels+1:end,index)'));
            subplot(1,2,2)
            hold off
            plot(positions,momentum,'.','color','red');
            hold on
            plot(positions,momentum,'color','red','linewidth',0.25);
            hold on
            plot(positions(index),momentum(index),'*','color','blue','linewidth',2);
            xlim([minx maxx]);
            ylim([miny maxy]);
        end
    else
        subplot(1,2,2)
        distances = zeros(1,n-1);
        subplot(1,2,1)
        imagesc(centroid);
        title('Phase Locking centroid');
        subplot(1,2,2)
        hold off
        plot(positions,momentum,'.','color','blue','linewidth',1.5);
        hold on
        plot(positions,momentum,'color','red','linewidth',0.25);
        xlim([minx maxx]);
        ylim([miny maxy]);
        title('Phase space Pattern');
        xlabel('Position');
        ylabel('Momentum');
    end
end
end

