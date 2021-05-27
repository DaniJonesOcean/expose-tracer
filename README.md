# expose-tracer
This repository contains code and data from a set of passive tracer experiments [Fig. 4, Jones et al. (2016)]. This figure has been included as part of a review paper on ventilation (Morrison et al., 2021) 

![image](https://user-images.githubusercontent.com/11757453/119817947-7b943c80-bee6-11eb-8361-4facaad3d59f.png)

## Requirements for Matlab code
- Matlab 2018b
- M_Map v1.4k

## Requirements for Jupyter notebook
- python 3.7.4
- matplotlib 3.1.1
- cartopy 0.17.0
- numpy 1.17.2
- xaray 0.16.2

## Project Organization
```
├── colormaps                 <- Various colormaps used in these plots
├── data_in                   <- Tracer data from Jones et al. (2016)
├── data_pre                  <- Matlab code that was used to create the NetCDF file
├── notebooks                 <- Jupyter notebook for visualization
├── plots                     <- Plots from Matlab code
|
├── LICENSE
|
├── README.md                 <- Overall description
|
├── tracer_histogram_plot.m   <- Matlab code to plot distribution 
```

## References
Jones, D. C., Meijers, A. J. S., Shuckburgh, E., Sallée, J.-B., Haynes, P., McAufield, E. K., and Mazloff, M. R. (2016), How does Subantarctic Mode Water ventilate the Southern Hemisphere subtropics?, J. Geophys. Res. Oceans, 121, 6558– 6582, [doi:10.1002/2016JC011680.](https://agupubs.onlinelibrary.wiley.com/doi/full/10.1002/2016JC011680) 

Morrison, A. K., Waugh, D. W., Hogg, A. McC., Jones, D. C., and Abernathey, R. P. (2021), Ventilation  of the Southern Ocean pycnocline, under review 
