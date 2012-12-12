# data downscaling function
# -------------------------------------
# inputs: (all inputs must have the same extent/resolution/reference system/origin, and be monthly timeseries data, and must be rasterStack objects)
# in.clim.hires = input climatology period timeseries that is at the desired output resolution
# in.clim.lores = input climatology period timeseries that is at the original low resolution *if a subset of the input ts then use subset command to select what you want*
# in.fullSeries.lores = input full low resolution timeseries that is to be downscaled 
# const_prefix = this is the output prefix that stays constant in the output naming scheme
# beginYear = the year at the beginning of the timeseries
# endYear = the year at the end of the timeseries
# -------------------------------------

downscale <- function(in.clim.hires, in.clim.lores, in.fullSeries.lores, absolute){
	require(akima)
	in.clim.hires.v <- getValues(in.clim.hires)
	in.clim.lores.v <- getValues(in.clim.lores)
	in_xyz <- cbind(coordinates(in.clim.lores),getValues(in.fullSeries.lores))
	in_xyz <- na.omit(in_xyz)
	z_in <- in_xyz[,2:ncol(in_xyz)]
	out_xy <- coordinates(in.clim.hires)
	
	anomStack.lores <- in.fullSeries.lores
	#in.fullSeries.lores <- matrix(NA,ncol=ncol(z_in),nrow=nrow(in_xyz))
	# calc lores anomalies
	for(j in 1:12){
		monList <- seq(j,(ncol(in_xyz)-2),12)
		if(absolute == TRUE){
			in_xyz[,monList] <- in_xyz[,(monList+2)] - in.clim.lores.v[,j]
		}else{
			in_xyz[,monList] <- in_xyz[,(monList+2)] / in.clim.lores.v[,j]
		}
	}
	outStack <- brick(subset(in.clim.hires,1,T), nl=nlayers(in.clim.lores))
	interp.mat <- matrix(NA, nrow=nrow(out_xy), ncol=ncol(z_in))
	for(k in 1:ncol(z_in)){
		anom.spline	<- interp(x=in_xyz[,1],y=in_xyz[,2],z=z_in[,k],xo=seq(min(out_xy[,1]),max(out_xy[,1]),l=ncol(in.clim.hires)), yo=seq(min(out_xy[,2]),max(out_xy[,2]),l=nrow(in.clim.hires),linear=F))
		mat.anom <- matrix(anom.spline$z,nrow=nrow(in.clim.hires),ncol=ncol(in.clim.hires),byrow=T)[nrow(in.clim.hires):1,]
		interp.mat[,k] <- as.vector(t(mat.anom))
	}
	rm(in_xyz)
	#downscaled.mat <- matrix(NA, nrow=nrow(interp.mat), ncol=ncol(interp.mat))
	for(i in 1:12){
		monList <- seq(i,(ncol(in_xyz)-2),12)
		if(absolute==TRUE){
			interp.mat[,monList] <- interp.mat[,monList] + in.clim.hires.v[,j]
		}else{
			interp.mat[,monList] <- interp.mat[,monList] * in.clim.hires.v[,j]
		}
	}
	outStack <- setValues(outStack,interp.mat)
	return(outStack)
}
