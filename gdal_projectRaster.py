


# f <- function(x){
# 	values(x)[which(is.na(values(x)) == TRUE)] <- 255
# 	polys <- rasterToPolygons(x, dissolve=TRUE)
# 	writeShapeSpatial(polys,fn='')
# }

# polys <- mclapply(unstack(cliomes.s.rea), f, mc.cores=detectCores()-3)




# gdalwarp -t_srs '+init=epsg:3338' -r near -tr 30 -of HFA /Data/Base_Data/GIS/GIS_Data/Raster/Land_Cover/Canada_EOSD_Land_Cover/EOSD_35m_mosaicked.img /Data/Base_Data/GIS/GIS_Data/Raster/Land_Cover/Canada_EOSD_Land_Cover/EOSD_30m_mosaicked_akalb_ngb.img






# #!/usr/bin/env python

# from osgeo import gdal, gdalconst

# # Source
# src_filename = 'MENHMAgome01_8301/mllw.gtx'
# src = gdal.Open(src_filename, gdalconst.GA_ReadOnly)
# src_proj = src.GetProjection()
# src_geotrans = src.GetGeoTransform()

# # We want a section of source that matches this:
# match_filename = 'F00574_MB_2m_MLLW_2of3.bag'
# match_ds = gdal.Open(match_filename, gdalconst.GA_ReadOnly)
# match_proj = match_ds.GetProjection()
# match_geotrans = match_ds.GetGeoTransform()
# wide = match_ds.RasterXSize
# high = match_ds.RasterYSize

# # Output / destination
# dst_filename = 'F00574_MB_2m_MLLW_2of3_mllw_offset.tif'
# dst = gdal.GetDriverByName('GTiff').Create(dst_filename, wide, high, 1, gdalconst.GDT_Float32)
# dst.SetGeoTransform( match_geotrans )
# dst.SetProjection( match_proj)

# # Do the work
# gdal.ReprojectImage(src, dst, src_proj, match_proj, gdalconst.GRA_Bilinear)

# del dst # Flush



#!/usr/bin/env python
def projectRaster(inRST,outRST,outRef,):
	from osgeo import gdal, gdalconst

	# Source
	src_filename = 'MENHMAgome01_8301/mllw.gtx'
	src = gdal.Open(inRST, gdalconst.GA_ReadOnly)
	src_proj = src.GetProjection()
	src_geotrans = src.GetGeoTransform()

	# We want a section of source that matches this:
	match_filename = 'F00574_MB_2m_MLLW_2of3.bag'
	match_ds = gdal.Open(match_filename, gdalconst.GA_ReadOnly)
	match_proj = match_ds.GetProjection()
	match_geotrans = match_ds.GetGeoTransform()
	wide = match_ds.RasterXSize
	high = match_ds.RasterYSize

	# Output / destination
	dst_filename = 'F00574_MB_2m_MLLW_2of3_mllw_offset.tif'
	dst = gdal.GetDriverByName('GTiff').Create(dst_filename, wide, high, 1, gdalconst.GDT_Float32)
	dst.SetGeoTransform( match_geotrans )
	dst.SetProjection( match_proj)

	# Do the work
	gdal.ReprojectImage(src, dst, src_proj, match_proj, gdalconst.GRA_Bilinear)

	del dst # Flush