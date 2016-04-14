#!/bin/sh
for dir in /home/eefsarnas1/dades/processades/zhongbo_tenerife_ascending/02_int_dir/*
do
basename $dir
ls $dir -l|wc -l
done
