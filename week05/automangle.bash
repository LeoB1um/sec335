linecount=$(wc $1 | awk '{print $1}')


echo "$linecount"
for ((i=2; i <= linecount; i+=5)); do
	
	if (( end > linecount )); then
		end=$linecount

	fi

	sed -n "${i},$((i+4))p" "$1" > input.txt

	rsmangler -m 9 -x 12 -f input.txt >> $2.mangledlist.txt

done
#	sed -n "${i},$((i+4))p" $1 >> mangledout/$2.wordlist$i.txt
#	((i+=5))
#done

