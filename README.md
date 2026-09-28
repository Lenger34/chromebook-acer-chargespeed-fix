# chromebook-acer-chargespeed-fix
A rudimentary method to force the Acer CB-515-1HT-C1W7 to fast charge **on Ubuntu.**

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
