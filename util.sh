#!/bin/bash

PATH="$(pwd)"
. "$PATH"/functionLibrary.sh 

#Reading Files

function whoisUtil(){
whoisDataInput=$1
echo $whoisDataInput 
fileExt="$(echo  "$whoisDataInput" | /usr/bin/grep -Eo ".txt")"
#echo "file ext is $fileExt"

if [ $# -eq 1 ]; then
	if [ "$fileExt" == ".txt" ];
	then 
		echo "[!] Data extracted from $whoisDataInput"
		while read -r line;
		do
   		whoIsFunc "$line"
		done < "${whoisDataInput}"
	else    
		whoIsFunc "$whoisDataInput"
	fi
elif [ $# -gt 1 ]; then	
	outputFileName=$2
	if [ "$fileExt" == ".txt" ];
	then
		echo "[!] Data extracted from $whoisDataInput"
		while read -r line;
		do
			if [[ -f $outputFileName ]]; then 
					whoIsFunc "$line" >> "$outputFileName"
					#echo "File Exists"
			else
		   			touch $outputFileName
					#echo "New File Made"
					whoIsFunc "$line" > "$outputFileName"
			fi
					done < "${whoisDataInput}" 
			
			echo "[!]Your file has been outputted to $outputFileName"
	else 
		echo "Incompatible read file used"
	fi
fi
}

function usernameUtil(){
	fileExt="$(echo "$1" | /usr/bin/grep -Eo ".txt")"

	if [ "$#" -eq 3 ]; then
		#read from terminal, output to terminal
		usernameGenerator "$1" "$2" "$3"
	elif [ "$#" -eq 4 ]; then
		#read from terminal, output to file
		usernameGenerator "$1" "$2" "$3" >> "$4"
		echo "[*] Your file has been outputted to $4"
	fi


}


function dnsUtil(){
dnsDataInput=$1
fileExt="$(echo "$dnsDataInput" | /usr/bin/grep -Eo ".txt")"

if [ $# -eq 1 ]; then 
	if [ "$file_ext" == ".txt" ];
	then
		echo "[!] Data extracted from $dnsDataInput"
		while read -r line;
		do 
    		dnsCheck "$line"
		done < "${dnsDataInput}"
	else
		dnsCheck "$dnsDataInput"
	fi
elif [ $# -gt 1 ]; then
	outputFileName=$2
	if [ "$file_ext" == ".txt" ];
	then 
		echo "[!] Data extracted from $dnsDataInput"
		while read -r line;
		do
			if [[ -f $outputFileName ]]; then 
					dnsCheck "$line" >> "$outputFileName" 
					#echo "File Exists"
			else
		   			touch $outputFileName
					#echo "New File Made"
					dnsCheck "$dnsDataInput" > "$outputFileName"
			fi
					
			done < "${dnsDataInput}"
		echo "[!] Your file has been outputted to $outputFileName"
	else
		echo "[!] Incompatible read file used"
	fi
fi
}

function txtFileUtil(){
txtFileDataInput=$1
fileExt="$(echo "$txtFileDataInput" | /usr/bin/grep -Eo ".txt")"

if [ $# -eq 1 ]; then 
	if [ "$file_ext" == ".txt" ];
	then 
	   	echo "[!] Data extracted from $txtFileDataInput"
		while read -r line 
		do 
    		txtFileChecks "$line"
		done < "${txtFileDataInput}"
	else
		txtFileChecks "$txtFileDataInput"
	fi
elif [ $# -gt 1 ]; then 
	outputFileName=$2
	if [ "$file_ext" == ".txt" ];
	then 
		echo "[!] Data extracted from $txtFileDataInput"
		while read -r line;
		do
			if [[ -f $outputFileName ]]; then 
					txtFileChecks "$line" >> "$outputFileName" 
					#echo "File Exists"
			else
		   			touch $outputFileName
					#echo "New File Made"
					txtFileChecks "$txtFileDataInput" > "$outputFileName"
			fi
	   done < "${txtFileDataInput}"
	else
			echo "[!] Incompatible read file used"
	fi
fi
}

#function metadataUtil(){
#if [ "$#" -gt 1 ]; then
#	fileName=($1)
#	outputFilename=$2
#	for file in "${!fileArray[@]}"; do
#		echo "[*] Analysing ""${fileArray[file]}""..."
#		metadataExtraction "${fileArray[file]}"
#		echo "[*] Analysis of ""${fileArray[file]}"" complete..."
#	done
#fi
#	   echo "[!]Analysing $fileName"
#          metadataExtraction $fileName >> $outputFileName
#          echo "[!]Analysing Complete" 	    
#}


function bannerGrabbingUtil(){
bannerGrabbingInput=$1
fileExt="$(echo "$bannerGrabbingInput" | /usr/bin/grep -Eo ".txt" )"
if [ $# -eq 1 ]; then 
	if [ "$file_ext" ];
	then 
		echo "[!] Data extracted from $bannerGrabbingInput" 
		while read -r line
		do	
		bannerGrab "$line" 
        	done < "${bannerGrabbingInput}"
	else 
		bannerGrab "$bannerGrabbingInput"
	fi
elif [ $# -gt 1 ]; then 
	outputFileName=$2
	if [ "$file_ext" == ".txt" ];
	then 
		echo "[!] Data extracted from $bannerGrabbingInput"
		while read -r line
		do
			if [[ -f $outputFileName ]]; then 
						bannerGrab "$line" >> "$outputFileName"
						#echo "File Exists"
				else
						touch $outputFileName
						#echo "New File Made"
						bannerGrab "$bannerGrabbingInput" > "$outputFileName"
				fi
		done < "${bannerGrabbingInput}"
	       	echo "Your file has been outputted to $outputFileName"	
else 
				echo "[!] Incompatible read file used"
    fi
fi
}

function socialMediaUtil(){
socialMediaInput=$1
fileExt="$(echo "$socialMediaInput" | /usr/bin/grep -Eo ".txt" )"
	if [ "$fileExt" == ".txt" ];
	then 
		echo "[!] Data extracted from $whoisDataInput"
		while read -r line;
		do
			socialMediaCheck "$line"
		done < "${whoisDataInput}"
	else
		echo "[!] Incompatible read file used"
	fi
}

function gobusterUtil(){
mode="$1"
target="$2"
wordList="$3"
fileToSaveTo="$4"

if [ "$#" -eq 3 ]; then
	gobusterFunc "$mode" "$target" "$wordList"
elif [ "$#" -eq 4 ]; then
	gobusterFunc "$mode" "$target" "$wordList" >> "$fileToSaveTo"
else
	echo "[!] Unexpected error occured. Please try again"
	echo "For help, enter \"--help\""
fi
}

fileCheckUtil(){
	fileName=$1
	
	if [[ -f $fileName ]]; then 
		   >> $fileName
		   #echo "File Exists"
	else
		   touch $fileName
		   #echo "New File Made"
		   >> $fileName
    fi
	}

#whoisUtil $1 $2
