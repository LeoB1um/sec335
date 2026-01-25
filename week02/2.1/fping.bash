#! /bin/bash

for i in sweep.txt; do 
	echo "doing"
       	sudo fping -a -e -f $i	

done
