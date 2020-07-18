#!/bin/bash

if [[ -z $1 ]]; then
	echo "./nmap.sh DOMAIN"
else
	nmap --script dns-brute $1 -oX $1 > /dev/null
	cat $1 | grep $1 | cut -d '<' -f2 | cut -d '>' -f2 | grep . | sort -u
	rm -rf $1
fi