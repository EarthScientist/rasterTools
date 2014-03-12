
# this function is a faster alternative to the projectRaster function in the raster package.  It is a very simple
#  reprojection script, which uses system calls to the gdal library to perform the warping.  
quikWarp <- function(in_raster, in_srs, out_srs, method){
	if(!'package:raster' %in% search()) require(raster)
	#create some unique temp file names
	tmp_name_in=tempfile("warpfile_in", tmpdir=tempdir(),fileext=".tif")
	tmp_name_out=tempfile("warpfile_out", tmpdir=tempdir(),fileext=".tif")
	# tell R to get rid of these files when it exits the program
	on.exit(unlink(tmp_name_in))
	on.exit(unlink(tmp_name_out))
	# save the names of the raster to pass into the new object
	name_hold=names(in_raster)[1]
	# this is where the magic happens, but can be refined to have more options, which may at the end of the day slow the function down substantially
	if(inMemory(in_raster)==FALSE){
		writeRaster(in_raster, filename=tmp_name_in, overwrite=TRUE)
		system(paste('gdalwarp -s_srs',in_srs,'-t_srs',out_srs,'-r',method,tmp_name_in,tmp_name_out,sep=' '))
	}else{
		system(paste('gdalwarp -s_srs',in_srs,'-t_srs',out_srs,'-r',method,filename(in_raster),tmp_name_out,sep=' '))
	}
	r <- readAll(raster(tmp_name_out))
	names(r) <- name_hold
	r@file@name <- paste(name_hold[1],".tif",sep="")
	return(r)
}

# Working Example Below
# t1<-Sys.time(); rr<-quikWarp(in_raster=raster('/Data/Base_Data/Climate/AK_CAN_2km/projected/AR5_CMIP5_models/rcp45/5modelAvg/tas/tas_mean_C_AR5_5modelAvg_08_2013.tif'), in_srs='EPSG:3338', out_srs='EPSG:4326', method='near'); t2<-Sys.time(); difftime(t2,t1)


