# libs
import zipfile, os, sys, re, glob

#  the '*.tar.gz' files
files = glob.glob('/workspace/UA/malindgren/projects/ShippingLanes/AIS_Satellite/downloaded_data_raw/*.zip')

# loop through the files and extract the data we want.
# in this case I am looking to extract the .tif file from the archive
for i in files:
	print(i)
	dat = zipfile.ZipFile(i)
	dat.extractall(path='/workspace/UA/malindgren/projects/ShippingLanes/AIS_Satellite/downloaded_data_extracted')
	dat.close()
	# name = os.path.join(os.path.basename(dat.name).strip('zip'),os.path.basename(dat.name).strip('.zip')+'.csv')
	# member = dat.getmember(name)
	# member.name = os.path.basename(member.name)
	# dat.extract(member, path='/workspace/UA/malindgren/projects/ShippingLanes/AIS_Satellite/downloaded_data_extracted')

# import zipfile, os, sys, re, glob

# files = glob.glob('/workspace/UA/malindgren/projects/ShippingLanes/AIS_Satellite/downloaded_data_raw/*.zip')

# for i in files:
# 	print(i)
# 	z=zipfile.ZipFile(i, "r")
# 	z.extractall("/workspace/UA/malindgren/projects/ShippingLanes/AIS_Satellite/downloaded_data_extracted")
# 	z.close()

# def unzip(source_filename, dest_dir):
#     with zipfile.ZipFile(source_filename) as zf:
#         zf.extractall(dest_dir)


# for i in files:
# 	print i
# 	unzip(i, "/workspace/UA/malindgren/projects/ShippingLanes/AIS_Satellite/downloaded_data_extracted")