# Polybar spotify modules
In this repository you will find two polybar modules of spotify client.

![image](https://user-images.githubusercontent.com/40604222/198890086-ea1ee36b-cc1f-4c42-a8a7-48616ab9ff9c.png)

All icons used can be found in https://www.nerdfonts.com/cheat-sheet

## Requirements
You need to have installed the spotify client. You can use the next command in Debian/Ubuntu distros:
```
sudo apt-get install spotify-client
```

## Modules
In order to add this module, you have to modify the `config.ini` file of polybar configuration. This file usually can be found in `/etc/polybar/config.ini`. (You need to have root permissions to write in this file)

### Launch spotify and show artist/band and song module

In order to launch spotify and show the artist/band and song currently playing, you have to add the next module to the `config.ini` file.

```ini
[module/spotify]
type = custom/script
click-left = exec spotify
interval = 2
exec = ~/.config/polybar/scripts/check-sfy-running.sh
format-padding = 1
```

You have to make sure that the script `check-sfy-running.sh` is the correct path (choose what ever you want) and it have execution permissions. This script checks if an instance of spotify is running on the system and if so set green color to spotify icon and set the correspoding artist/band and song that is currently playing.

**Note: Replace the string 'spoti-icon' of the script to the real spotify icon.**

```bash
#!/bin/sh

if [ $(pgrep spotify | wc -l) -gt 0 ]
then
  song=$(dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:org.mpris.MediaPlayer2.Player string:Metadata | sed -n '/title/{n;p}' | cut -d '"' -f 2 2> /dev/null)
  band=$(dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:org.mpris.MediaPlayer2.Player string:Metadata | grep -A2 "artist" | tail -1 | awk '{print $2}' | tr -d '"' 2> /dev/null)
  polybar-msg action '#spotifycontrols.open.0' &> /dev/null
  
  if [ $band ]
  then
    echo "%{F#9feb6a}spoti-icon %{F#696969} $band - $song" 
  else
    echo "%{F#9feb6a}spoti-icon %{F#696969} $song" 
  fi

else
  echo "%{F#66ffffff}spoti-icon"
  polybar-msg action '#spotifycontrols.close.0' &> /dev/null
fi
```

### Next, previous and play/pause controls module

This modules is a custom menu composed of three options in order to manage songs:
- Previous
- Play/Pause
- Next

This menu opens automatically when spotify is launched and it closes when any instance of spotify is running on the system. 

Because the label `label-open` is needed for custom menus, we have to do trick a little bit cumbersome, that is open the first menu every time that we click in any of the options, because when an option in clicked, the menu closes automatically. To do so, the following command is executed:

```
polybar-msg action '#spotifycontrols.open.0'
```

Note: Replace the next characters with the good icons:

- "<" &rarr; previous button
- "-" &rarr; play/pause button
- ">" &rarr; next button
 
```ini
[module/spotifycontrols]
type = custom/menu
expand-right = true
format-spacing = 1
label-open = ""
label-open-foreground = #83a5be
label-close = ""

menu-0-0 = "<"
menu-0-0-exec = "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous && polybar-msg action '#spotifycontrols.open.0'"
menu-0-0-foreground = #696969

menu-0-1 = "-"
menu-0-1-exec = "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause && polybar-msg action '#spotifycontrols.open.0'"
menu-0-1-foreground = #696969

menu-0-2 = ">"
menu-0-2-exec = "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next && polybar-msg action '#spotifycontrols.open.0'"
menu-0-2-foreground = #696969
```

## Add modules to bar
Add the created modules to your bar. Just go to the `modules-left` or `modules-right` options and add it in that order.

```ini
# Example of how to add modules to a bar
[bar/top]
modules-right= spotify spotifycontrols
```
