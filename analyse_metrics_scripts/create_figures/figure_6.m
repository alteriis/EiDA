% load overall things
clear
close all

addpath('../../saved_calculations/basic');
addpath('../../saved_calculations/leida/clusters_2');
addpath('../../saved_calculations/leida/full_matrix_decomposition');
addpath('../../saved_calculations/leida/2_leading_eigenvectors');
addpath('../../functions/basic');
addpath('../../functions/graphics');
addpath('../../saved_calculations/nonlinear');
addpath('../../saved_calculations/leida');
addpath('../../functions/nonlinear');
addpath('../../functions/leida');
addpath('../basic');

load('global_parameters.mat');
load('palette.mat');

%%
theta = [0 0 0 pi 0 pi 0 0 0 0]';
c = cos(theta);
s = sin(theta);
pl1 = c*c' + s*s';

imagesc(pl1,[-1 1]);
xticks(0.5+(1:9));
yticks(0.5+(1:9));
xticklabels('');
yticklabels('');


figure
theta = [pi/2 pi/2 pi/2 pi/2 pi/2 0 0 0 0 0]';
c = cos(theta);
s = sin(theta);
pl2 = c*c' + s*s';

imagesc(pl2,[-1 1]);
xticks(0.5+(1:9));
yticks(0.5+(1:9));
xticklabels('');
yticklabels('');

%% 

[v,~] = eigs(pl1,1);

plot_eigenvector(v(:,1),1,.5,1);

figure
imagesc(v(:,1)*v(:,1)',[-1 1]);
xticks(0.5+(1:9));
yticks(0.5+(1:9));
xticklabels('');
yticklabels('');
figure


%% 

[v,d] = eigs(pl2,2);

plot_eigenvector(v(:,1),1,.5,1);
plot_eigenvector(v(:,2),0,.5,1);

figure
imagesc(v(:,1)*v(:,1)',[-1 1]);
xticks(0.5+(1:9));
yticks(0.5+(1:9));
xticklabels('');
yticklabels('');
figure
imagesc(v(:,2)*v(:,2)',[-1 1]);
xticks(0.5+(1:9));
yticks(0.5+(1:9));
xticklabels('');
yticklabels('');

%%
v1 = [1 1 1 -1 1 -1 1 1 1 1]';
plot_eigenvector(v1,1,1,1);
figure
imagesc(v1*v1',[-1 1]);


%% 
load('2_leading_eigenvectorsT1_subject1.mat');
T = 63;

a = leading_eigen(1:44,T);
b = leading_eigen(45:88,T);
imagesc(a*a'+b*b',[-1 1]);
axis off
figure
imagesc(a*a',[-1 1]);
axis off
figure
imagesc(b*b',[-1 1]);
axis off
plot_eigenvector(a,1,1,1);
plot_eigenvector(b,0,1,1);
%%
load('2_leading_eigenvectorsT1_subject2.mat');
T = 231;

a = leading_eigen(1:44,T);
b = leading_eigen(45:88,T);
figure
imagesc(a*a'+b*b',[-1 1]);
axis off
figure
imagesc(a*a',[-1 1]);
axis off
figure
imagesc(b*b',[-1 1]);
axis off
figure 
imagesc(b*b',[-1 1]);
colorbar
plot_eigenvector(a,1,1,1);
plot_eigenvector(b,0,1,1);
