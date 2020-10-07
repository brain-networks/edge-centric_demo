% clean up env for clean run
clearvars; close all; clc

%% make edge time series, eFC, and related concepts

% add helper functions to path
addpath(genpath('fcn'));

% load example time series, system labels, and names
load example_data
ts = double(ts);

% create edge time series from regional time series
[T,N] = size(ts);
M = N*(N - 1)/2;
ets = fcn_edgets(ts);

% uncomment to calculate efc - memory intensive
%efc = fcn_edgets2edgecorr(ets);

% run kmeans -- note that in principle any clustering algorithm can be
% applied to edge time series or the efc matrix
k = 10;
ci = kmeans(ets',k,...
    'distance','sqeuclidean',...
    'maxiter',1000);

% map edge communities into matrix
mat = zeros(N);
mat(triu(ones(N),1) > 0) = ci;
mat = mat + mat';

%% calculate community similarity

s = fcn_profilesim(mat);

%% calculate normalized entropy

[u,v] = find(triu(ones(N),1));
[~,enorm] = fcn_node_entropy(ci,u,v,N);

%% make some figures

[gx,gy,idx] = grid_communities(lab); % BCT function

figure, imagesc(mat(idx,idx)); axis square; hold on; plot(gx,gy,'k','linewidth',2); title('Edge communities')
figure, imagesc(s(idx,idx)); axis square; hold on; plot(gx,gy,'k','linewidth',2); title('Edge community similarity')
figure, boxplot(enorm,lab,'labels',net,'labelorientation','inline'); title('Norm entropy per system')

%% visualize edge time series

[~,idx] = sort(ci); dffidx = find(diff(ci(idx)));
figure, imagesc(ets(:,idx)',[-4,4]); hold on;
for i = 1:length(dffidx)
    plot([0.5,T + 0.5],dffidx(i)*ones(1,2),'k');
end

%% visualize efc matrix

if exist('efc','var')
    figure, imagesc(efc(idx,idx),[-1,1]);
end

%% make surface plot

enorm_rank = tiedrank(enorm); % for visualization, rank transform entropy

% load 32k surfaces
load fcn/surfinfo
cr = zeros(size(gr.cdata));
cl = zeros(size(gl.cdata));
cr(gr.cdata ~= 0) = enorm_rank(gr.cdata(gr.cdata ~= 0));
cl(gl.cdata ~= 0) = enorm_rank(gl.cdata(gl.cdata ~= 0));

cmap = fcn_cmaphot;

figure, th = trisurf(sr.data{2}.data+1,sr.data{1}.data(:,1),sr.data{1}.data(:,2),sr.data{1}.data(:,3),cr);
set(th,'edgecolor','none'); axis image; set(gca,'clim',[min(enorm_rank),max(enorm_rank)]);
view(gca,3);axis equal;axis off;view(90,0);material dull;camlight headlight;lighting gouraud
colormap(cmap);

figure, th = trisurf(sl.data{2}.data+1,sl.data{1}.data(:,1),sl.data{1}.data(:,2),sl.data{1}.data(:,3),cr);
set(th,'edgecolor','none'); axis image; set(gca,'clim',[min(enorm_rank),max(enorm_rank)]);
view(gca,3);axis equal;axis off;view(-90,0);material dull;camlight headlight;lighting gouraud
colormap(cmap);