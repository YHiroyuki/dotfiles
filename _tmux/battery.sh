#!/bin/sh
echo `ioreg -n AppleSmartBattery | awk '/MaxCapacity/{ MAX=$5 }
        /CurrentCapacity/{ CURRENT=$5 }
        END { printf("%.0f\n",CURRENT/MAX*100)}'`
