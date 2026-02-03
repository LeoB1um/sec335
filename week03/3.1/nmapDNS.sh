for i in {0..255}; do 
	nmap=$(nmap -Pn -n -T5 10.0.5.$i -p 53)
	
	open=$(echo "$nmap" | grep open)

	if [[ -n "$open" ]]; then
		echo "10.0.5.$i" > dns-servers2.txt
	fi

done
