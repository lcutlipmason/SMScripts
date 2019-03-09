#!/bin/bash

function convert {
	for i in $1; do
		echo "$i"
		git clone --mirror "$i" "$(cut -d'.' -f1 <<<"$i")".git
	done
}

for f in *; do
	echo "$f"
	convert $f
done
