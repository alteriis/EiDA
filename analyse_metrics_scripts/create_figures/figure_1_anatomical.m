% load overall things
clear 

addpath('../../saved_calculations/basic');
addpath('../../saved_calculations/leida/clusters');
addpath('../../saved_calculations/leida/leading_eigenvectors');
addpath('../../saved_calculations/leida/full_matrix_decomposition');
addpath('../../saved_calculations/leida/2_leading_eigenvectors');
addpath('../../functions/basic');
addpath('../../functions/graphics');
load('global_parameters.mat');
load('palette.mat');
addpath('../../saved_calculations/nonlinear');
addpath('../../functions/nonlinear');
addpath('../../functions/leida');


%% Load atlas

atlas_parcellated = '/home/k21208334/rat_ageing/matlab/dealteriis/VHandWHS/VHandWHS_functional_v2_unilateral.nii.gz';% this is the name of the atlas with 44 regions. I will project results here
atlas = niftiread(atlas_parcellated);

%% CREATE NII OF FIRST EIGEN

time_old = 278;
load('2_leading_eigenvectorsT4_subject2.mat');
projected_vector = zeros(size(atlas));

v1 = leading_eigen(1:n_channels,time_old);


for index=1:n_channels
    projected_vector(atlas == index) = v1(index);
end

xmass = [];
ymass = [];
zmass = [];

for i = 1:size(projected_vector,1)
    xmass(i) = sum(projected_vector(i,:,:),'all');
end

for i = 1:size(projected_vector,2)
    ymass(i) = sum(projected_vector(:,i,:),'all');
end

for i = 1:size(projected_vector,3)
    zmass(i) = sum(projected_vector(:,:,i),'all');
end

projected_vector = projected_vector(31:216,69:290,84:230);
niftiwrite(projected_vector,'anatomical v1');

%% CREATE NII OF SECOND EIGEN

time_old = 278;
load('2_leading_eigenvectorsT4_subject2.mat');
projected_vector = zeros(size(atlas));

v2 = leading_eigen(n_channels+1:end,time_old);


for index=1:n_channels
    projected_vector(atlas == index) = v2(index);
end

projected_vector = projected_vector(31:216,69:290,84:230);
niftiwrite(projected_vector,'anatomical v2');



