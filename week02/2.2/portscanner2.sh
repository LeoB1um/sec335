#!/bin/bash

# Vibecoded with chatGPT and me (solo project, but definitly could be optimised)

# import colors
source ./colors.sh

# Simple TCP port scanner


timeout=0.1

# script options
use() {
	echo -e "${bc}${bold}${bgb}Usage${rst}: [-t timeout] <hostfile> <portfile>"
	echo "	-t timeout 	Set connection timeout in seconds (default = 0.1)"
	echo "	-h help		Shows this menu"
	exit 1
}


csv_escape() {
	local s="$1"
	s=${s//\"/\"\"}
	printf '"%s"' "$s"
}


#option parsing
while getopts ":t:h" opt; do
	case $opt in
		t) timeout="$OPTARG";;
			
		h) use;;
		
		\?) 
			echo -e "${bgb}${r}${bold}Error${rst}${bold}: invalid operation ${ul}-$OPTARG${rst}" >&2
		        use	
			;;
		:)
			echo -e "${bgb}${r}${bold}Error${rst}${bold}: -$optarg requires an argument" >&2
			use
			;;

	esac
done

# shifts parsed options by one when a flag is used with getopts
shift $((OPTIND - 1))


# positional argument validation
if [ $# -ne 2 ]; then
	echo -e "${bgb}${y}${bold}Error${rst}: Missing hostfile or portfile" >&2
	use
fi

# defines the order of host and portfiles
hostfile="$1"
portfile="$2"


# checks if hostfile exists and if its readable
if [ ! -f "$hostfile" ] || [ ! -r "$hostfile" ]; then
	echo -e "${bgb}${y}${bold}Error${rst}: '$hostfile' does not exist or is not readable." >&2
fi


# checks if port file exists and if its readable
if [ ! -f "$portfile" ] || [ ! -r "$portfile" ]; then
	echo -e "${bgb}${y}${bold}Error${rst}: '$portfile' does not exist or is not readable" >&2
fi


# prints header
echo "Hosts,Port,Status,Timeout,Date"


# Loop over hosts and ports
while IFS= read -r host; do
	# Skip empty lines and comments
	[[ -z "$host" || "$host" =~ ^# ]] && continue
	while IFS= read -r port; do
		[[ -z "$port" || "$port" =~ ^# ]] && continue
		
		if ! [[ "$port" =~ ^[0-9]+$ ]] || [ "$port" -lt 1 ] || [ "$port" -gt 65535 ]; then
        		status="INVALID"
    		elif timeout "$TIMEOUT" bash -c "echo >/dev/tcp/$host/$port" 2>/dev/null; then
    		    	status="OPEN"
    		else
    		    	status="CLOSED"
    		fi
		
		# Output enhanced CSV

		printf '%s,%s,%s,%s,%s\n' \
			"$(csv_escape "$host")" \
       			"$(csv_escape "$port")" \
       		       	"$status" \
       			"$timeout" \
       		       	"$(date -Is)"
	
	done < "$portfile"
	
done < "$hostfile"


