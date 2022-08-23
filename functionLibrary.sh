#!/bin/bash 

#Function for each module of the tool
binPath=/usr/bin/


#whois - takes a domain and returns any name servers
whoIsFunc(){
        domain=$1
        whoIsOutput="$("${binPath}whois" $domain)"
        nameServers="$(echo "$whoIsOutput" | "${binPath}grep" -E "Name Server: [a-z]")"
	echo "[*] Executing WhoIs Command..."
        echo "======================= Summary of whois for $domain ======================="
        echo "$whoIsOutput"       
}

#robots.txt & security.txt - needs to be passed a domain
txtFileChecks(){
        urlPrepend="https://"
        domainToOpen=$1

        #robots.txt
        urlAppend="/robots.txt"
        completeUrl=$domainToOpen$urlAppend
	echo "[*] Retrieving response from robots.txt of chosen domain..."
	echo "[*] Retrieving response from security.txt of chosen domain..."
        echo "====================== Summary of robots.txt for "$domainToOpen" ===================="
        "${binPath}wget" -q $completeUrl
        "${binPath}cat" robots.txt
        echo " "
        echo " "
        "${binPath}rm" robots.*
        #security.txt
        urlAppend2="/security.txt"
        completeUrl2=$domainToOpen$urlAppend2
        echo "==================== Summary of security.txt for "$domainToOpen" ===================="
        "${binPath}wget" -q $completeUrl2
        "${binPath}cat" security.txt
        "${binPath}rm" security.*
}

#DNS enumeration
#Commands to use - dig, host, nslookup
dnsCheck(){
        #run dig command with a parameter of a chosen domain
	echo "[*] Executing Dig command on target..."
	echo "[*] Executing Host command on target..."
	echo "[*] Executing NSLookUp command on target..."
        echo "======================= Summary of Dig for "$1" ======================="
        "${binPath}dig" $1
        ipAddr="$("${binPath}dig" $1 | ${binPath}"grep" -Eo "[0-9]{1,3}[.][0-9]{1,3}[.][0-9]{1,3}[.][0-9]{1,3}$")"

        #grep output of dig, looking for an ip addrr. Pass that to host command
        echo " "
        echo "==================== Summary of Host for "$ipAddr" ===================="
        "${binPath}host" $ipAddr

        #name server enumeration - duplicate code atm, need to refine
        nameServers="$("${binPath}whois" $1 | "${binPath}grep" -E "Name Server: [a-z]")"
        dnsNameServersArray=($nameServers)
        echo " "
        echo " "
        echo "=================== Summary for nsLookup of Name Servers ==================="
        for ns in "${!dnsNameServersArray[@]}"; do
                if [[ $(($ns % 3 )) == "2" ]];then
                        echo "======================== Summary for "${dnsNameServersArray[ns]}" ========================"
                        "${binPath}nslookup" "${dnsNameServersArray[ns]}"
                fi
        done

}

#seperate function nslookup for dns enumeration
nsLookupFunc(){
        nameServersArray=($@)
        for ns in "${!nameServersArray[@]}";do
                if [[ $(($ns % 3 )) == "2" ]]; then
                        echo "========== Summary for "${nameServersArray[ns]}" =========="

                        nslookup "${nameServersArray[ns]}"
                fi
        done
        echo "============================================="
}


#google maps
googleMaps(){
        urlPrepend="https://google.com/maps/place/"
        placeToOpen=""
        argArray=($1)
        for var in "${!argArray[@]}"; do
        	if [[ $placeToOpen == "" ]]; then
                     	placeToOpen=${argArray[var]}
           	else
         		placeToOpen=$placeToOpen+${argArray[var]}
                     	shift
             	fi
        done
        urlAppend="/"
        completeUrl=$urlPrepend$placeToOpen$urlAppend
	#echo $completeUrl
	echo "[*] Opening target address in user's preferred brower..."
        "${binPath}xdg-open" $completeUrl
}

#facebook/social media
#scrapped until version 2 of tool in progress


#metadata extraction
metadataExtraction(){
arrayFiles=("$@")
for file in "${!arrayFiles[@]}"; do 
        if [ -f "${arrayFiles[file]}" ];
        then
		echo "[*] Performing metadata extraction on "${arrayFiles[file]}"..."
                file_name="${arrayFiles[file]}"
                file_ext="$(echo "$file_name" | "${binPath}grep" -Eo "[.][a-z]+")"
                echo "============================== Metadata Extraction for "$file_name" =============================="
               	echo "File Extension: "$file_ext""
		echo "File Name & Description:" "$(${binPath}"file" $file_name)"
                echo " "
                echo "SHA512 Hash:" "$("${binPath}sha512sum"  $file_name)"
                echo " "
                echo "Would you like to display the file in hex format(h) or binary format(b) (h/b)"
                read input 
                
                if [[ $input == "h" || $input == "H" ]]; 
                then
                echo "Would you like the full version of the hexdump? if not the head of hexdump will be outputted (Y/N)"
                read input
                if [[ $input == "y" || $input == "Y" ]];
                then
						echo "$(${binPath}"xxd" $file_name)"
						echo " "
				else
						echo "$(${binPath}"xxd" $file_name | ${binPath}"head")"
						echo " "
					fi
                elif [[ $input == "b" || $input == "B" ]];
                then
                echo "Would you like the full version of the binary output? if not the head of the binary will be outputted (Y/N)"
                read input
                if [[ $input == "y" || $input == "Y" ]]; 
                then
						echo "$(${binPath}"xxd" -b $file_name)"
						echo " "
				else
						echo "$(${binPath}"xxd" -b $file_name | ${binPath}"head")"
						echo " "
				fi
            fi  

                if [ $file_ext == ".png" ] || [ $file_ext == ".jpg" ] || [ $file_ext == ".jpeg" ] || [ $file_ext == ".gif" ] || [ $file_ext == ".tiff" ] || [ $file_ext == ".psd" ];
                then
                        exif $file_name
                        echo " "
                        shift
                else
                        echo "[!] File not compatible for EXIF data extraction - Accepted extensions are \".png\" \".jpg\" \".gif\" \".tiff\" \".psd\""
                        echo " "
                        shift
                fi
        else
                echo "[!] Warning: Only files are compatible with this module!"
        fi
done;
}


#shodan
shodanFunc(){
        mainUrl="https://www.shodan.io/search?query="
        searchParams=""
        for var in "$@"; do
                if [[ $searchParams == "" ]];
                then
                        searchParams=$var
                else
                        searchParams=$searchParams+$var
                        shift
                fi
        done
        completeUrl=$mainUrl$searchParams
	echo "[*] Opening target URL in user's preferred browser..."
        xdg-open $completeUrl
}



#banner grabbing
bannerGrab(){
        searchParam=$1
	echo "[*] Executing wget HTTP banner request..."
	echo "[*] Executing curl HTTP banner request..."
        echo "==================== Summary of wget for "$searchParam" ===================="
        echo " "
        "${binPath}wget" -q -S "$searchParam"
        #"${binPath}rm" index.*
        echo " "
        echo "==================== Summary of curl for "$searchParam" ===================="
        echo " "
        "${binPath}curl" -s -I "$searchParam"
        ${binPath}curl -sIXGET https://$searchParam/ | ${binPath}grep -vi content-length > testCurlFile.txt
	  ${binPath}dos2unix testCurlFile.txt
	  param="$(${binPath}cat testCurlFile.txt | ${binPath}grep -E "[Ss]erver: " | ${binPath}cut -d " " -f 2)"
	  ${binPath}rm testCurlFile.txt
          if [[ $param != "" ]]; 
          then
                echo "Would you like to check for potential exploits for sever and systems? (Y/N)"
                read input
                if [[ $input == "Y" || $input == "y" ]]; 
                        then
                searchSploitFunc $param
                        elif [[ $input == "N" || $input == "n" ]]; 
                        then
                        :     
                fi
                else
                echo "[!] No server found"
        fi
}

usernameGenerator(){
	firstName="$1"
	lastName="$2"
	domain="$3"
	firstLetterOfFirstName="$(echo $firstName | /usr/bin/cut -c1)"
	firstLetterOfLastName="$(echo $lastName | /usr/bin/cut -c1)"
	
	#if [[ $# -eq 2 ]]; then 
	#        echo "[*] Generating a list of usernames..."
	#        echo ""
	#elif [[ $# -eq  3 ]]; then
        #        echo "[*] Generating a list of usernames..."
	#        echo "[*] Generating a list of email addresses..."
	#        echo ""
	#fi 

        echo "[*] Generating a list of usernames..."
        echo "[*] Generating a list of email addresses..."
	echo ""
	if [[ $# -eq 2 || $# -eq 3 ]]; then 
	        echo "============================== Usernames ============================="
	        echo "First potential username: $firstName.$lastName"
	        echo "Second potential username: $firstName$lastName"
                echo "Third potential username: $firstLetterOfFirstName$lastName"
                echo "Fourth potential username: $firstLetterOfFirstName.$lastName"
                echo "Fifth potential username: $firstName$firstLetterOfLastName"
                echo "Sixth potential username: $firstName.$firstLetterOfLastName"
                echo "Seventh potential username: $firstName"_"$lastName"
                echo "Eighth potential username: $firstName"_"$firstLetterOfLastName"
                echo "Nineth potential username: $firstLetterOfFirstName"_"$lastName"
                echo "Tenth potential username: $firstName-$lastName"
                echo "Eleventh potential username: $firstName-$firstLetterOfLastName"
                echo "Twelth potential username: $firstLetterOfFirstName-$lastName"	
                echo ""
	fi
	
	if [[ $# -eq 3 ]]; then
                echo "=========================== Email Addresses =========================="
                echo "First potential email: $firstName.$lastName@$domain"
                echo "Second potential email: $firstName$lastName@$domain"
                echo "Third potential email: $firstLetterOfFirstName$lastName@$domain"
                echo "Fourth potential email: $firstLetterOfFirstName.$lastName@$domain"
                echo "Fifth potential email: $firstName$firstLetterOfLastName@$domain"
                echo "Sixth potential email: $firstName.$firstLetterOfLastName@$domain"
                echo "Seventh potential email: $firstName"_"$lastName@$domain"
                echo "Eighth potential email: $firstName"_"$firstLetterOfLastName@$domain"
                echo "Nineth potential email: $firstLetterOfFirstName"_"$lastName@$domain"
                echo "Tenth potential email: $firstName-$lastName@$domain"
                echo "Eleventh potential email: $firstName-$firstLetterOfLastName@$domain"
                echo "Twelth potential email: $firstLetterOfFirstName-$lastName@$domain"	
                echo ""
	fi
        echo ""
	echo "Would you like to cross refrence the possible usernames with live social media accounts (Y/N)"
        read input 
	if [[ $input == "Y" || $input == "y" ]]; then 
	        userNames=( "$firstName.$lastName" "$firstName$lastName" "$firstLetterOfFirstName$lastName" 
		"$firstLetterOfFirstName.$lastName" "$firstName$firstLetterOfLastName" 
		"$firstName.$firstLetterOfLastName" "$firstName_$lastName" "$firstName_$firstLetterOfLastName" 
		"$firstLetterOfFirstName_$lastName""$firstName-$lastName" "$firstName-$firstLetterOfLastName" 
		"$firstLetterOfFirstName-$lastName" )
		for i in "${userNames[@]}"; do	
				socialMediaCheck $i
		done
	else 
		:
	fi
}

gobusterFunc(){
	gobusterMode=$1
	target=$2
	wordlist=$3

	echo "[*] Executing gobuster"
	echo "[*] Enumarating data for $target"
	echo "===================Extracted Gobuster Infomation For $target==================="
	if [[ $gobusterMode == "dir" ]]; then 
		"${binPath}gobuster" dir -u "http://www.$target" -w $wordlist --wildcard
	elif [[ $gobusterMode == "dns" ]]; then 
		"${binPath}gobuster" dns -d $target -w $wordlist  
	elif [[ $gobusterMode == "vhost" ]]; then 
		"${binPath}gobuster" vhost -u "https://$target" -w $wordlist
	elif [[ $gobusterMode == "fuzz" ]]; then :
		"${binPath}gobuster" fuzz -u "$target/FUZZ" -w $wordlist 
	fi
}

socialMediaCheck(){
        username=$1

        echo "[!]This may take few minutes dependning on that amount of results found"
        echo "[*] Finding results for $1"
        echo "======================= Possible Accounts For $1 ======================="
        sherlock $1

        }

        searchSploitFunc(){
        serverName=$1
        echo "[*] Excuting searchsploit"
        echo "[*] Enumarting possible exploits for $serverName"
        echo "[!] Searchsploit results for $serverName"
        "${binPath}searchsploit" $serverName
}

#usernameGenerator $1 $2 $3
