#!/bin/bash
export PATH=/usr/sbin:/usr/bin:/sbin:/bin

logger "fix-fastcharge: Charger detected. Waiting..."

for i in {1..7}; do
    # Check if the charger is actually reporting as online
    if [ "$(cat /sys/class/power_supply/AC/online 2>/dev/null)" = "1" ]; then
        
        logger "fix-fastcharge: AC is online."
            rtcwake -m mem -s 1
        exit 0
    fi
    sleep 1
done

logger "fix-fastcharge: Charger never came online within 7 seconds. Aborting."
