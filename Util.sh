#!/bin/bash

PATH="$(pwd)"
. $PATH/functionLibrary2.0.sh 

#Reading Files

function whoisReadingFile(){
fileName=$1
echo "[!] Data extracted from $1"
while read line;
do
   whoIsFunc $line
done < ${fileName}
}

function dnsReadingFile(){
fileName=$1
echo "[!] Data extracted from $1"
while read line;
do 
    dnsCheck $line
done < ${fileName}
}

function txtFileReadingFile(){
fileName=$1
echo "[!]" Data extracted from $1
while read line 
do 
    txtFileChecks $line
done < ${fileName}
}


#File Outputting 

function whoisOutputtingFile(){
firstArg=$1
outputFileName=$2
if  [ -f $firstArg ];
then	
	while read line 
	do 
	     whoIsFunc $line > $outputFileName
	done < ${firstArg}
        echo "File has be outputted to $2"
else 
	whoIsFunc $firstArg > $outputFileName
	echo "File has been outputted to $2"
fi
}

function dnsOutputtingFile(){
firstArg=$1
outputFileName=$2
if [ -f $firstArg ];
then 
	while read line 
	do
		dnsCheck $line > $outputFileName
		done < ${firstArg}
	echo "File has been outputted to $2"
else 
        dnsCheck $firstArg > $outputFileName
	echo "File has been outputted to $2"
fi
}

function metadataOutputting(){
fileName=$1
outputFileName=$2
            metadataExtraction $fileName > $outputFileName
            echo 	    
}

function bannerGrabbingOutputting(){
firstArg=$1
outputFileName=$2
if [ -f $firstArg ];
then 
	while read line
	do	
	bannerGrab $line > $outputFileName
        done < ${firstArg}	
	echo "File has been outputted to $2"
else 
	bannerGrab $firstArg > $outputFileName
	echo "File has been outputted to $2"
fi

}

function txtFileOutputtingFile(){
firstArg=$1
outputFileName=$2
if [ -f $firstArg ];
then 
	while read line
	do
	txtFileChecks $line > $outputFileName
	done < ${firstArg}
        echo "File has been outputted to $2"
else 
	txtFileChecks $firstArg > $outputFileName
	echo "File has been outputted to $2"	
fi
}

#Error Handling 

#function Testing
#whoisReadingFile $1
#dnsReadingFile $1
#txtFileReadingFile $1

#whoisOutputtingFile $1 $2
#dnsOutputtingFile $1 $2
#metadataOutputting $1 $2
bannerGrabbingOutputting $1 $2
#txtFileOutputtingFile $1 $2
