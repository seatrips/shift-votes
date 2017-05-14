#!/bin/bash


bold=$(tput bold)
normal=$(tput sgr0)

clear
echo
echo "************************"
echo "*  Let's Swap Votes!   *"
echo "*Created by @nytrobound*"
echo "************************"
echo
sleep 1s
echo "Welcome, "$USER"! This script will help you to manage your swapped votes by generating two files: "
sleep 2s
echo
echo "${bold}needvote.txt${normal} is a list of delegates that didn't vote back."
sleep 2s
echo "${bold}givevote.txt${normal} is a list of delegates that you didn't vote for."
echo
sleep 2s
echo "You can find your public key and address at https://explorer.shiftnrg.org"
echo
sleep 1s
echo -n "Enter your ${bold}public key${normal} and press [ENTER]: "
read publicKey
sleep .5s
echo -n "Enter your ${bold}address${normal} and press [ENTER]: "
read address
echo


echo
# Get voters
echo "Downloading voters..."
echo "#####################"
echo
curl -k -X GET https://wallet.shiftnrg.org/api/delegates/voters?publicKey=$publicKey > voters.json
echo

# Get votes
echo "Downloading votes..."
echo "#####################"
echo
curl -k -X GET https://wallet.shiftnrg.org/api/accounts/delegates/?address=$address > votes.json
echo

# Sort votes list
grep -oE '"username":"[^"]*"' votes.json | sort > votes.txt

# Sort voters list
grep -oE '"username":"[^"]*"' voters.json | sort > voters.txt

# These people should vote for you:
fgrep -vf voters.txt votes.txt > needvote.txt

# You should vote for:
fgrep -vf votes.txt voters.txt > givevote.txt


echo 
rm votes.json
rm voters.json
rm votes.txt
rm voters.txt

sleep 2s

echo " --> Script has finished. You should find both .txt files in your current directory. Have fun!" 
