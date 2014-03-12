bbox2polygon = function(obj) {
# This function converts a bounding box of a spatial object to a SpatialPolygons-object
# obj :  Spatial object
  bb = bbox(obj)
  pl = Polygon(data.frame(rbind(c(bb["s1","min"], bb["s2","max"]),
                                c(bb["s1","max"], bb["s2","max"]),
                                c(bb["s1","max"], bb["s2","min"]),
                                c(bb["s1","min"], bb["s2","min"]),
                                c(bb["s1","min"], bb["s2","max"])
                            )))
  pls = Polygons(list(pl), ID = "bbox")
  spat_poly = SpatialPolygons(list(pls), proj4string = CRS(proj4string(obj)))
  return(spat_poly)
}fa