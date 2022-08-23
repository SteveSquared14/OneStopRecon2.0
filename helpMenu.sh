#!/bin/bash

#Help function  to display usages
function helpSummary () {
    echo -e "========================================================================================================================================"
    echo -e "" \                      "\t\t\t\t\t\t  ___             ____  _              ____                      \n" \
                                        "\t\t\t\t\t\t / _ \ _ __   ___/ ___|| |_ ___  _ __ |  _ \ ___  ___ ___  _ __  \n" \
                                        "\t\t\t\t\t\t| | | | '_ \ / _ \___ \| __/ _ \| '_ \| |_) / _ \/ __/ _ \| '_ \ \n" \
                                        "\t\t\t\t\t\t| |_| | | | |  __/___) | || (_) | |_) |  _ <  __/ (_| (_) | | | |\n" \
                                        "\t\t\t\t\t\t \___/|_| |_|\___|____/ \__\___/| .__/|_| \_\___|\___\___/|_| |_|\n" \
                                        "\t\t\t\t\t\t                                |_|                              \n" \
                    ""
    echo -e "========================================================================================================================================"
    echo -e "\n"
    echo -e " -b  | --Banner Grabbing \t\tGain details about a system on a network\t\t\t\t\t[Semi-Passive]"
    echo -e " -dB | --Dorking \t\t\tRun popular dorking searches using Bing search engine\t\t\t\t[Passive]"
    echo -e " -dD | --Dorking \t\t\tRun popular dorking searches using Duck Duck Go search engine\t\t\t[Passive]"
    echo -e " -dG | --Dorking \t\t\tRun popular dorking searches using Google search engine\t\t\t\t[Passive]"
    echo -e " -gD | --GoBuster Directory \t\tBrute force to discover new or hidden directories on target using GoBuster\t[Active]"
    echo -e " -gN | --GoBuster Directory \t\tDiscover new or hidden subdirectories on target using GoBuster\t\t\t[Active]"
    echo -e " -gF | --GoBuster Directory \t\tFuzz to discover new or hidden directories on target using GoBuster\t\t[Active]"
    echo -e " -gV | --GoBuster Directory \t\tDiscover new or hidden virtual hosts on target using GoBuster\t\t\t[Active]"
    echo -e " -M  | --MetaDataExtractor\t\tExracts data from files\t\t\t\t\t\t\t[Passive]"
    echo -e " -m  | --Google Map Request\t\tOpens google map to inputted location\t\t\t\t\t[Passive]"
    echo -e " -n  | --Name Server Enumeration \tLocating all DNS servers and records for a company\t\t\t[Semi-Passive]"
    echo -e " -S  | --Searchsploit \t\t\tSearch for vulnerabilites on the target\t\t\t\t[Passive]"
    echo -e " -s  | --Shodan  \t\t\tIoT devices check\t\t\t\t\t\t\t[Passive]"
    echo -e " -sM | --Social Media Check \t\tCheck for social media accounts relating to the target\t\t\t\t[Passive]"
    echo -e " -t  | --Text file recon \t\tChecks for intel in Robots.txt & Security.txt of domain\t\t\t[Passive]"
    echo -e " -u  | --Username Generator \t\tGenerate usernames for a user of a domain \t\t\t[Passive]"
    echo -e " -w  | --Whois \t\t\t\tWhois URL check\t\t\t\t\t\t\t\t[Passive]"
}

function bannerGrabHelp(){
    echo -e "=============== Syntax =============== "
    echo -e "./OneStopRecon -b [target]"
    echo ""
    echo -e "=============== Accepted Target Types =============== "
    echo -e "Domain"
    echo -e "IPv4 Address"
    echo ""
    echo -e "=============== Example Usages =============== "
    echo -e "./OneStopRecon -b google.com"
    echo -e "./OneStopRecon -b 8.8.8.8"    
    echo -e "The module executes both wget and curl commands to grab the HTTP banners of the target. The module then extracts any server types and version numbers, and if they exist, prompts for an optional search for relevant exploits via Searchsploit"
    echo ""
    inputOutput -b
}

function dorkingHelp(){
    echo -e "=============== Syntax =============== "
    echo -e "This module can be executed on the following browsers "
    echo -e "Bing"
    echo -e "./OneStopRecon -dB [target]"
    echo -e "DuckDuckGo"
    echo -e "./OneStopRecon -dD [target]"
    echo -e "Google"
    echo -e "./OneStopRecon -dG [target]"
    echo ""
    echo -e "=============== Accepted Target Types =============== "
    echo -e "Company Name"
    echo ""
    echo -e "=============== Example Usage =============== "
    echo -e "./OneStopRecon -b companyName"  
    echo -e "The module will execute 10 of the most common dorking commands in the users default/preferred browser application, ready to inspection/review"
    echo ""
    terminalOnly -dG
}

function metadataExtractHelp(){
    echo -e "=============== Syntax =============== "
    echo -e "./OneStopRecon -M [fileName]"
    echo -e "All files must be passed as a single argumen inside quotes. For example "
    echo -e "./OneStopRecon -M \"[fileName1] [fileName2] [fileName3] [fileName4]...\""
    echo ""
    echo -e "=============== Accepted Target Types =============== "
    echo -e "File"
    echo -e "The file"
    echo ""
    echo -e "=============== Example Usages =============== "
    echo -e "./OneStopRecon -m google.com"
    echo -e "./OneStopRecon -m \"Test address here\""
    echo -e "This module can examine one or more files"
    echo -e "This module extracts and examines the metadata of files"
    echo -e "Only the following file types are accepted "
    echo -e ".pdf"
    echo -e ".jpg"
    echo -e ".jpeg"
    echo -e ".gif"
    echo -e ".tiff"
    echo -e ".psd"
    echo ""
    echo -e "=============== Utilities ==============="
    echo -e "This module can read from a command line argument"
    echo -e "This module can output to the terminal"
    echo -e "./OneStopRecon -M \"[fileName1] [fileName2] [fileName3] [fileName4]...\""
    echo ""
    echo -e "This module is compatible with the \"-o\" utility option"
    echo -e "./OneStopRecon -M \"[fileName1] [fileName2] [fileName3] [fileName4]...\" -o [fileToSaveTo.txt]"
    echo ""
    echo -e "This module cannot read from a file"
}

function googleMapsHelp(){
    echo -e "=============== Syntax =============== "
    echo -e "./OneStopRecon -m [targetAddress]"
    echo ""
    echo -e "=============== Accepted Target Types =============== "
    echo -e "Target Address"
    echo -e "The target address MUST be entered in quotes as a single argument"
    echo ""
    echo -e "=============== Example Usages =============== "
    echo -e "./OneStopRecon -m google.com"
    echo -e "./OneStopRecon -m \"Test address here\""    
    echo -e "The module opens a the target in Google Maps, ready for easy and quick inspection by the user incase a physical/on-site test is required"
    echo ""
    terminalOnly -m
}

function gobusterHelp(){
    echo -e "This module can be executed in the following modes "
    echo -e "Directory Bruteforce"
    echo -e "Directory Fuzz"
    echo -e "Subdmain Discovery"
    echo -e "Virtual Host Discovery"
    echo ""
    echo -e "=============== Syntax =============== "
    echo -e "Directory Bruteforce"
    echo -e "./OneStopRecon -gD [target]"
    echo -e "Directory Fuzz"
    echo -e "./OneStopRecon -gF [target]"
    echo -e "Subdmain Discovery"
    echo -e "./OneStopRecon -gn [target]"
    echo -e "Virtual Host Discovery"
    echo -e "./OneStopRecon -gv [target]"
    echo ""
    echo -e "=============== Accepted Target Types =============== "
    echo -e "Domain"
    echo ""
    echo -e "=============== Example Usage =============== "
    echo -e "./OneStopRecon -b google.com"  
    echo -e "The module offers four different options for using GoBuster on the target "
    echo -e "Directory discovery (Brute Force), Directory discovery (Fuzzing), Subdomain discovery, and Virtual Host discovery"
    echo ""
    terminalOnly -dD
}

function dnsHelp(){
    echo -e "=============== Syntax =============== "
    echo -e "./OneStopRecon -n [target]"
    echo ""
    echo -e "=============== Accepted Target Types =============== "
    echo -e "Domain"
    echo ""
    echo -e "=============== Example Usage ===============s "
    echo -e "./OneStopRecon -s google.com"
    echo -e "This module takes a domain as an argument and executes three commonly used commands "
    echo "Dig"
    echo "Host"
    echo "NSLookup"
    echo -e "The domain entered by the user is passed to the dig command. Then the module extracts the resulting IP Address and passes it as an arugment to the Host command. The module then extracts ALL name servers associated with that IP Address and executes NSLookup on each of them."
    echo ""
    inputOutput -n
}

function shodanHelp(){
    echo -e "=============== Syntax =============== "
    echo -e "./OneStopRecon -s [target]"
    echo ""
    echo -e "=============== Accepted Target Types =============== "
    echo -e "IoT Device"
    echo -e "IP Address"
    echo -e "Domain"
    echo ""
    echo -e "=============== Example Usages =============== "
    echo -e "./OneStopRecon -s apache"
    echo -e "./OneStopRecon -s 8.8.8.8"
    echo -e "The module opens a the target in shodan.io, ready for easy and quick inspection by the user"
    echo ""
    terminalOnly -s
}

function searchSploitHelp(){
    echo -e "=============== Syntax =============== "
    echo -e "./OneStopRecon -S [target]"
    echo ""
    echo -e "=============== Accepted Target Types =============== "
    echo -e "When used as a standalone module, the target can be any term deemed acceptable by searchsploit"
    echo -e "This module can also optionally be used in-conjuction with the Banner Grabbing module, if that module returns a Server Type and/or version number"
    echo ""
    echo -e "=============== Example Usage =============== "
    echo -e "./OneStopRecon -S apache" 
    echo ""
    terminalOnly -S
}

function socialMediaHelp(){
    echo -e "=============== Syntax =============== "
    echo -e "./OneStopRecon -sM [target]"
    echo ""
    echo -e "=============== Accepted Target Types =============== "
    echo -e "Username" 
    echo ""
    echo -e "=============== Example Usage =============== "
    echo -e "./OneStopRecon -sM joebloggs" 
    echo -e "When used as a standalone module, this tool takes a username as a parameter and seaches for any available social media accounts relating to it using Sherlock"
    echo -e "This module can also optionally be used in-conjuction with the Username Generator if the user only knows a target's name and a target domain"
    echo ""
    inputOnly -sM
}

function txtCheckHelp(){
    echo -e "=============== Syntax =============== "
    echo -e "./OneStopRecon -t [target]"
    echo ""
    echo -e "=============== Accepted Target Types =============== "
    echo -e "Domain"
    echo ""
    echo -e "=============== Example Usage =============== "
    echo -e "./OneStopRecon -t google.com" 
    echo -e "This module retrieves the contents of robots.txt and security.txt files from the specified domain, if they exist"
    echo ""
    inputOutput -t
}

function usernameGenHelp(){
    echo -e "=============== Syntax =============== "
    echo -e "./OneStopRecon -u [targetFirstName] [targetLastName] [targetDomain]"
    echo ""
    echo -e "=============== Accepted Target Types =============== "
    echo -e "Domain"
    echo -e "Full Name"
    echo -e "Full Name must be entered as seperate arguments, followed by the target domain"
    echo ""
    echo -e "=============== Example Usage =============== "
    echo -e "./OneStopRecon -u Joe Bloggs domain.com" 
    echo -e "This module takes a person's full name and a target domain and generates up to 12 possible username AND email address combinations"
    echo -e "Usernames and emails are output in order of most-least common"
    echo ""
    echo -e "=============== Utilities ==============="
    echo -e "This module can read from a command line argument"
    echo -e "This module can output to the terminal"
    echo -e "./OneStopRecon -u [targetFirstName] [targetLastName] [targetDomain]"
    echo ""
    echo -e "This module is compatible with the \"-o\" utility option"
    echo -e "./OneStopRecon -u [targetFirstName] [targetLastName] [targetDomain] -o [fileToSaveTo.txt]"
    echo ""
    echo -e "This module cannot read from a file"
}

function whoIsHelp(){
    echo -e "=============== Syntax =============== "
    echo -e "./OneStopRecon -w [target]"
    echo ""
    echo -e "=============== Accepted Target Types =============== "
    echo -e "Domain"
    echo -e "IP Address"
    echo ""
    echo -e "=============== Example Usage =============== "
    echo -e "./OneStopRecon -w google.com" 
    echo -e "This module retrieves information about the target from the whoIs command"
    echo -e "It also provides an optional Name Server Enumeration"
    echo ""
    inputOutput -w
}

function terminalOnly(){
    echo -e "=============== Utilities ==============="
    echo -e "This module can read from a command line argument"
    echo -e "This module can output to the terminal"
    echo -e "This module cannot read from a file"
    echo -e "This module cannot output to a file"
    echo -e "./OneStopRecon $1 [target]"
}

function inputOnly(){
    echo -e "=============== Utilities ==============="
    echo -e "This module can read from a command line argument"
    echo -e "This module can output to the terminal"
    echo -e "./OneStopRecon $1 [target]"
    echo ""
    echo -e "This module is compatible with the \"-f\" utility option"
    echo -e "./OneStopRecon $1 [target] -f [fileToRead.txt]"
    echo ""
    echo -e "This module cannot output to a file"
}

function outputOnly(){
    echo -e "=============== Utilities ==============="
    echo -e "This module can read from a command line argument"
    echo -e "This module can output to the terminal"
    echo -e "./OneStopRecon $1 [target]"
    echo ""
    echo -e "This module is compatible with the \"-o\" utility option"
    echo -e "./OneStopRecon $1 [target] -o [fileToSaveTo.txt]"
    echo ""
    echo -e "This module cannot read from a file"
}

function inputOutput(){
    echo -e "=============== Utilities ==============="
    echo -e "This module can read from a command line argument"
    echo -e "This module can output to the terminal"
    echo -e "./OneStopRecon $1 [target]"
    echo ""
    echo -e "This module is compatible with both \"-f\" and \"-o\" utility options"
    echo -e "./OneStopRecon $1 [target] -f [fileToRead.txt]"
    echo -e "./OneStopRecon $1 [target] -o [fileToSaveTo.txt]"
    echo -e "./OneStopRecon $1 [target] -f [fileToRead.txt] -o [fileToSaveTo.txt]"
}

function defaultHelp(){
    echo -e "[*] For more detailed on a specific module, choose from the following:"
    echo -e "--help\t\t\t| -- Generic help for OneStopRecon"
    echo -e "--help-bannerGrab\t| -- Detailed help for the Banner Grabbing module"
    echo -e "--help-dnsEnumeration\t| -- Detailed help for the Name Server Enumeration module"
    echo -e "--help-dorking\t\t| -- Detailed help for Dorking module"
    echo -e "--help-goBuster\t\t| -- Detailed help for Go Buster module"
    echo -e "--help-googleMaps\t| -- Detailed help for Google Maps module"
    echo -e "--help-metadata\t\t| -- Detailed help for Metadata Extraction module"
    echo -e "--help-searchsploit\t| -- Detailed help for Searchsploit module"
    echo -e "--help-shodan\t\t| -- Detailed help for Shodan module"
    echo -e "--help-socialMedia\t| -- Detailed help for Social Media Discovery module"
    echo -e "--help-textFileCheck\t| -- Detailed help for Text File Check module"
    echo -e "--help-usernameGen\t| -- Detailed help for Username Generation module"
    echo -e "--help-whoIs\t\t| -- Detailed help for WhoIs module"
}

#Determines which function has been specified by the user and calls the necessary function
function checkHelpFunc(){
    echo -e ""
}