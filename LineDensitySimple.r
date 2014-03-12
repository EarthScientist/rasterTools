# simple line density procedure
library(raster)
library(rgeos)
library(sp)
library(maptools)
library(dismo)

aoi.raster<-raster('/workspace/UA/malindgren/projects/ShippingLanes/ancillary/aoi_ShippingLanes_FINAL.tif')
lns <- shapefile('/workspace/UA/malindgren/projects/ShippingLanes/OUTPUTS/MAY_2013/Lines/REDDOG_2011_2012_Lines.shp')


# info from the user
outRST.template
radius=
spatlines

# create the output raster 
# r <- raster(extent(spatlines), res=cellsize, crs=spatlines@proj4string)
values(aoi.raster) <- 1

centroids <- coordinates(aoi.raster)

# create a polygon grid
r.pts <- rasterToPolygons(aoi.raster)

# get the centroids of each polygon in the grid
centroids <- gCentroid(r.pts,byid=TRUE)

outputDist <- gWithinDistance(spgeom1, spgeom2=NULL, radius, byid=FALSE, hausdorff=FALSE, densifyFrac=NULL)

system.time(apply(centroids@coords, 1,function(x,y) spDistsN1(y, x, longlat = TRUE),y=centroids@coords))
system.time(lapply(centroids@coords, function(x,y) spDistsN1(y, x, longlat = TRUE),y=centroids@coords))

f <- function(x){

}

# this is how we calculate the area of the circle
# this is calculated in the units of the radius 
circle.area <- pi*(2*radius)




require(raster)
#function to make a circular weights matrix of given radius and resolution
#NB radius must me an even multiple of res!
make_circ_filter<-function(radius, res){
  circ_filter<-matrix(NA, nrow=1+(2*radius/res), ncol=1+(2*radius/res))
  dimnames(circ_filter)[[1]]<-seq(-radius, radius, by=res)
  dimnames(circ_filter)[[2]]<-seq(-radius, radius, by=res)
  sweeper<-function(mat){
    for(row in 1:nrow(mat)){
      for(col in 1:ncol(mat)){
        dist<-sqrt((as.numeric(dimnames(mat)[[1]])[row])^2 +
          (as.numeric(dimnames(mat)[[1]])[col])^2)
        if(dist<=radius) {mat[row, col]<-1}
      }
    }
    return(mat)
  }
out<-sweeper(circ_filter)
return(out)
}




#make a  circular filter with 120m radius, and 40m resolution
cf<-make_circ_filter(120, 40)
 
#test it on the meuse grid data
f <- system.file("external/test.grd", package="raster")
r <- raster(f)
 
r_filt<-focal(r, w=cf, fun=mean, na.rm=T)
 
plot(r, main="Raw data") #original data
plot(r_filt, main="Circular moving window filter, 120m radius") #filtered data




# create the buffer object 
buf=gBuffer(hayes.alb[seq(1,nrow(hayes.alb@data),20),],width=0.1)

# now we need to use this little bugger to do some analyses with lapply
lapply(buf@polygons[[1]]@Polygons, function(x) polygon(x@coords))



lapply(buf@polygons[[1]], function(x) polygon)
lapply(buf@polygons[[1]], function(x) polygons)
lapply(buf@polygons[[1]], function(x) SpatialPolygons)
lapply(buf@polygons[[1]], function(x) SpatialPolygon)
lapply(buf@polygons[[1]], function(x) SpatialPolygon(x))
class(buf@polygons[[1]])
SpatialPolygons(buf@polygons[[1]])
?Polygons
SpatialPolygons(slot(buf@polygons[[1]],"coords"))
buf@polygons
buf@polygons[[1]]@coords
buf@polygons[[1]]@coord
buf@polygons[[1]]@Polygons@coords\
buf@polygons[[1]]@Polygons@coord
buf@polygons[[1]]@Polygons@coords
slot(buf@polygons[[1]]@Polygons,"coords)"
)
slot(buf@polygons[[1]]@Polygons,"coords")
lapply(buf@polygons[[1]]@Polygons, slot(x,"coords"))
lapply(buf@polygons[[1]]@Polygons, function(x) slot(x,"coords"))

hold=lapply(buf@polygons[[1]]@Polygons, function(x) Polygons(Polygon(slot(x,"coords"))))

SpatialPolygons(coords=hold)

lapply(hold, function(x) Polygon(x))


hold=lapply(buf@polygons[[1]]@Polygons, function(x) Polygon(x))


aoi.raster<-raster('/workspace/UA/malindgren/projects/ShippingLanes/ancillary/aoi_ShippingLanes_FINAL.tif')
lns <- shapefile('/workspace/UA/malindgren/projects/ShippingLanes/OUTPUTS/MAY_2013/Lines/REDDOG_2011_2012_Lines.shp')

buf <- gBuffer(coordinates(aoi.raster), width=10000, quadsegs=10, byid=TRUE)

# class(buf@polygons)

poly=mclapply(buf@polygons[[1]]@Polygons, function(x,y) Polygon(slot(x,"coords")), mc.cores=16)
polys=mapply(function(x,y) Polygons(list(x),y), x=poly, y=1:length(poly))
spat.polys=SpatialPolygons(polys)

polys=mcmapply(function(x,y) Polygons(list(x),y), x=poly, y=1:length(poly), mc.cores=16)


f <- function(x,y,z){
  gInt=gIntersection(SpatialPolygons(list(x),proj4string=CRS('+init=epsg:3338')),y)
  gLen=gLength(gInt, byid=F)
  gLen/z
}
circle_area = spat.polys@polygons[[1]]@area
out=mclapply(spat.polys[1,]@polygons, FUN=f, y=lns, z=circle_area, mc.cores=16)

out=mclapply(spat@polygons, FUN=f, y=lns, z=circle_area, mc.cores=16)


lapply(coordinates(aoi.raster), f2, y=lns,)

f2 <- function(aoi.raster,lns,width,){
  buf <- gBuffer(coordinates(aoi.raster))

  # Buffer Point

}



lapply(polys, function(x) SpatialPolygons(Polygons(list(x),ID=1)))


# DENSITY MAP SHAVER
path='/workspace/UA/malindgren/projects/ShippingLanes/OUTPUTS/MAY_2013/Density/Shaved_densities/'
den <- raster('/workspace/UA/malindgren/projects/ShippingLanes/OUTPUTS/MAY_2013/Density/ArcMap/REDDOG_2011_2012_Lines_10g.tif')
shave <- function(x,path){
  breaks=hist(getValues(den), na.rm=TRUE)$breaks
  for(b in 1:length(breaks)){
    print(breaks[b])
    den[which(values(den) < breaks[b])] <- 0
    writeRaster(den, filename=paste(path,"den_output_cut_",b,"_",breaks[b],".tif",sep=""), options="COMPRESS=LZW")
  }

  deciles <- quantile(x, prob = seq(0, 1, 0.1))
}

# version 2
path='/workspace/UA/malindgren/projects/ShippingLanes/OUTPUTS/MAY_2013/Density/Shaved_densities/'
den <- raster('/workspace/UA/malindgren/projects/ShippingLanes/OUTPUTS/MAY_2013/Density/ArcMap/REDDOG_2011_2012_Lines_10g.tif')
v <- getValues(den)
# den2=den
# values(den2)<-(v-mean(v))/sd(v)
# values(den2)<-(v-min(v))/diff(range(v))*100
# v <- values(den2)
breaks <- seq(min(v), max(v), 0.0001)
# breaks <- seq(min(v), max(v), 10)
for(b in 1:length(breaks)){
  den2=den
  print(breaks[b])
  den2[which(v <= breaks[b])] <- 0
  den2[which(is.na(values(den2)) == TRUE)] <- 0
  writeRaster(den2, filename=paste(path,"den_output_cut_v6_",b,"_",gsub(".","_",breaks[b], fixed=TRUE),".tif",sep=""), options="COMPRESS=LZW", overwrite=T)
}

# (v-min(v))/diff(range(v))*100


for(i in unique(den.cut10)){
  values(den.cut10)[which(values(den.cut10) < i)] <- 0
  writeRaster(den.cut10, filename=paste(path,"den_output_cut10_v4_",i,".tif",sep=""))}



############################~FINAL SOLUTIONS SHAVE DENSITY~###########################################################################
# here is the final code for the decile solution 
path='/workspace/UA/malindgren/projects/ShippingLanes/OUTPUTS/MAY_2013/Density/Shaved_densities3/'

# list the files that you want to run the density stuff on
inlines <- c('/workspace/UA/malindgren/projects/ShippingLanes/OUTPUTS/MAY_2013/Density/ArcMap3/NORTH SEA_2011_2012_10g_v2.tif','/workspace/UA/malindgren/projects/ShippingLanes/OUTPUTS/MAY_2013/Density/ArcMap3/NW PASSAGE_2011_2012_Lines_10g_v2.tif','/workspace/UA/malindgren/projects/ShippingLanes/OUTPUTS/MAY_2013/Density/ArcMap3/REDDOG_2011_2012_Lines_10g_v2.tif')

for(j in 1:length(inlines)){
  # read in the density raster
  den = raster(inlines[j])
  
  # get the values from the raster
  v <- getValues(den)
  # select the ones that are greater than zero
  v <- v[which(v > 0)]

  # get deciles from the data 
  deciles <- quantile(v, prob = seq(0, 1, 0.1))

  # loop through and iteratively remove the decile cutoff from density and write out the result
  for(i in 1:length(deciles)){
    den2=den
    v=getValues(den2)
    print(deciles[i])
    den2[which(v < deciles[i])] <- 0
    den2[which(is.na(values(den2)) == TRUE)] <- 0
    base=basename(inlines[j])
    base=substring(base,1,nchar(base)-4)
    base=gsub(" ","_",base)
    writeRaster(den2, filename=paste(path,"den_output_cut_deciles_",base,"_",i,"_",gsub(".","_",deciles[i], fixed=TRUE),".tif",sep=""), options="COMPRESS=LZW", overwrite=T)
  } 
}

###########################################             SOLUTION         ####################################################################

# here is the final code for the single straight line in radius solution'
path='/workspace/UA/malindgren/projects/ShippingLanes/OUTPUTS/MAY_2013/Density/Shaved_densities4/'

# list the files that you want to run the density stuff on
inlines <- c('/workspace/UA/malindgren/projects/ShippingLanes/OUTPUTS/MAY_2013/Density/ArcMap3/NORTH SEA_2011_2012_10g_v2.tif','/workspace/UA/malindgren/projects/ShippingLanes/OUTPUTS/MAY_2013/Density/ArcMap3/NW PASSAGE_2011_2012_Lines_10g_v2.tif','/workspace/UA/malindgren/projects/ShippingLanes/OUTPUTS/MAY_2013/Density/ArcMap3/REDDOG_2011_2012_Lines_10g_v2.tif')

for(j in 1:length(inlines)){
  # read in the density raster
  den = raster(inlines[j])

  # the search radius for the line density
  radius = 10000

  # this is the minimum density value that is possible for a single line cutting straight through the center of the circle
  minVal = (radius*2)/(pi*(radius^2))

  # get the values from den
  v <- getValues(den)
  v <- v[which(v > 0)]

  cutList=seq(min(v), max(v), minVal)

  # loop through and iteratively remove the decile cutoff from density and write out the result
  for(i in 1:30){
    den2=den
    v=getValues(den2)
    print(cutList[i])
    den2[which(v < cutList[i])] <- 0
    den2[which(is.na(values(den2)) == TRUE)] <- 0
    base=basename(inlines[j])
    base=substring(base,1,nchar(base)-4)
    base=gsub(" ","_",base)
    writeRaster(den2, filename=paste(path,"den_output_cut_minVal_",base,"_",i,"_",gsub(".","_",cutList[i], fixed=TRUE),".tif",sep=""), options="COMPRESS=LZW", overwrite=T)
  }
}


# substring(1,nchar(basename('/workspace/UA/malindgren/projects/ShippingLanes/OUTPUTS/MAY_2013/Density/ArcMap/NORTH SEA_2011_2012_10g_v2.tif')-4),basename('/workspace/UA/malindgren/projects/ShippingLanes/OUTPUTS/MAY_2013/Density/ArcMap/NORTH SEA_2011_2012_10g_v2.tif'),)

# out <- mclapply(l, function(x,y) extend(raster(x),y), y=tmp2, mc.cores=detectCores()-1)

# NS2 <- resample(extend(raster(l2[3]),RE.final),RE.final,'ngb')

# writeRaster(NS2, filename=paste("/workspace/UA/malindgren/projects/ShippingLanes/OUTPUTS/MAY_2013/Density/test_expand/",names(NS2),"_fullExtent.tif",sep=""),options="COMPRESS=LZW")

# writeRaster(RE.final, filename=paste("/workspace/UA/malindgren/projects/ShippingLanes/OUTPUTS/MAY_2013/Density/test_expand/",names(RE.final),"_fullExtent.tif",sep=""),options="COMPRESS=LZW")

# get rid of all vals outside of the herd range




