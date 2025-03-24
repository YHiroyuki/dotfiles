#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title VPN off
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖


vpn_name="office"
scutil --nc stop $vpn_name
