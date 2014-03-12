# calcAnom
# this is a function that will calculate the anomalies from a rasterBrick/Stack
# inputs are a RasterStack or RasterBrick, SubsetBegin month1/year1 of Climatology period, subsetEnd month12/year1+30 of Climatology period, and absolute=TRUE or absolute=FALSE

calcAnom <- function(brickStack, subsetBegin, subsetEnd, absolute) {
	d.begin <- date()
	require(raster)
	b<-brickStack
	b.v <- getValues(b)
	b.sub <- subset(b,subsetBegin:subsetEnd)
	clim <- stack()
	for(i in 1:12){
		if(nchar(i)<2) { mon <- paste("0",i,sep="")} else{ mon <- mon }
		monList <- seq(i,nlayers(b.sub),12)
		monMean <- mean(subset(b.sub,monList))
		clim <- addLayer(clim,monMean)
	}
	clim.v <- getValues(clim)
	anomStack <- b
	for(j in 1:12){
		print(j)
		monList <- seq(j,ncol(b.v),12)
		if(absolute == TRUE){
			b.v[,monList] <- b.v[,monList] - clim.v[,j]
		}else{
			b.v[,monList] <- b.v[,monList] / clim.v[,j]
		}	
		anomStack <- setValues(anomStack,b.v)
	}
	return(anomStack)
	d.end <- date()
	print(paste("time diff: ",d.begin - d.end, sep=""))
}

