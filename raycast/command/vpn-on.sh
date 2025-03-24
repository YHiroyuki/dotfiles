#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title VPN on
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖

vpn_name="office"
scutil --nc start $vpn_name --secret `cat ~/.config/secret/vpn/${vpn_name}`

