#!/bin/bash

# Written by Kalinda Pride, 2020-01-08.
# Creates a bare-bones directory listing page 
# for each of the children (non-recursive)
# of the current directory.
# For security, the directory listing 
# does not include a link to the parent (./..). 

IFS=$'\n'

function urlEncode ()
{
	# replace all the special chars 
	# with percent encodings
	# (incomplete, but covers 99% of cases)
	out=$1
	out=$(echo ${out//%/%25}) # do percent first
	out=$(echo ${out// /%20})
	out=$(echo ${out//\!/%21})
	out=$(echo ${out//\#/%23})
	out=$(echo ${out//\$/%24})
	out=$(echo ${out//\&/%26})
	out=$(echo ${out//\'/%27})
	out=$(echo ${out//\(/%28})
	out=$(echo ${out//\)/%29})
	out=$(echo ${out//+/%2B})
	echo $out
}

for rawDir in $(ls -1F | grep /)
do
	dir=${rawDir%$"/"} # remove trailing slash
	echo "dir=$dir"
	
	htmlFile=$dir/index.html
	echo "<!DOCTYPE html>" > $htmlFile
	echo "<html>" >> $htmlFile
	echo "<head><title>$dir</title></head>" >> $htmlFile
	echo "<body>" >> $htmlFile

	for filename in $(ls -1 $dir)
	do
		if [ $filename != "index.html" ]
		then
			echo "<p><a href=$(urlEncode $filename)>$filename</a></p>" >> $htmlFile
		fi
	done

	echo "</body>" >> $htmlFile
	echo "</html>" >> $htmlFile
done

