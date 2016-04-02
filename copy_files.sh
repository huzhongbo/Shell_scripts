#!/bin/sh  
#============ copy selected data files from different directories to specific directories===========  
ori_dir="/home/eefsarnas1/dades/processades/zhongbo_CANILLO/02_int_dir"  
target_dir="/home/usuaris/ars/zhongbo.hu/temp_int_data/"
var=/phase_dif_mlook_3x3.dat  #the same suffix of each data

#copy data from original directories to target directories
for file_a in ${ori_dir}/*; do  
    temp_file=`basename $file_a`  #referenc:https://zh.wikipedia.org/wiki/Basename
    mkdir ${target_dir}${temp_file} #make directories to save cp files
    file_name=${file_a}${var}    #get full path of data
    cp -a $file_name ${target_dir}${temp_file} #copy data to each directory
  # echo $file_name 
done
