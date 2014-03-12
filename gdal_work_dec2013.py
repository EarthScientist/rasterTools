# read in the modules we will need in the python GIS world

import numpy, gdal, gdalconst, os, sys, re, scipy

# set a working dir to work with
workingDir = '/workspace/UA/malindgren/projects/gdal_work'
os.chdir(workingDir)

# lets read in a raster and try to do some basic value changing based on a conditional 
rst = gdal.Open('/workspace/UA/malindgren/projects/gdal_work/test_data/tas_mean_c_akcan_prism_08_1961_1990_ak83alb.tif')

def raster2array(rasterfn):
    raster = gdal.Open(rasterfn)
    band = raster.GetRasterBand(1)
    array = band.ReadAsArray()
    return array

# read a raster in
rst.ReadRaster(rst, 1, 1, rst.RasterXSize, rst.RasterYSize)