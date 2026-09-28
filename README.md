### A rudimentary method to force the Acer CB-515-1HT-C1W7 to fast charge **on Ubuntu.**
#### My kernel version: 7.0.0-31
#### coreboot release: MrChromebox-2609.0

**Method:** Putting the system to sleep and immediately waking it up.

Plug in your Type-C charger and run:
```
rtcwake -m mem -s 1
```
The system will go to sleep for 1 second. After waking up, fast charging will work until you unplug the cable.

**Did it work? Here is how you can automate it.** Run these three commands:
```
sudo curl -Lf -o /usr/local/bin/fix-fastcharge.sh https://raw.githubusercontent.com/Lenger34/chromebook-acer-chargespeed-fix/refs/heads/main/fix-fastcharge.sh && sudo chmod +x /usr/local/bin/fix-fastcharge.sh
```
```
echo 'ACTION=="change", SUBSYSTEM=="power_supply", KERNEL=="AC", ATTR{online}=="1", RUN+="/usr/bin/systemd-run --no-block /usr/local/bin/fix-fastcharge.sh"' | sudo tee /etc/udev/rules.d/99-cros-charging.rules > /dev/null
```
```
sudo udevadm control --reload-rules && sudo udevadm trigger
```
<br>

**To uninstall:**
```
sudo rm -rf /usr/local/bin/fix-fastcharge.sh /etc/udev/rules.d/99-cros-charging.rules && sudo udevadm control --reload-rules && sudo udevadm trigger
```
## Is there a better way?
It might help to roll back to previous versions of coreboot ( **<** MrChromebox-2606.0) or the kernel ( **<** 7.0.0). My attempts to fix the problem using this [ectool](https://github.com/DHowett/ectool) and by disabling USB autosuspend were unsuccessful.

## EC Logs:
When waking up from sleep and forcing fast charge:<br>
`[21685.010872 charge problem: batt params, 0x78e -> 0x7fc after 2345.111524s]`<br>
`[21685.011718 try to wake battery]`<br>
`[21685.024615 charge_request(8688mV, 128mA)]`<br>
`[21685.156848 charge_request(8208mV, 3200mA)]`

Plugging the charger **before** sleep (EC never sends charge_request) : <br>
`[22402.399277 New chg p1]`<br>
`[22403.402283 AC on]`<br>
`[22404.406499 Ramp p1 st5 3000mA 3000mA]`<br>
(...Complete Silence...)
