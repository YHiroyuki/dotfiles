#!/bin/bash
my_battery=`ioreg -n AppleSmartBattery | awk '/MaxCapacity/{ MAX=$5 }
        /CurrentCapacity/{ CURRENT=$5 }
        END { printf("%.0f\n",CURRENT/MAX*100)}'`

# echo -e "\033[32mVPN\033[m"
battery_icon=' '
if [ $my_battery -gt 80 ]; then
    battery_icon=' '
elif [ $my_battery -gt 60 ]; then
    battery_icon=' '
elif [ $my_battery -gt 40 ]; then
    battery_icon=' '
elif [ $my_battery -gt 20 ]; then
    battery_icon=' '
fi

echo -e "${my_battery}${battery_icon}"

