function add_labels (n, g_size, lab_names)

% this function adds labels to a matrix
% inputs:
% "n" = integer input which corresponds to the number of groups
% "g_size" = vector of integers which gives us the number of variables that belong to each
% group 
% "lab_names": is a cell where the label names are contained

% We need a vector which stores the label positions for each group 
label_pos = zeros(1,n);
label_pos(1) = 1;
for i = 2:n 
    label_pos(i) = label_pos(i-1)+g_size(i-1);
end

% add the group labels to the x-axis
xticks(label_pos);
xticklabels(lab_names);
xline(label_pos, 'LineWidth', 2); % this can easily be deleted if you don't like the grid 

% add the group labels to the y-axis
yticks(label_pos);
yticklabels(lab_names);
yline(label_pos, 'LineWidth', 2); % this can easily be deleted if you don't like the grid 

% rotate both the x-axis and the y-axis labels by 45 degrees for readability
ytickangle(45);
xtickangle(45);

% add a colorbar to show the color scale
colorbar;

% title 
title('Plot of the covariance matrix')

end
