function add_labels (g_size, lab_names, ax)

% this function adds labels to a matrix
% inputs:
% "n" = integer input which corresponds to the number of groups
% "g_size" = vector of integers which gives us the number of variables that belong to each
% group 
% "lab_names": is a cell where the label names are contained

% We need a vector which stores the label positions for each group 
n = size(g_size,2);
label_pos = zeros(1,n);
label_pos(1) = g_size(1)/2; 
sum = 0; 
for i = 2:n
    sum = sum + g_size(i-1); 
    label_pos(i) = sum + 0.5*g_size(i);
end

% add the group labels to the x-axis
xticks(ax, label_pos);
xticklabels(ax, lab_names);
xline(ax, label_pos, 'LineWidth', 2); 

% add the group labels to the y-axis
ylim(ax, [0 sum+g_size(n)])
yticks(ax, label_pos);
yticklabels(ax, lab_names);
yline(ax, label_pos, 'LineWidth', 2); 

% rotate both the x-axis and the y-axis labels by 45 degrees for readability
ytickangle(ax, 45);
xtickangle(ax, 45);

% add a colorbar to show the color scale
colorbar (ax);

end
