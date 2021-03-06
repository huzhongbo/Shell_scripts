#!/bin/bash  
#Purpose: plot line or lines with different symbols and colors
#Written by Zhongbo Hu @UPC 
#Email:huzhongbocumt@gmail.com
#v1.0 17/02/2016

#############################################################
################ Please Read it before using ################
#############################################################
#1.Data file should have the specific format(i*.dat). e.g:1coeff_d.dat
#2.Files used for plotting is Binary format data. In the case these files generated by IDL
#  These data have n lines and 2 columns
#3.In this case, four lines with different colors and symbols are drown. If the number of line is different, 
#  it is nessary to change the "array_color" and "array_symbol" parameters according to the number of lines(data)
#4.The parameters ps,J,R,Bx,By would be different in another case. Change it according to specific needs
#5.Specific "work_dir" firstly, in which there are data files.

#============parameters need to know before processing =========== 
work_dir="/home/InSAR_Results/08Linear_DEM_Top_Turb/"
ps=plot_fault.ps
#J=X20c/14c
J=X18c/13c
#R=0/136/-0.012/0.01
R=0/730/-30/52
#R1=0/20/0/14  #To display pscontext
#Bx=afg  #automatically devide and lable the x axis
#By=afg  #automatically devide and lable the y axis

#============Start processing =========== 
cd $work_dir

#To avoid the problem of -K -O
gmt psxy -J$J -R$R -T -K > $ps   

#Generate the basemap
#gmt psbasemap -R$R -J$J -B$Bx -B$By -Xc -Yc \
 #        -Bx+l"Index of PS pixels" -By+l"DEM Error Values"\
  #       -BnWSe+t"Comparison between estimate and real values" -K -O >> $ps


#To avoid the problem of -K -O
gmt psxy -J$J -R$R -T -O >> $ps 

rm -f gmt.*
