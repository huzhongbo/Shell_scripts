#!/bin/bash

work_dir="/home/user/Desktop/12/"

cd ${work_dir}

for file_a in $(pwd)/*
do
    file_name_before=`basename $file_a`
    file_name_after=${file_name_before:0:3}
     mv ${file_name_before} ${file_name_after}.mp3
done
