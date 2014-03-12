akima.spline.raster <- function(in_file, template_rst, out_filename, ovr){
	require(akima)
	in_file.xyz <- cbind(coordinates(in_file),getValues(in_file))
	in_file.xyz <- in_file.xyz[!is.na(in_file.xyz[,3]),]
	template_rst.xy <- coordinates(template_rst)
	splined <- interp(x=in_file.xyz[,1],y=in_file.xyz[,2],z=in_file.xyz[,3],xo=seq(min(template_rst.xy[,1]),max(template_rst.xy[,1]),l=ncol(template_rst)), yo=seq(min(template_rst.xy[,2]),max(template_rst.xy[,2]),l=nrow(template_rst)))
	interp.t <- matrix(splined$z,nrow=nrow(template_rst),ncol=ncol(template_rst),byrow=T)[nrow(template_rst):1,]
	interp.r <- raster(interp.t, xmn=xmin(template_rst), xmx=xmax(template_rst), ymn=ymin(template_rst), ymx=ymax(template_rst))
	writeRaster(interp.r, filename=out_filename, overwrite=ovr)
}


if(rst_in == TRUE) in_file.xyz <- cbind(coordinates(in_file),getValues(in_file)) else in_file.xyz <- in_file
in_file.xyz <- in_file.xyz[!is.na(in_file.xyz[,3]),]
template_rst.xy <- coordinates(template_rst)
splined <- interp(x=in_file.xyz[,1],y=in_file.xyz[,2],z=in_file.xyz[,3],xo=seq(min(template_rst.xy[,1]),max(template_rst.xy[,1]),l=ncol(template_rst)), yo=seq(min(template_rst.xy[,2]),max(template_rst.xy[,2]),l=nrow(template_rst)))
interp.t <- matrix(splined$z,nrow=nrow(template_rst),ncol=ncol(template_rst),byrow=T)[nrow(template_rst):1,]
interp.r <- raster(interp.t, xmn=xmin(template_rst), xmx=xmax(template_rst), ymn=ymin(template_rst), ymx=ymax(template_rst))
writeRaster(interp.r, filename=out_filename, overwrite=ovr)


in_file=crop(r,template_rst)
template_rst=raster('/workspace/UA/malindgren/projects/iem/PHASE2_DATA/TEM_Soils/Untitled Folder/template_akcan_1km.tif')
out_filename=paste("/workspace/UA/malindgren/projects/iem/PHASE2_DATA/TEM_Soils/August2012_SoilsMap/working/","hayes_soils_",names(hayes.select)[i],".tif",sep="")
ovr=TRUE


extent(r) <- c(-180,180,45,75)
akima.spline.raster()