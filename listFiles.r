# list the files in a directory with the asinine naming convention
# besure to have the ending "/" in the path 
# const_prefix needs an ending "_"
# extension needs to have a leading "."
# this is currently implemented only for monthly data 

listem <- function(path,const_prefix,beginYear,endYear,extension){
	l <- character()
	months <- c("01","02","03","04","05","06","07","08","09","10","11","12")
	for(y in beginYear:endYear){
		for(m in months){
			l <- append(l,paste(path,const_prefix,m,"_",y,extension,sep=""),after=length(l))
		}
	}
	return(l)
}

