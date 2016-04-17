#!/bin/bash  
#Purpose:
#Written by Zhongbo Hu @UPC 
#V1.0 21/03/2016

#############################################################
######################    README    #########################
#############################################################
#1.

#============parameters need to know before processing ===========  
  work_dir="/home/SOFTWARES/GMT/t7_draw_image_of_interest/"
  J=M6i
  R=
  Bx=xafg  
  By=yafg 
  ps=result.ps

#============Start processing ===========
#To avoid the problem of -K -O
  gmt psxy -J$J -R$R -T -K > $ps

#Draw basemap
  gmt psbasemap -J$J -R$R -B$Bx -B$By -B+t"RGB_Image" --FORMAT_GEO_MAP=ddd:mmF -Xc -Yc -K -O >> $ps


#To avoid the problem of -K -O
  gmt psxy -J$J -R$R -T -O >> $ps
