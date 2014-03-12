# libs
import tarfile, os, sys, re, glob
list
#  the '*.tar.gz' files
files = glob.glob('/Data/Base_Data/GIS/GIS_Data/Raster/Land_Cover/Canada_EOSD_Land_Cover/bc/*.tar.gz')

# loop through the files and extract the data we want.
# in this case I am looking to extract the .tif file from the archive
for i in files:
	print(i)
	dat = tarfile.open(i)
	name = os.path.join(os.path.basename(dat.name).strip('tar.gz'),os.path.basename(dat.name).strip('tar.gz')+'.tif')
	member = dat.getmember(name)
	member.name = os.path.basename(member.name)
	dat.extract(member, path='/Data/Base_Data/GIS/GIS_Data/Raster/Land_Cover/Canada_EOSD_Land_Cover/bc/TIFs')

