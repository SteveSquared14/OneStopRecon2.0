#!/bin/bash

function test(){
	domain="$1"

	echo "value of domain is $domain"

	#testParam="$(curl -v --silent -s -I "$domain" 2>&1 | grep -E "^Server: ")"
	testParam="$(curl -sIXGET sky.com | grep -E "Server: ")"

	testArrayParam=($testParam)
	#value=Apache
	#test2 $value

	for server in "${!testArrayParam[@]}"; do
		echo "value is "${testArrayParam[server]}""
		echo $server

		if [[ "$server" == 1 ]]; then
			echo "index value is $server"
			echo "value at index is ${testArrayParam[server]}"
			
			paramToSearch="${testArrayParam[server]}"
			echo "paramToSearch is $paramToSearch"

			if [[ "$paramToSearch" == Apache ]]; then
				echo "match"
				searchsploit Apache
			fi
			#test2 ${testArrayParam[server]}
		fi
	done	
}



function test2(){

	echo "in test2()"
	echo "$1"
	searchsploit $1

}


function test3(){
	domain="$1"
	curl -sIXGET https://www.$domain/ | grep -vi content-length >> testCurlFile.txt
	dos2unix testCurlFile.txt
	param="$(cat testCurlFile.txt | grep -E "server: " | cut -d " " -f 2)"
	rm testCurlFile.txt
	searchsploit $param

}




test3 $1
