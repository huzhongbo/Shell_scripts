#!/bin/bash  
#Purpose: Merge .ps files to one .ps (merge images) Automatically
#Written by Zhongbo Hu @UPC 
#Email:huzhongbocumt@gmail.com
#v1.0 19/02/2016

#############################################################
################ Please Read it before using ################
#############################################################
#1.*.ps files should be prepared and put them in the work_dir
#2.Parameters xnum,ynum,x_width_inter,y_width_inter have to be specified

#============parameters need to know before processing =========== 
#work_dir="/home/InSAR_Results/04large_area_multi_mountain/situation1"
work_dir="/home/InSAR_Results/10Linear_DEM_Top_Turb_small/estimate_12"
ps=one_image.ps   #The name of the output ps file
J=X29.7c/21c      #No need to specify this
R=0/20/0/14       #No need to specify this
xnum=4
ynum=3
x_width_inter=30  #x interval between subimages.(percentage)
y_width_inter=50  #y interval between subimages.(percentage)

#============Start processing=========== 
#if [ 1 -eq 2 ] 
#	then

cd $work_dir
rm -f $ps

x_width=$(echo "scale=4; ((297*$x_width_inter)/(($x_width_inter+1)*$xnum+5))/10"|bc)
y_width=$(echo "scale=4; ((210*$y_width_inter)/(($y_width_inter+1)*$ynum+3))/10"|bc)

yi=-1

index=0
for file_a in ${work_dir}/*.ps
do 
((index+=1))

gmt psconvert ${file_a} -A -P -Te -F$index   #.ps files to .eps files
done

#To avoid the problem of -K -O
gmt psxy -J$J -R$R -T -K > $ps 

for i in $(seq $(($xnum*$ynum)))
do

xi=$(echo "($i-1)%($xnum)"|bc)

if [ $xi -eq 0 ]

	then ((yi+=1))

fi

X_coordi=$(echo "scale=4; (3*$x_width/$x_width_inter+$xi*$x_width+$xi*($x_width/$x_width_inter))-2.5"|bc)
Y_coordi=$(echo "scale=4; (21-2*$y_width/$y_width_inter-$yi*$y_width-$yi*($y_width/$y_width_inter))-2.5"|bc)

#gmt psimage $i.eps -W$x_width/$y_width -C$X_coordi/$Y_coordi/TL -K -O >> $ps
gmt psimage $i.eps -Dx$X_coordi/$Y_coordi+jTL+w$x_width/$y_width -K -O >> $ps

done

#To avoid the problem of -K -O
gmt psxy -J$J -R$R -T -O >> $ps 

rm -f *.eps gmt.*

#fi
