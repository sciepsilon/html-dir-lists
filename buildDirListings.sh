#!/bin/bash

# Written by Kalinda Pride, 2020-01-08.

# Creates a bare-bones directory listing page 
# for each of the children (non-recursive)
# of the current directory.
# To avoid unintentionally exposing filepaths, 
# the directory listing does not include a link to the parent. 
# This script is idempotent. 
# The result of running this script is similar to the 
# result of adding "Options +Indexes" to the .htaccess file. 

IFS=$'\n'

# It would normally be better to use the urlencode package,
# but sometimes it's infeasible to install additional packages.
function urlEncode ()
{
	# replace all the special chars with percent encodings
	# (incomplete, but covers 99% of cases
	# for filenames that originated on Windows)
	out=$1
	out=$(echo ${out//%/%25}) # do percent first, to prevent recursive encoding
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

# This ls command lists the contents of the current directory, 
# one per line, with directory names followed by "/".
# Then we filter for directories only.
for rawDir in $(ls -1F | grep /) 
do
	dir=${rawDir%$"/"} # remove trailing slash
	echo "dir=$dir"
	
	# Initially, use > to replace all previous content of index.html.
	# Then use >> to append additional lines.
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

