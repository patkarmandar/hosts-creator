#!/bin/bash

LOCAL_HOST="0.0.0.0"
OUTPUT_HOST="hosts.txt"

pattern=(
	"0.0.0.0"
	"broadcasthost"
	"ip6-allhosts"
	"ip6-allnodes"
	"ip6-allrouters"
	"ip6-localhost"
	"ip6-localnet"
	"ip6-loopback"
	"ip6-mcastprefix"
	"localhost"
)

main(){
	# Fetch Hosts From Sources :
	printf " > Fetching Hosts List \n"

	while read src; do
		if [ -z "$src" ]; then
			continue
		fi
		printf "   - $src\n"
		curl -s "$src" | grep -v "^#" | tr '[:blank:]' ' ' | cut -d " " -f 2 >> "temp/prehosts.temp"
	done < "source.list"

	# For Domain Style Sources :
	if [ -s source.domain ]; then
		while read src; do
			if [ -z "$src" ]; then
				continue
			fi
			printf "   - $src\n"
			curl -s "$src" | grep -v "^#" >> "temp/prehosts.temp"
		done < "source.domain"
	fi


	# Cresting Hosts :
	printf " > Cresting Hosts \n"

	if [ -f temp/prehosts.temp ]; then
		# Removing Unwanted Localhosts, Adrresses :
		for line in "${pattern[@]}"; do
			sed -i "/$line/d" "temp/prehosts.temp"
		done

		# Sort And Nuke Duplicates :
		sort "temp/prehosts.temp" | tr -d '\r' | sed -e 's/^[[:blank:]]*//' -e 's/[[:blank:]]*$//' | uniq > "temp/hosts.temp"
	fi

	if [ -f temp/hosts.temp ]; then
		# Prepend Local Hosts :
		sed -e "s/^/${LOCAL_HOST} /" "temp/hosts.temp" > "$OUTPUT_HOST"
	fi

	if [ -f hosts.txt ]; then
		printf " > Hosts List Created : hosts.txt \n"
	else
		printf " > Hosts Creation Failed! \n"
	fi
}

# Main :
if [ ! -s source.list ]; then
	printf " > \"source.list\" is empty \n"
	printf " > Hosts Creation Failed! \n"
	exit -1
else
	rm -rf temp hosts.txt
	mkdir temp
fi

main
rm -rf temp
