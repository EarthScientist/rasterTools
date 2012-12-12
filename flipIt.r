rotate <- function(x, ...) {
		e <- extent(x)
		xrange <- e@xmax - e@xmin
		if (xrange < 350 | xrange > 370 | e@xmin < -10 | e@xmax > 370) {
			warning('this does not look like an appropriate object for this function')
		}
		hx <- e@xmin + xrange / 2
		r1 <- crop(x, extent(e@xmin, hx, e@ymin, e@ymax))
		r2 <- crop(x, extent(hx, e@xmax, e@ymin, e@ymax))
		r2@extent@xmin <- r2@extent@xmin - xrange
		r2@extent@xmax <- r2@extent@xmax - xrange
		ln <- names(x)
		x <- merge(r1, r2, overlap=FALSE, ...)
		names(x) <- ln
		return(x)
	}
)


flipIt <- function(x, ...) {
	xyz = cbind(coordinates(x), getValues(x))
	if(any(xyz[,1] < 0))  xyz[xyz[,1]<0,1] <- xyz[xyz[,1]<0,1]+360
	out <- rasterFromXYZ(xyz, res=res(x), digits=0)
	return(out)
}


