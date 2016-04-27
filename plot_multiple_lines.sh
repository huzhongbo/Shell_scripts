#!/bin/bash  
#Purpose: plot line or lines with different symbols and colors
#Written by Zhongbo Hu @UPC 
#Email:huzhongbocumt@gmail.com
#v1.0 17/02/2016

#############################################################
################ Please Read it before using ################
#############################################################
#1.Data file should have the specific format(i*.dat). e.g:1coeff_d.dat
#  .........................................(i*.txt). e.g:1linear.txt
#2. These data have n lines and 2 columns
#3.In this case, four lines with different colors and symbols are drown. If the number of line is different,  it is nessary to change the "array_color" and "array_symbol" parameters according to the number of lines(data)
#4. The parameters ps,J,R,Bx,By would be different in another case. Change it according to specific needs
#5. Specific "work_dir" firstly, in which there are data files.
#6. Set the switch keyword to specify the data format (important)

#============parameters need to know before processing =========== 
work_dir="/home/InSAR_Results/06With_turbulent_APS/turbulent_situation"
ps=plot_lines.ps
J=X18c/13c
R=0/136/-0.12/0.12
Bx=xafg  #automatically devide and lable the x axis
By=yafg  #automatically devide and lable the y axis
switch=2 #set this value equal 1 if the data is binary format
         #set this value equal 2 if the data is ascii format


#array_color=(green red blue black) #colors for different lines
#array_symbol=(c a t x)   #symbols for points (c:circle, a:star, t:triangle x:cross)

array_color=(green red) #colors for different lines
array_symbol=(c a)

#============Start processing =========== 
cd $work_dir

#To avoid the problem of -K -O
gmt psxy -J$J -R$R -T -K > $ps   

#Generate the basemap
gmt psbasemap -R$R -J$J -B$Bx -B$By -Xc -Yc \
         -Bx+l"Index of Interferograms" -By+l"D_Coefficient Values"\
         -BnWSe+t"Comparison between estimate and real values" -K -O >> $ps

for i in $(seq ${#array_color[*]}) #${#array_color[*]}
do

#For Binary data
if [ $switch -eq 1 ]
then
   #Plot the line and symbol of i data
   gmt psxy $i*.dat -bi2f -R$R -J$J -W0.6p,${array_color[i-1]},solid -K -O >> $ps
   gmt psxy $i*.dat -bi2f -R$R -J$J -S${array_symbol[i-1]}0.1c -K -O >> $ps
fi
#For ASCII data
if [ $switch -eq 2 ]
then
   #Plot the line and symbol of i data
   gmt psxy $i*.txt -R$R -J$J -W0.6p,${array_color[i-1]},solid -K -O >> $ps
   gmt psxy $i*.txt -R$R -J$J -S${array_symbol[i-1]}0.1c -K -O >> $ps
fi

done

#gmt pstext text.d -R$R1 -J$J -F+fgreen -K -O >> $ps


#Plot the line and symbol of first data (one specific example of the loop processing)
#gmt psxy 1coeff_d.dat -bi2f -R$R -J$J -W0.6p,green,solid -K -O >> $ps
#gmt psxy 1coeff_d.dat -bi2f -R$R -J$J -Sc0.1c -K -O >> $ps


#To avoid the problem of -K -O
gmt psxy -J$J -R$R -T -O >> $ps 

rm -f gmt.*
