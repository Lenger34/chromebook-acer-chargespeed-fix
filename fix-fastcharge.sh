#!/bin/bash
#Force fast charging
if [ "$(cat /sys/class/power_supply/AC/online 2>/dev/null)" = "1" ]; then
    rtcwake -m mem -s 1
fi
