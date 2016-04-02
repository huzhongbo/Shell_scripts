#!/bin/bash  
#Purpose: draw research area by using GMT from landsat data
#written by Zhongbo Hu @UPC 
#v1.0 21/03/2016

#############################################################
##########################README#############################
#############################################################
#1.Use Envi to prepare the stretched .TIF data (2.tif,3.tif,4.tif)

#============parameters need to know before processing ===========  
  work_dir="/home/SOFTWARES/GMT/t7_draw_image_of_interest/"
  J=M6i
  lon_w=1.62
  lon_e=2.6
  lat_s=41.12
  lat_n=41.72
  R=$lon_w/$lon_e/$lat_s/$lat_n
  R_B=-25/25/20/50 
  #Bx=xa1f0.5
  #By=ya1f0.5
  Bx=xafg  
  By=yafg 
  ps=RGB_Image.ps

#Calculate central location for drawing big area map
  lon_c=$(echo "scale=4; ($lon_w+$lon_e)/2"|bc)
  lat_c=$(echo "scale=4; ($lat_s+$lat_n)/2"|bc)

#============Start processing ===========
#To avoid the problem of -K -O
  gmt psxy -J$J -R$R -T -K > $ps

#Draw basemap
  gmt psbasemap -J$J -R$R -B$Bx -B$By -B+t"RGB_Image" --FORMAT_GEO_MAP=ddd:mmF -Xc -Yc -K -O >> $ps

#Translate to NetCDF files from .tif files
  gdal_translate -of GMT 2.tif 2.nc
  gdal_translate -of GMT 3.tif 3.nc
  gdal_translate -of GMT 4.tif 4.nc

#Draw RGB image
  gmt grdimage 4.nc 3.nc 2.nc -R$R -J$J -K -O >> $ps

#Draw the North direction symbol 
  gmt psbasemap -R$R -J$J -TdjRT+o0/0.5i+w0.7i+f2+l" , , ,N" -Ft+gwhite+c0/0/0/0.5i+p0p,black -K -O >> $ps

#Draw big area map (method 1: JG projection). Only draw global area, I cannot find solution
#  gmt pscoast -Rg -JG$lon_c/$lat_c/1.5i -Bag -Df -A5000 -Gwhite -Sblue -K -O  >> $ps
#  echo $lon_c $lat_c | gmt psxy -Rg -JG$lon_c/$lat_c/1.5i -Sc3p -Gred -K -O >> $ps

#Draw big area map (method 2: JM projection). It can draw a specific big area
  gmt pscoast -R$R_B -JM1.5i -B0 -Df -N1 -A5000 -Gwhite -Sblue --MAP_FRAME_TYPE=plain -K -O >> $ps
  gmt psbasemap -R$R_B -JM1.5i -D$R -Fd+gred -K -O >> $ps

#To avoid the problem of -K -O
  gmt psxy -J$J -R$R -T -O >> $ps

rm -f gmt.*  *.xml *.nc 
