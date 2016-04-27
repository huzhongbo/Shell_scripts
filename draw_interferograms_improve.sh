#!/bin/bash  
#Purpose: plot interferograms from phase files
#written by Zhongbo Hu @UPC 
#v1.0 15/02/2016


#############################################################
######################    README    #########################
#############################################################
#1. Data to be used to draw interferograms. It is Ok whatever the file names are. The figure name is the same with the data file for each interferogram
#2. In the same folder of the data, the *.txt(with temporal and spatial baselineinformation, the first column is the temporal information and the second column is the spatial information) file should be included.
#3. Set work_dir
#4. Set R paramater

#============parameters need to know before processing ===========  
work_dir="/home/user/InSAR_Results/12Canillo_SPOT/phase_ori/"
J=X18c/18c
R=0/1336/0/1732              #Specify range (Format:samples(1337)/lines(1733))
Bx=xafg
By=yafg

#============Start processing ===========
cd $work_dir

Tbaseline=($(awk '{printf("%.0f\n"), $1}' *.txt))
Sbaseline=($(awk '{printf("%.1f\n"), $2}' *.txt))

index=0

for file_name in ${work_dir}/*.dat; do  

    temp_file=`basename $file_name`        
    file_name_short=${temp_file%.*}
    ps=${file_name_short}.ps
    
    #To avoid the problem of -K -O
    gmt psxy -J$J -R$R -T -K > $ps

    gmt psbasemap -R$R -J$J -B$Bx -B$By -Xc -Yc \
    -Bx+l"Samples" -By+l"Lines"\
    -BnWSe+t"${file_name_short}/B=${Sbaseline[$index]}/T=${Tbaseline[$index]}" -K -O >> $ps
     ((index+=1))

# Translate binary data to grd by using xyz2grd
#-R means range(samples1000,lines1333)
#-I stands for interval
#-D specification of xname/yname/zname
#-ZTL means Z data starts from top-lift
#-Xc -Yc locate the figure in the center
    gmt xyz2grd ${file_name_short}.dat -G${file_name_short}.nc -Dsamples/lines/phases -R$R -I1 -V -ZTLf

#Generate .CPT file from grd data
    gmt makecpt -T-3.1416/3.1416/0.1 -Z > new.cpt

#Mapping interferogram from grd data
    gmt grdimage ${file_name_short}.nc -J$J -R$R -Cnew.cpt -K -O >> $ps

#Imaging color scale
     gmt psscale -Dx18.5c/0.5c+e+w12c/0.8c -Cnew.cpt -B0.5 -P -K -O >> $ps

#To avoid the problem of -K -O
    gmt psxy -J$J -R$R -T -O >>$ps

    rm -f ${file_name_short}.nc new.cpt 

done
    rm -f gmt.history
