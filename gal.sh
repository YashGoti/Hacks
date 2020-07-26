#!/bin/bash

banner(){
	echo -e "\t                __\t"
	echo -e "\t   ____  ____  / /\t"
	echo -e "\t  / __ \/ __ \/ / \t"
	echo -e "\t / /_/ / /_/ / /_ \t"
	echo -e "\t \__, /\__,_/___/ \t"
	echo -e "\t/____/            \t"
}

curl -siL $1 | grep -Eoi '<(a|link) [^>]+>' | grep -Eo 'href="[^\"]+"' | cut -d '=' -f2 | cut -d '"' -f2 | grep -v '#$' | grep -v '/$' | sort -u >> tmp.txt &
curl -siL $1 | grep -Eoi '<script [^>]+>' | grep -Eoi 'src="[^\"]+"' | cut -d '=' -f2 | cut -d '"' -f2 | sort -u >> tmp.txt &
curl -siL $1 | sed -n -E "s/.*(href|src|url|path)[=:]['\"]?([^'\">]+).*/\2/p" | grep -v '#$' | grep -v '/$' | sort -u >> tmp.txt &
curl -siL $1 | grep -Po '(?<=href=")[^"]*(?=")' | grep -v '#$' | grep -v '/$' | sort -u >> tmp.txt &
curl -siL $1 | grep -Eoi '(http|https)://[^ >]+' | cut -d '"' -f1 | sort -u >> tmp.txt &
curl -siL $1 | grep -Po '(?<=src=")[^"]*(?=")' | grep -v '#$' | grep -v '/$' | sort -u &
curl -siL $1 | grep -Eo "(http|https)://[a-zA-Z0-9./?=_%:-]*" | sort -u >> tmp.txt
cat tmp.txt | grep $1 | sort -u
