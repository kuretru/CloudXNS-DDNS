#!/bin/sh
#==================================================
# OS Required: Linux with curl
# Description: CloudXNS DDNS on bash
# Author: Kuretru
# Version: 1.1.160913
# Github: https://github.com/kuretru/CloudXNS-DDNS/
#==================================================

#API Key
api_key=""
 
#Secret Key
secret_key=""
 
#Domain name
#e.g. domain="www.cloudxns.net."
domain=""

#WAN Network Interface Card
#e.g. interface=""     		 -> If it's empty, CloudXNS will automatic get your public IP
#or   interface="ppp0" 		 -> on tomato
#or   interface="pppoe-wan1" -> on OpenWRT
interface=""

if  [ -n "$interface" ] ;then
	value=$(ifconfig $interface|grep 'inet addr'|awk -F ":" '{print $2}'|awk '{print $1}')
fi
url="https://www.cloudxns.net/api2/ddns"
time=$(date -R)
data="{\"domain\":\"${domain}\",\"ip\":\"${value}\",\"line_id\":\"1\"}"
mac_raw="$api_key$url$data$time$secret_key"
mac=$(echo -n $mac_raw | md5sum | awk '{print $1}')
header1="API-KEY:"$api_key
header2="API-REQUEST-DATE:"$time
header3="API-HMAC:"$mac
header4="API-FORMAT:json"

result=$(curl -k -X POST -H $header1 -H "$header2" -H $header3 -H $header4 -d "$data" $url)
echo "${result} ${time} ${data}" >> $(cd `dirname $0`; pwd)/cloudxns-ddns.log