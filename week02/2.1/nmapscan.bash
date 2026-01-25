#! /bin/bash
number=1
rm sweep3.txt

for i in {2..50}; do 
	echo "doing $number"
	number=$(($number+1))

	ip="10.0.5.$i"

	nmapsuccess=$(nmap -n -vv -sn "$ip" | grep "Host is up") 
       	
	if [ ! -z "$nmapsuccess" ]; then
		echo "$ip" >> sweep3.txt
	fi
done
