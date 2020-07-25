#!/bin/bash

singleurl(){
	curl -siL $1 | sed -n -E "s/.*(href|src|url)[=:]['\"]?([^'\">]+).*/\2/p" | sort -fu > tmp.txt
	while read -r uri;
		do if [[ $(echo $uri | grep '^/') ]]; then echo $1$uri; elif [[ $(echo $uri | grep '^#') ]]; then :;else echo $uri; fi;
	done < tmp.txt
	rm -rf tmp.txt
}
listurl(){
	while read -r url;
		do
			curl -siL $url | sed -n -E "s/.*(href|src|url)[=:]['\"]?([^'\">]+).*/\2/p" | sort -fu > tmp.txt
			while read -r uri;
				do if [[ $(echo $uri | grep '^/') ]]; then echo $url$uri; elif [[ $(echo $uri | grep '^#') ]]; then :;else echo $uri; fi;
			done < tmp.txt
			rm -rf tmp.txt;
	done < $1
}

if [[ -z $1 ]] || [[ -z $2 ]]; then
	echo "[Usage]: link.sh -u url"
	echo "         link.sh -ul urllist.txt"
	echo "[Warning]: URL formate should be http://target.com or https://target.com without slash in end of url"
elif [[ $1 == "-u" ]]; then
	singleurl $2
elif [[ $1 == "-ul" ]]; then
	listurl $2
fi
