#!/bin/bash
sudo apt-get update
sudo apt-get install wireguard-tools
sudo apt install resolvconf
read -p 'Enter Email ID: ' email < /dev/tty
read -p 'Enter Friendly Name: ' id < /dev/tty
read -p 'Enter API Key: ' api < /dev/tty
json='{"Email":"'"${email}"'","Identifier":"'"${id}"'"}'
sudo curl --silent  -f -k -X POST "http://167.71.237.148:8080/api/v1/provisioning/peers" -H "accept: text/plain" -H "authorization: Basic $api" -H "Content-Type: application/json" -d $json -o "/etc/wireguard/wg0.conf"
sudo systemctl start wg-quick@wg0
sudo systemctl enable wg-quick@wg0
resolvectl flush-caches
