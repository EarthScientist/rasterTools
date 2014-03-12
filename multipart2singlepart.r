# this function will convert a multipolygon to single part polygons in R
multi2single <- function(polys){
	library(maptools)
	dat <- polys@data
	out <- list()
	for(i in 1:length(polys@polygons)){
		pols <- polys@polygons[[i]]@Polygons
		ID <- polys@polygons[[i]]@ID
		datLine <- dat[i,]
		out[[i]] <- mapply(function(x,y) SpatialPolygonsDataFrame(SpatialPolygons(list(Polygons(list(x), ID)), proj4string=polys@proj4string),data.frame(datLine, row.names=datLine)), x=pols, y=ID) 
	}
	out=unlist(out)
	# function to give new IDs to the polys and the data
	f=function(x,y){
		row.names(x@data)<-paste(y,sep="")
		x@polygons[[1]]@ID<-paste(y,sep="")
		return(x)
	}
	out2=mapply(f,x=out,y=1:length(out))
	spMerged<-Reduce(rbind,out2)
	return(spMerged)
}
