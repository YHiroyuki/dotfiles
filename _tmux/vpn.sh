#!/bin/bash
vpn_status=`scutil --nc status office | head -n 1`

if [ "$vpn_status" == "Connected" ]; then
    # echo -e "\033[32mVPN\033[m"
    echo ''
fi
