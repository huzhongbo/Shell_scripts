#!/bin/bash  
#Purpose: plot interferograms from phase files
#written by Zhongbo Hu @UPC 
#v1.0 15/02/2016

#============parameters need to know before processing ===========  
ori_dir="/home/InSAR_Results/11Canillo_SPOT_ST/temp_int_data/"  
target_dir="/home/InSAR_Results/11Canillo_SPOT_ST/interferograms/"    
var=/phase_dif_mlook_3x3.dat  #the same suffix of each data
var1=/phase_dif_mlook_3x3
multilook=3x3
R=0/999/0/1332               #Specify range (Format:samples(1000)/lines(1333))

#============Start processing ===========
for file_a in ${ori_dir}/*; do  

    temp_file=`basename $file_a`        #e.g:20101118.tsx1.20101129.tsx1
    temp_file_name1=${temp_file:0:8}    #e.g:20101118
    temp_file_name2=${temp_file:14:8}   #e.g:20101129
    file_name_result=${temp_file_name1}_${temp_file_name2}_${multilook} #e.g:20101118_20101129_3x3
    file_name_data=${file_a}${var}      #get full path of data. e.g:/home/SOFTWARES/GMT/t2_draw_interferograms/temp_int_data/20101118.tsx1.20101129.tsx1/phase_dif_mlook_3x3.dat
    file_name_final=${file_a}/${file_name_result}         #e.g:/home/SOFTWARES/GMT/t2_draw_interferograms/temp_int_data/20101118.tsx1.20101129.tsx1/20101118_20101129_3x3
    
# Translate binary data to grd by using xyz2grd
#-R means range(samples1000,lines1333)
#-I stands for interval
#-D specification of xname/yname/zname
#-ZTL means Z data starts from top-lift
#-Xc -Yc locate the figure in the center
    gmt xyz2grd $file_name_data -G$file_name_final.nc -Dsamples/lines/phases -R$R -I1 -V -ZTLf

#Generate .CPT file from grd data
    gmt makecpt -T-3.1416/3.1416/0.1 -Z > $file_a/new.cpt

#Mapping interferogram from grd data
    gmt grdimage -R$file_name_final.nc -JX15c/15c -Xc -Yc -C$file_a/new.cpt -B200 -B+t"Interferogram" $file_name_final.nc -K > $file_name_final.ps

#Imaging color scale
     gmt psscale -Dx17c/0.5c+e+w8c/0.5c -C$file_a/new.cpt -B0.5 -P -O >> $file_name_final.ps

    rm -f $file_name_final.nc $file_a/new.cpt 

done

#============Copy all interferograms .ps files to one specific target directory (if need)===========
   cp $ori_dir/*/*.ps $target_dir
