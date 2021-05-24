% collect together all this data and convert it to a NetCDF file

% https://github.com/ShervanGharari/Quick_Start_for_NetCDF/wiki/Reading-and-writing-of-NetCDF-files#write-netcdf-files-in-matlab-or-octave

% clean up workspace
clear all
close all

%----- load and collect tracer centre of mass data

tracer_com = zeros(2,438,5);
%ptr
load('lon_stats/ptr1weightedLonMean.mat');
tmp1 = tracWeightedMean;
load('lat_stats/ptr1weightedLatMean.mat');
tmp2 = tracWeightedMean;
tmp3 = [tmp1; tmp2];
tracer_com(:,:,1) = tmp3;
%ptr
load('lon_stats/ptr2weightedLonMean_ausTrack_indBasinOnly.mat');
tmp1 = tracWeightedMean;
load('lat_stats/ptr2weightedLatMean_ausTrac_indBasinOnly.mat');
tmp2 = tracWeightedMean;
tmp3 = [tmp1; tmp2];
tracer_com(:,:,2) = tmp3;
%ptr
%load('lon_stats/ptr2weightedLonMean_ausTrack_pacBasinOnly.mat');
%tmp1 = tracWeightedMean;
%load('lat_stats/ptr2weightedLatMean_ausTrac_pacBasinOnly.mat');
%tmp2 = tracWeightedMean;
%tmp3 = [tmp1; tmp2];
%tracer_com(:,:,3) = tmp3;
%ptr
%load('lon_stats/ptr2weightedLonMean');
%tmp1 = tracWeightedMean;
%load('lat_stats/ptr2weightedLatMean');
%tmp2 = tracWeightedMean;
%tmp3 = [tmp1; tmp2];
%tracer_com(:,:,4) = tmp3;
%ptr
load('lon_stats/ptr3weightedLonMean');
tmp1 = tracWeightedMean;
load('lat_stats/ptr3weightedLatMean');
tmp2 = tracWeightedMean;
tmp3 = [tmp1; tmp2];
tracer_com(:,:,3) = tmp3;
%ptr
load('lon_stats/ptr4weightedLonMean');
tmp1 = tracWeightedMean;
load('lat_stats/ptr4weightedLatMean');
tmp2 = tracWeightedMean;
tmp3 = [tmp1; tmp2];
tracer_com(:,:,4) = tmp3;
%ptr
load('lon_stats/ptr5weightedLonMean_atlTrack_atlBasinOnly.mat');
tmp1 = tracWeightedMean;
load('lat_stats/ptr5weightedLatMean_atlTrac_atlBasinOnly.mat');
tmp2 = tracWeightedMean;
tmp3 = [tmp1; tmp2];
tracer_com(:,:,5) = tmp3;
%ptr
%load('lon_stats/ptr5weightedLonMean');
%tmp1 = tracWeightedMean;
%load('lat_stats/ptr5weightedLatMean');
%tmp2 = tracWeightedMean;
%tmp3 = [tmp1; tmp2];
%tracer_com(:,:,8) = tmp3;

% time
t1 = linspace(0,438,438);
t1 = t1./12;
years_since_release = t1;

% tracer release locations
tracer_release_locations = zeros(2,5);
B(1,1) =  91; B(2,1) = -41;
B(1,2) = 131; B(2,2) = -47;
B(1,3) =-135; B(2,3) = -48;
B(1,4) = -89; B(2,4) = -50;
B(1,5) = -54; B(2,5) = -44;
tracer_release_locations = B;

%----- load and collect tracer histogram and streamfunction

load('potential/montgomery_on_sig1.mat')
longitude = XC;
latitude = YC;
mont_geos_pot = psi_sig;
sigma1_levels = siglevs;

% tracer
load('tracer/tracer_hist_onefile.mat')
tracer_histogram = tracer_hist;

% normalise each tracer histogram separately
for j=1:5
  tmpA = squeeze(tracer_histogram(:,:,j));
  myscale = max(tmpA(:));
  tracer_histogram(:,:,j) = tracer_histogram(:,:,j)./myscale;
end

%% save as single matlab file
save('expose_tracer_histograms.mat',...
     'XC','YC','mont_geos_pot','sigma1_levels','years_since_release',...
     'tracer_release_locations','tracer_com','tracer_histogram');
