#!/bin/sh
#==================================================
# OS Required: Linux with curl
# Description: CloudXNS DDNS on bash
# Author: kuretru
# Version: 1.0.160827
#==================================================

#API Key
i_api_key="12345678912345678912345678912345"
 
#Secret Key
i_secret_key="1234567891234567"
 
#含主机记录的完整域名(如www.cloudxns.net.)
i_domain="www.cloudxns.net."

#需要DDNS的IP的网卡
i_interface="eth0"
 
i_value=$(ifconfig $i_interface|grep 'inet addr'|awk -F ":" '{print $2}'|awk '{print $1}')
i_url="https://www.cloudxns.net/api2/ddns"
i_time=$(date -R)
i_data="{\"domain\":\"${i_domain}\",\"ip\":\"${i_value}\",\"line_id\":\"1\"}"
i_mac_raw="$i_api_key$i_url$i_data$i_time$i_secret_key"
i_mac=$(echo -n $i_mac_raw | md5sum | awk '{print $1}')
i_header1="API-KEY:"$i_api_key
i_header2="API-REQUEST-DATE:"$i_time
i_header3="API-HMAC:"$i_mac
i_header4="API-FORMAT:json"

curl -k -X POST -H $i_header1 -H "$i_header2" -H $i_header3 -H $i_header4 -d "$i_data" $i_url
