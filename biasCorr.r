# This function is built for bias correction
# inputs are: 
# brick/stack historical, brick/stack future, begin Index of historical clim period, end index of historical clim period, absolute=TRUE/FALSE *depending on if it is proportional or absolute anom*
# TESTING
biasCorr <- function(in.historical, in.future, climBegin.historical, climEnd.historical, climBegin.future, climEnd.future, absolute){
	hist.sub <- subset(in.historical, climBegin.historical:climEnd.historical, drop=T)
	hist.clim <- stack()
	for(i in 1:nlayers(hist.sub)){
		monthList <- seq(i, nlayers(hist.sub), 12)
		mon.sub <- mean(subset(hist.sub,monthList), drop=T)
		hist.clim <- addLayer(hist.clim, mon.sub)
	}
	fut.sub <- subset(in.future,climBegin.future:climEnd.future, drop=T)
	fut.clim <- stack()
	for(i in 1:nlayers(fut.sub)){
		monthList <- seq(i, nlayers(fut.sub), 12)
		mon.sub <- mean(subset(fut.sub,monthList), drop=T)
		fut.clim <- addLayer(fut.clim, mon.sub)
	}
	future.biasCorr <- in.future
	in.future.v <- getValues(in.future)
	hist.clim.v <- getValues(hist.clim)
	fut.clim.v <- getValues(fut.clim)
	for(j in 1:12){
		monList <- seq(j,ncol(in.historical.v),12)
		if(absolute == TRUE){
			in.future.v[,monList] <- in.future.v[,monList] - fut.clim.v[,j]
			in.future.v[,monList] <- in.future.v[,monList] + hist.clim.v[,j]
		}else{
			in.future.v[,monList] <- in.future.v[,monList] / fut.clim.v[,j]
			in.future.v[,monList] <- in.future.v[,monList] * hist.clim.v[,j]
		}
	}
	future.biasCorr <- setValues(future.biasCorr, in.future.v)
	return(future.biasCorr)
}

