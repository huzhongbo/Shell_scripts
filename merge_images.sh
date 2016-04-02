#!/bin/bash  
#Purpose: Merge .ps files to one .ps (merge images)
#Written by Zhongbo Hu @UPC 
#Email:huzhongbocumt@gmail.com
#v1.0 19/02/2016

#############################################################
################ Please Read it before using ################
#############################################################
#1.Place the i*.ps files to the working directory
#2.Specify the working directroy
#3.Need to change the -W -C parameters by hand.

#============parameters need to know before processing =========== 
work_dir="/home/SOFTWARES/GMT/t4_merge_images"
ps=one_image.ps
W=11.5c              #Specify the width of each subfigure (the height will be calculated automatically)

#============Start processing=========== 
cd $work_dir

gmt ps2raster -A -P -D$work_dir -Te *.ps  #.ps files to .eps files

gmt psimage 1*.eps -W$W -C0/9/BL -K > $ps
gmt psimage 2*.eps -W$W -C12.5/9/BL -K -O >> $ps
gmt psimage 3*.eps -W$W -C0/0/BL -K -O >> $ps
gmt psimage 4*.eps -W$W -C12.5/0/BL -O >> $ps


