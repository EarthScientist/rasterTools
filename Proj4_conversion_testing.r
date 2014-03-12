# proj4 working with the cs2cs command
# trying to figure out how to make the data rotate the longitudes to pacific centered using the proj4 library

# this would be the system command to get the data projected
cs2cs +proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0 +to +proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0 +lon_wrap=180 < X:\projects\proj4_temp\coords_greenwich.txt > X:\projects\MapNik_work>X:\projects\proj4_temp\coords_cs2cs_pacific.txt

# the conversion logic
# read the newly created lonlat table into R
pacific <- read.table("/workspace/UA/malindgren/projects/proj4_temp/coords_cs2cs_pacific.txt", stringsAsFactors=FALSE)

# get the longitudes
lons <- strsplit(pacific[,1],"d")
lats <- strsplit(pacific[,2],"d")

lons.dd <- numeric()
lats.dd <- numeric()

for(i in 1:length(lons)){
	lons.deg <- as.numeric(lons[[i]][1])
	lons.min <- as.numeric(strsplit(lons[[i]][2],"'")[[1]][1])
	lons.sec <- lons[[i]][3]
	if(is.na(lons.sec) == TRUE){ lons.sec <- 0 }
	lons.dd <- append(lons.dd,((lons.sec/60 + lons.min)/60 + lons.deg), after=length(lons.dd))

	lats.deg <- as.numeric(lats[[i]][1])
	lats.min <- as.numeric(strsplit(lats[[i]][2],"'")[[1]][1])
	lats.sec <- lats[[i]][3]
	if(is.na(lats.sec) == TRUE){ lats.sec <- 0 }
	lats.dd = append(lats.dd,((lats.sec/60 + lats.min)/60 + lats.deg), after=length(lats.dd))
}