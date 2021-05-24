% get rid of previous one
!rm -f expose_tracer_histograms.nc

% clean up workspace
clear all
close all

% load data
load('expose_tracer_histograms.mat');

%----- create the NetCDF file

ncid = netcdf.create('expose_tracer_histograms.nc','NETCDF4');   % Matlab

%-- spatial and temporal coordinates
dimid_X = netcdf.defDim(ncid,'nlon',2160);
dimid_Y = netcdf.defDim(ncid,'nlat',320);
dimid_cn = netcdf.defDim(ncid,'ncoord',2);
dimid_tn = netcdf.defDim(ncid,'ntracer',5);
dimid_sig1 = netcdf.defDim(ncid,'nsig1',6);
dimid_T = netcdf.defDim(ncid,'time',438);

% variables
lat_varid = netcdf.defVar(ncid,'lat','NC_DOUBLE',[dimid_X dimid_Y]);
lon_varid = netcdf.defVar(ncid,'lon','NC_DOUBLE',[dimid_X dimid_Y]);
cn_varid = netcdf.defVar(ncid,'cn','NC_DOUBLE',[dimid_cn]);
tn_varid = netcdf.defVar(ncid,'tn','NC_DOUBLE',[dimid_tn]);
sig1_varid = netcdf.defVar(ncid,'sigma1','NC_DOUBLE',[dimid_sig1]);

% attributes
netcdf.putAtt(ncid,lat_varid,'long_name',    'latitude');
netcdf.putAtt(ncid,lon_varid,'long_name',    'longitude');
netcdf.putAtt(ncid,lat_varid,'units',        'degrees_north');
netcdf.putAtt(ncid,lon_varid,'units',        'degrees_east');
netcdf.putAtt(ncid,lat_varid,'standard_name','latitude');
netcdf.putAtt(ncid,lon_varid,'standard_name','longitude');

% coord number and tracer number
netcdf.putAtt(ncid,cn_varid,'long_name', 'coordinate number (lon,lat)');
netcdf.putAtt(ncid,tn_varid,'long_name', 'tracer number (1-5)');

% attributes - sig1
netcdf.putAtt(ncid,sig1_varid,'long_name', 'sigma1 potential density');
netcdf.putAtt(ncid,sig1_varid,'units', 'kg/m^3');
netcdf.putAtt(ncid,sig1_varid,'standard_name','sigma1');

% write data
netcdf.endDef(ncid);
netcdf.putVar(ncid,lat_varid,YC)
netcdf.putVar(ncid,lon_varid,XC)
netcdf.putVar(ncid,cn_varid,[1 2]);
netcdf.putVar(ncid,tn_varid,[1 2 3 4 5]);
netcdf.putVar(ncid,sig1_varid,sigma1_levels)

%-- time coordinate
time_varid = netcdf.defVar(ncid,'time','NC_INT', dimid_T);

% attributes
netcdf.putAtt(ncid,time_varid ,'long_name','time');
netcdf.putAtt(ncid,time_varid ,'units','years since tracer release');
netcdf.putAtt(ncid,time_varid ,'standard_name','time');
netcdf.putAtt(ncid,time_varid ,'axis','T');

% write data
netcdf.endDef(ncid);
netcdf.putVar(ncid,time_varid,years_since_release)

%-- tracer histograms

% variable
netcdf.reDef(ncid);
hist_varid = netcdf.defVar(ncid,'tracer_hist','NC_DOUBLE',[dimid_X dimid_Y dimid_tn]);

% attributes
netcdf.putAtt(ncid,hist_varid,'long_name',  'column-integrated tracer histogram');
netcdf.putAtt(ncid,hist_varid,'units',      'unitless (relative to maximum value per tracer)');
netcdf.putAtt(ncid,hist_varid,'coordinates','lon lat');

% write data
netcdf.endDef(ncid);
netcdf.putVar(ncid,hist_varid,tracer_histogram)

%-- Montgomery geostrophic streamfunction

% variable
netcdf.reDef(ncid);
mont_varid = netcdf.defVar(ncid,'montgomery','NC_DOUBLE',[dimid_X dimid_Y dimid_sig1]);

% attributes
netcdf.putAtt(ncid,mont_varid,'long_name',  'Montgomery geostrophic potential');
netcdf.putAtt(ncid,mont_varid,'units',      'Sv');
netcdf.putAtt(ncid,mont_varid,'coordinates','lon lat');
netcdf.putAtt(ncid,mont_varid,'reference_pressure','1000 dbar');

% write data
netcdf.endDef(ncid);
netcdf.putVar(ncid,mont_varid,mont_geos_pot)

%-- Add tracer release locations
netcdf.reDef(ncid);
loc_varid = netcdf.defVar(ncid,'release_locations','NC_DOUBLE',[dimid_cn dimid_tn]);
netcdf.putAtt(ncid,loc_varid,'long_name','tracer release locations');
netcdf.putAtt(ncid,loc_varid,'coordinates','cn tn');
netcdf.endDef(ncid);
netcdf.putVar(ncid,loc_varid,tracer_release_locations);

%-- Add tracer centres of mass
netcdf.reDef(ncid);
com_varid = netcdf.defVar(ncid,'tracer_com','NC_DOUBLE',[dimid_cn dimid_T dimid_tn]);
netcdf.putAtt(ncid,com_varid,'long_name','tracer centres of mass');
netcdf.putAtt(ncid,com_varid,'coordinates','cn time tn')
netcdf.endDef(ncid);
netcdf.putVar(ncid,com_varid,tracer_com);

%-- global attributes

% global attributes
netcdf.reDef(ncid);
netcdf.putAtt(ncid,netcdf.getConstant('NC_GLOBAL'),'Conventions','CF-1.6');
netcdf.putAtt(ncid,netcdf.getConstant('NC_GLOBAL'),'History',    ['Created ',datestr(datetime('now'))]);
netcdf.putAtt(ncid,netcdf.getConstant('NC_GLOBAL'),'Source',     'Compiled and prepared by D.C. Jones (British Antarctic Survey)');
netcdf.putAtt(ncid,netcdf.getConstant('NC_GLOBAL'),'Reference paper URL',  'https://doi.org/10.1002/2016JC011680');
netcdf.endDef(ncid);

% close NetCDF file
netcdf.close(ncid)

% write it out
ncdisp('expose_tracer_histograms.nc')
