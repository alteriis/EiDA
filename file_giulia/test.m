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

   % we now create a cell which contains a number of sub-cells equal to the
   % number of groups and each subcell contains that group's label and the
   % number of variables that belong to that group

   specifics = {{'Output and Income', size(group_1,2)}, {'Labour Market', size(group_2,2)}, ...
       {'Consumption and Orders', size(group_3,2)}, {'Orders and Inventories', size(group_4,2)}, ...
       {'Money and Credit', size(group_5,2)}, {'Interest Rate and Exchange Rates', ...
       size(group_6,2)}, {'Prices', size(group_7,2)}, {'Stock Market', size(group_8,2)}};

   addpath '/Users/giuliadesanctis/Documents/MATLAB/EiDA/functions/eida'
   compute_leading_eigen_sliding_window(all_groups,100, true, specifics,2) 
   % no idea if 100 is an acceptable size for half window size

  
  