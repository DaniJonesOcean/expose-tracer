%
% Tracer histogram plots
%

%% Initial setup

% clean up workspace
clear
close all

% load colormaps
load('cividis.txt')
load('qual6.txt')
cmp_qual = qual6./256;

%% Load and process data

% load matlab file
load('expose_tracer_histograms.mat')

% single fields
tracer_field = squeeze(nansum(tracer_histogram,3));
tracer_field_1to4 = squeeze(nansum(tracer_histogram(:,:,1:4),3));

%% Extract some contours

figure(1)
[C1,h1] = contour(XC,YC,mont_geos_pot(:,:,1),[15 1e6]);

%% Colors for individual tracers

tracer_onecolor = tracer_histogram; 

for i=1:4
    A = squeeze(tracer_histogram(:,:,i));
    A(A>0.05) = i;
    tracer_onecolor(:,:,i) = A; %#ok<*SAGROW>
end

i=5;
A = squeeze(tracer_histogram(:,:,i));
A(A>0.25) = i;
tracer_onecolor(:,:,i) = A; %#ok<*SAGROW>

% single 
tracer_onecolor_2D = squeeze(max(tracer_onecolor,[],3));

%% Single plot, one color each

figPos = [455   139   667   607];
figure('color','w','position',figPos);
m_proj('stereographic','lat',-90,'long',25,'radius',62);
m_pcolor(XC,YC,tracer_onecolor_2D)
colormap(cmp_qual)
caxis([0 6])
m_coast('patch',[.5 .5 .5],'edgecolor','none');
m_grid('xtick',-180:60:180,...
    'XaxisLocation','top',...
    'tickdir','in',...
    'ytick',-70:20:-30,...
    'fontsize',18,...
    'linest',':');
hold on

% geostrophic streamfunctions
mont_intervals = 8.0:2.0:16.0;
lw = 1.5;   cl = [0.9 0.9 0.9];
m_contour(XC,YC,mont_geos_pot(:,:,2),mont_intervals,'color',cl,'linewidth',lw);
m_contour(XC,YC,mont_geos_pot(:,:,3),mont_intervals,'color',cl,'linewidth',lw);
m_contour(XC,YC,mont_geos_pot(:,:,4),mont_intervals,'color',cl,'linewidth',lw);
m_contour(XC,YC,mont_geos_pot(:,:,5),mont_intervals,'color',cl,'linewidth',lw);
m_contour(XC,YC,mont_geos_pot(:,:,6),mont_intervals,'color',cl,'linewidth',lw);

% tracer release locations 
m_plot(tracer_release_locations(1,1:5),...
    tracer_release_locations(2,1:5),...
    'linestyle','none',...
    'marker','d',...
    'color','k',...
    'markersize',24)
hold on

% centres of mass
tracer_com = tracer_com(:,1:120,:);  % just select first decade
m_plot(tracer_com(1,:,1),...
    tracer_com(2,:,1),...
    'color','k',...
    'linewidth',2.0,...
    'linestyle','--');
hold on
m_plot(tracer_com(1,:,2),...
    tracer_com(2,:,2),...
    'color','k',...
    'linewidth',2.0,...
    'linestyle','--');
hold on
m_plot(tracer_com(1,:,3),...
    tracer_com(2,:,3),...
    'color','k',...
    'linewidth',2.0,...
    'linestyle','--');
hold on
m_plot(tracer_com(1,:,4),...
    tracer_com(2,:,4),...
    'color','k',...
    'linewidth',2.0,...
    'linestyle','--');
hold on
m_plot(tracer_com(1,:,5),...
    tracer_com(2,:,5),...
    'color','k',...
    'linewidth',2.0,...
    'linestyle','--');



%% Single plot, layers - single color, 

% figure('color','w')
% 
% % layer1
% Z1 = squeeze(tracer_histogram(:,:,1));
% Z1 = Z1./max(Z1(:));
% p1 = surf(XC,YC,zeros(size(Z1)),'AlphaData',Z1,...
%     'FaceAlpha','interp',...
%     'FaceColor',cmp_qual(1,:),...
%     'edgecolor','none');
% hold on
% 
% % layer2
% Z1 = squeeze(tracer_histogram(:,:,2));
% Z1 = Z1./max(Z1(:));
% p2 = surf(XC,YC,zeros(size(Z1))-1,'AlphaData',Z1,...
%     'FaceAlpha','interp',...
%     'FaceColor',cmp_qual(2,:),...
%     'edgecolor','none');
% hold on
% 
% % layer3
% Z1 = squeeze(tracer_histogram(:,:,3));
% Z1 = Z1./max(Z1(:));
% p3 = surf(XC,YC,zeros(size(Z1))-2,'AlphaData',Z1,...
%     'FaceAlpha','interp',...
%     'FaceColor',cmp_qual(3,:),...
%     'edgecolor','none');
% hold on
% 
% % layer4
% Z1 = squeeze(tracer_histogram(:,:,4));
% Z1 = Z1./max(Z1(:));
% p4 = surf(XC,YC,zeros(size(Z1))-3,'AlphaData',Z1,...
%     'FaceAlpha','interp',...
%     'FaceColor',cmp_qual(4,:),...
%     'edgecolor','none');
% hold on
% 
% % layer5
% Z1 = squeeze(tracer_histogram(:,:,5));
% Z1 = Z1./max(Z1(:));
% p5 = surf(XC,YC,zeros(size(Z1))-4,'AlphaData',Z1,...
%     'FaceAlpha','interp',...
%     'FaceColor',cmp_qual(5,:),...
%     'edgecolor','none');
% hold on

%% Single plot, continuous

% figPos = [455   139   667   607];
% figure('color','w','position',figPos);
% m_proj('stereographic','lat',-90,'long',0,'radius',60);
% m_contourf(XC,YC,tracer_field)
% caxis([0 0.3])
% colormap(cividis)
% colorbar
% m_grid('xtick',-180:60:180,'tickdir','in','ytick',-70:10:-50,'linest',':');
% m_coast('patch',[.7 .7 .7],'edgecolor','none');

%% Plot
% 
% figPos = [455   139   667   607];
% 
% figure('color','w','position',figPos);
% m_proj('stereographic','lat',-90,'long',0,'radius',60);
% m_contourf(XC,YC,tracer_histogram(:,:,4))
% caxis([0 0.3])
% colormap(cividis)
% colorbar
% m_grid('xtick',-180:60:180,'tickdir','in','ytick',-70:10:-50,'linest',':');
% m_coast('patch',[.7 .7 .7],'edgecolor','none');



