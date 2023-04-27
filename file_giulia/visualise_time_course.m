function visualise_time_course(matrix, data_specific_info)
%VISUALISE_TIME_COURSE This function visualizes all the rois in the same
%plot

% Ts is the sampling time, amplification is how much I amplify each signal
% amplitude, separation is how distant they will be

m = max(matrix, [], 'all');
norm_mat = matrix/m;

n_rois = size(norm_mat,2);
time_steps = size(norm_mat,1);

% find the number of groups
num = size(data_specific_info,2);

% we extract the group size and label name of each individual group from the cell 
g_size = zeros(1,num);
label_names = cell(1,num,1);

for i=1:num
    g_size(i) = data_specific_info{i}{2};
    label_names{i} = data_specific_info{i}{1};
end 

% create a separate colormap for each group
colors = [];
for i = 1:num
    new = rand(1,3);
    for j = 1:g_size(i)
        colors = [colors; new];
    end
end

label_pos = zeros(1,num);
label_pos(1) = g_size(1)/2; 
sum = 0; 
for i = 2:num
    sum = sum + g_size(i-1); 
    label_pos(i) = sum + 0.5*g_size(i);
end

for i=1:n_rois
    plot((0:time_steps-1),norm_mat(:,i)+(i-1)*ones(time_steps,1), 'color', colors(i,:));
    hold on;
end

% add the group labels to the y-axis
yticks(label_pos);
yticklabels(label_names);
ytickangle(45);

xlabel('Time (s)');


end
