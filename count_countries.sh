#!/bin/bash
# Author: Oros
# 2017/04/27
# License : The Unlicense
#
# Setup :
# sudo apt install geoip-bin

usage(){
	echo "Missing parameters"
	echo "$0 <INPUT_LOG_FILE> <OUPUT_DIR>"
	echo "Exemple:"
	echo "$0 /var/log/apache2/access.log.1 ./out_exemple.net/"
}

if [ "$#" == "2" ]; then
	if [ ! -f "$1" ]; then
		echo "$1 is not a file!"
		usage
		exit 1
	fi
	if [ ! -d "$2" ]; then
		echo "$2 is not a directory!"
		usage
		exit 1
	fi
	ip_list=$(awk '{print $1}' $1 | sort -n | uniq)
	cd $2
	if [ ! -f "ipv4.csv" ]; then
		touch "ipv4.csv"
	fi
	if [ ! -f "countries.csv" ]; then
		touch "countries.csv"
	fi
	for i in $ip_list; do
		if [ "$(echo $i|grep '\.')" != "" ]; then
			# only IPv4 could be locate :-/
			if [ "$(grep $i ipv4.csv)" == "" ]; then
				echo $i >> ipv4.csv # $i="220.181.51.92"
				country=$(geoiplookup $i) # country="GeoIP Country Edition: CN, China"
				country=${country#*: } # country="CN, China"
				country_count=$(grep "$country" countries.csv) # country_count="1,CN, China"
				if [ "$country_count" != "" ]; then
					count=$((${country_count%%,*} + 1)) # count=2
					new_country_count="$count,$country" # new_country_count="2,CN, China"
					sed -i "s#$country_count#$new_country_count#" countries.csv
				else
					echo "1,$country" >> countries.csv
				fi
			fi
		fi
	done
	countries_file=$(cat countries.csv | sort -n -r) # sort DESC
	echo "$countries_file" > countries.csv
else
	usage
fi