#!/bin/bash

PATH="$(pwd)"
. $PATH/functionLibrary2.0.sh 

#Reading Files

function whoisUtil(){
whoisDataInput=$1
file_ext="$(echo  "$whoisDataInput" | /usr/bin/grep -Eo ".txt")"

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
fileName=$1
outputFileName=$2
	    echo "[!]Analysing $fileName"
            metadataExtraction $fileName >> $outputFileName
            echo "[!]Analysing Complete" 	    
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
		bannerGrab $line > $outputFileName
		done < ${bannerGrabbingInput}
	       	echo "Your file has been outputted to $outputFileName"	
else 
	bannerGrab $bannerGrabbingInput >> $outputFileName
	echo "[!]File has been outputted to $outputFileName"
    fi
fi
}



#function Testing

whoisUtil $1 $2
#dnsUtil $1 $2
#txtFileUtil $1 $2
#metadataUtil $1 $2
#bannerGrabbingUtil $1 $2


