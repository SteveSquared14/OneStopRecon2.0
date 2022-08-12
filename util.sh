#!/bin/bash

PATH="$(pwd)"
. $PATH/functionLibrary.sh 

#Reading Files

function whoisUtil(){
whoisDataInput=$1
file_ext="$(echo  "$whoisDataInput" | /usr/bin/grep -Eo ".txt")"
#echo "file ext is $file_ext"

if [ $# -eq 1 ]; then

	if [ $file_ext ];
	then 
		echo "[!] Data extracted from $whoisDataInput"
		while read line;
		do
   		whoIsFunc $line
		done < ${whoisDataInput}
	else    
		whoIsFunc $whoisDataInput
	fi
elif [ $# -gt 1 ]; then	
	outputFileName=$2
	if [ $file_ext  ]; 
	then
		echo "[!] Data extracted from $whoisDataInput"
		while read line;
		do
		whoIsFunc $line >> $outputFileName
		done < ${whoisDataInput} 
		echo "[!]Your file has been outputted to $outputFileName"
	else
		whoIsFunc $whoisDataInput >> $outputFileName 
		echo "Your file has been outputted to $outputFileName"
	fi
fi
}

usernameUtil(){
	file_ext="$(echo "$1" | /usr/bin/grep -Eo ".txt")"

	if [ $# -eq 1 ]; then
		#reading from file, output to terminal
		#tbc once file format confirmed
		echo "Placeholder"
	elif [ "$#" -eq 2 ]; then
		#reading from file, outputting to file
		#tbc once file format confirmed
		echo "Placeholder 2"
	elif [ "$#" -eq 3 ]; then
		#read from terminal, output to terminal
		usernameGenerator $1 $2 $3
	elif [ "$#" -eq 4 ]; then
		#read from terminal, output to file
		usernameGenerator $1 $2 $3 >> $4
		echo "[*] Your file has been outputted to $4"
	fi


}


function dnsUtil(){
dnsDataInput=$1
file_ext="$(echo "$dnsDataInput" | /usr/bin/grep -Eo ".txt")"

if [ $# -eq 1 ]; then 
	if [ $file_ext ];
	then
		echo "[!] Data extracted from $dnsDataInput"
		while read line;
		do 
    		dnsCheck $line
		done < ${dnsDataInput}
	else
		dnsCheck $dnsDataInput
	fi
elif [ $# -gt 1 ]; then
	outputFileName=$2
	if [ $file_ext ];
	then 
		echo "[!] Data extracted from $dnsDataInput"
		while read line;
		do
		dnsCheck $line >> $outputFileName 
		done < ${dnsDataInput}
		echo "[!]Your file has been outputted to $outputFileName"
	else
		dnsCheck $dnsDataInput >> $outputFileName 
		echo "[!]Your file has been outputted to $outputFileName"
	fi
fi
}

function txtFileUtil(){
txtFileDataInput=$1
file_ext="$(echo "$txtFileDataInput" | /usr/bin/grep -Eo ".txt")"

if [ $# -eq 1 ]; then 
	if [ $file_ext ];
	then 
	   	echo "[!] Data extracted from $txtFileDataInput"
		while read line 
		do 
    		txtFileChecks $line
		done < ${txtFileDataInput}
	else
		txtFileChecks $txtFileDataInput
	fi
elif [ $# -gt 1 ]; then 
	outputFileName=$2
	if [ $file_ext ];
	then 
		echo "[!] Data extracted from $txtFileDataInput"
		while read line;
		do
		txtFileChecks $line >> $outputFileName
		done < ${txtFileDataInput}
		echo "[!]Your file has been outputted to $outputFileName"
	else
		txtFileChecks $txtFileDataInput >> $outputFileName
		echo "[!]Your file has been outputted to $outputFileName"
	fi
fi
}



function metadataUtil(){
if [ "$#" -gt 1 ]; then
	fileName=($1)
	outputFilename=$2
	for file in "${!fileArray[@]}"; do
		echo "[*] Analysing "${fileArray[file]}"..."
		metadataExtraction "${fileArray[file]}"
		echo "[*] Analysis of "${fileArray[file]}" complete..."
	done
fi
#	   echo "[!]Analysing $fileName"
#          metadataExtraction $fileName >> $outputFileName
#          echo "[!]Analysing Complete" 	    
}

function bannerGrabbingUtil(){

bannerGrabbingInput=$1
file_ext="$(echo "$bannerGrabbingInput" | /usr/bin/grep -Eo ".txt" )"
if [ $# -eq 1 ]; then 
	if [ $file_ext ];
	then 
		echo "[!] Data extracted from $bannerGrabbingInput" 
		while read line
		do	
		bannerGrab $line 
        	done < ${bannerGrabbingInput}
	else 
		bannerGrab $bannerGrabbingInput
	fi
elif [ $# -gt 1 ]; then 
	outputFileName=$2
	if [ $file_ext ];
	then 
		echo "[!] Data extracted from $bannerGrabbingInput"
		while read line
		do
		bannerGrab $line >> $outputFileName
		done < ${bannerGrabbingInput}
	       	echo "Your file has been outputted to $outputFileName"	
else 
	bannerGrab $bannerGrabbingInput >> $outputFileName
	echo "[!]File has been outputted to $outputFileName"
    fi
fi
}



#function Testing

#whoisUtil $1 $2
#dnsUtil $1 $2
#txtFileUtil $1 $2
#metadataUtil $1 $2
#bannerGrabbingUtil $1 $2


