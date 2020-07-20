#!/bin/bash

help(){
	echo -e "[Usage]:"
	echo -e "\t-ip Discover Host IP in Network Range"
	echo -e "[Example]:"
	echo -e "\t~/<NmapHostDiscover.sh> 0.0.0.0/24 [IP-Range] -ip"
}

discoverHostIPs(){
	nmap -sn --min-rate 25000 $1 -oX $(pwd)/nmap.temp.xml > /dev/null
	cat $(pwd)/nmap.temp.xml | grep "addr=" | cut -d "=" -f2 | cut -d " " -f1 | cut -d '"' -f2 | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | sort -t . -k 3,3n -k 4,4n
	rm -rf $(pwd)/nmap.temp.xml
}

if [[ -z $1 ]]; then
	help
else
	if [[ $2 == "-ip" ]];then
		discoverHostIPs $1
	else
		help
	fi
fi
