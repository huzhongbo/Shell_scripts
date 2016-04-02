#command1
echo $(pwd)

#command2
if [ 1 -eq 2 ] 
	then

 #comment multiples lines

fi

#command3
for file_name in $work_dir/*.dat; do

	temp_file=`basename $file_name`
	file_name_short=${temp_file%.*}    #Get the file name without the suffix
	ps=${file_name_short}.ps

	processing

done