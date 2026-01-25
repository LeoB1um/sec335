#! /bin/bash
rm sweep.txt

for i in {2..50}; do 
	echo "doing $i"
	ping -c1 10.0.5.$i | grep "64" | awk '{print $4}' | tr -d ":" >> sweep.txt

done
