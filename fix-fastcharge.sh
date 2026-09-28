#!/bin/bash
export PATH=/usr/sbin:/usr/bin:/sbin:/bin
for i in {1..7}; do
    if [ "$(cat /sys/class/power_supply/AC/online 2>/dev/null)" = "1" ]; then
        if [ "$(cat /sys/class/power_supply/AC/online 2>/dev/null)" = "1" ]; then
            rtcwake -m mem -s 1
        fi
        exit 0
    fi
    sleep 1
done
