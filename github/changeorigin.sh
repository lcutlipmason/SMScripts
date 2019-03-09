#!/bin/bash
ORG=ORGNAME
ORIGIN=NAMEOFORIGINTOCHANGE

function convert {
	for i in $1; do
	    
		echo "$i"
		git -C "$f" remote remove $ORIGIN 
		git -C "$f" remote add $ORIGIN git@github.com:$ORG/$(basename "${i%.*}").git
	done
}

for f in *; do
    if [ -d "$f" ];then
	echo "$f"
	convert $f
    fi
done
