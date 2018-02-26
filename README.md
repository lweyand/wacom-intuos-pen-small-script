# wacom-intuos-pen-small-script

I write this little script for configuring my wacom intuos pen small under    
my favorite linux distrib.

sources:
* http://linuxwacom.sourceforge.net/wiki/index.php/Tablet_Configuration

# Autostart script

## Autostart with bash:
* In my `~/.bashrc` I add a ligne to call my script.
* Or I add the same line ine my `~/.profile`.
But ... this is available only when I start a terminal...

## Autostart with XDG
* For Ubuntu Create a new .desktop file:
```
nano ~/.config/autostart/my_wacom.desktop
[Desktop Entry]
Type=Application
Name=Config Wacom
Comment=Configuration de la tablette wacom
Exec=~/.wacom/config.sh
Icon=system-run
X-GNOME-Autostart-enabled=true
```
* For LUbuntu (LXDE https://wiki.archlinux.fr/LXDE#Lancement_automatique_de_programmes ) add the script at the end of the file:
```
nano $XDG_CONFIG_HOME/lxsession/LXDE/autostart
```
But ... this is available only if the tablet is connected at startup.
