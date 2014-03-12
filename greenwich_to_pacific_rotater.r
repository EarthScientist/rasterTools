# to pclatlong a proper converter from the standard greenwich latlong
# this is an attempt at recreating the rotate() function in the raster 
# package to put data into pacific centered wgs 1984 latlong reference
# system commonly used in climate research

toPCLL <- function(rst){
	if(min(na.omit(coordinates(rst)[,1])) > -1 & max(na.omit(coordinates(rst)[,1])) > 182){
		print("WARNING: your raster* does not appear to be in Greenwich Centered Latlong.")
	}else{
		# convert raster to coordinates and values
		xyz <- cbind(coordinates(rst), getValues(rst))
		hi.xy <- which(xyz[,1] > 0)
		lo.xy <- which(xyz[,1] < 0 | xyz[,1] == 0)
		# make some selections
		xyz[,1][lo.xy] <- xyz[,1][lo.xy] + 360
		xyz[,1][hi.xy] <- xyz[,1][hi.xy]

		if(nlayers(rst) > 1){
			n=nlayers(rst)
			output <- stack()
			for(i in 1:n){
				output <- addLayer(output,rasterFromXYZ(cbind(xyz[,1:2],xyz[,i+2]),res=res(rst),crs=projection(rst)))
			}
			return(output)
		}else{
			output <- rasterFromXYZ(xyz[,1:3],res=res(rst),crs=projection(rst))
			return(output)
		}
	} 
}


toGMT <- function(rst){
	# convert raster to coordinates and values
	xyz <- cbind(coordinates(rst), getValues(rst))
	hi.xy <- which(xyz[,1] > 0 & xyz[,1] <= 180)
	lo.xy <- which(xyz[,1] > 180)
	# make some selections
	xyz[,1][lo.xy] <- xyz[,1][lo.xy] - 360
	xyz[,1][hi.xy] <- xyz[,1][hi.xy] 

	if(nlayers(rst) > 1){
		n=nlayers(rst)
		output <- stack()
		for(i in 1:n){
			output <- addLayer(output,rasterFromXYZ(cbind(xyz[,1:2],xyz[,i+2]),res=res(rst),crs=projection(rst)))
		}
		return(output)
	}else{
		output <- rasterFromXYZ(xyz[,1:3],res=res(rst),crs=projection(rst), digits=0)
		return(output)
	}
}

