#!/bin/bash
function test3(){
	domain="$1"
	curl -sIXGET https://www.$domain/ | grep -vi content-length >> testCurlFile.txt
	dos2unix testCurlFile.txt
	param="$(cat testCurlFile.txt | grep -E "server: " | cut -d " " -f 2)"
	rm testCurlFile.txt
	searchsploit $param

}




test3 $1
