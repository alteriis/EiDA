%% test to see if the function works, feeding it the inputs from the us_economy dataset
   addpath '/Users/giuliadesanctis/Documents/MATLAB/EiDA/data/us_economy'
   % I realise this is not at all general, it's just to make sure it works
    
   load('sample.mat')

   % now we rearrange the data
   group_1 = us_economy(:,[1:2,6:20]);
   group_2 = us_economy(:,[21:49, 127:129]);
   group_3 = us_economy(:,[50:59]);
   group_4 = us_economy(:,[3:5,60:69,130]);
   group_5 = us_economy(:,[70:79,131:134]);
   group_6 = us_economy(:,[84:105]);
   group_7 = us_economy(:,[106:126]);
   group_8 = us_economy(:,[80:83]);

   % we recompose the data in the right order
   all_groups = [group_1, group_2, group_3, group_4, group_5, group_6, group_7, group_8];

   % we find the size of each group
   group_size = [size(group_1,2), size(group_2,2), size(group_3,2), size(group_4,2), ...
        size(group_5,2), size(group_6,2), size(group_7,2), size(group_8,2)];

   % vector to store the label names for each group
   label_names = {'Output and Income', 'Labour Market', 'Consumption and Orders', ...
        'Orders and Inventories', 'Money and Credit', 'Interest Rate and Exchange Rates', ...
        'Prices', 'Stock Market'};

   addpath '/Users/giuliadesanctis/Documents/MATLAB/EiDA/functions/eida'
   Copy_of_compute_leading_eigen_pearson(all_groups,100, true, group_size, label_names) 
   % no idea if 10 is an acceptable size for half window size