hosts=$1
dns=$2

#dns="10.0.5.20"


#if [[ -f "$1" ]]; then
	
	echo "DNS resolution for 10.0.5.0/24"

	#while IFS= read -r line; do

		for i in {0..255}; do
		       	line="$1.$i" 
	

		result=$(nslookup $line $dns)

		if [[ "$result" == *"**"* ]]; then
			continue
		fi

		#echo "$line"
		echo "$result"
		#echo ' '
	done
	#done < "$1"

#else
#	echo "Error: File '$1' not found"	

#fi
