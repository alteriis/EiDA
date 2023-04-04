function visualise_time_course(matrix,Ts,amplification,separation,black)
%VISUALISE_TIME_COURSE This function visualizes all the rois in the same
%plot

% Ts is the sampling time, amplification is how much I amplify each signal
% amplitude, separation is how distant they will be

n_rois = size(matrix,2);
time_steps = size(matrix,1);

for i=1:n_rois
    if black
        plot(Ts*(0:time_steps-1),amplification*matrix(:,i)+(i-1)*separation*ones(time_steps,1),'Color','black');
    else
        plot(Ts*(0:time_steps-1),amplification*matrix(:,i)+(i-1)*separation*ones(time_steps,1));

    end
    hold on
end

yticks('');
xlabel('Time (s)');
ylabel('Region');

end

