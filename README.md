# Polybar spotify module

![image](https://user-images.githubusercontent.com/40604222/198890086-ea1ee36b-cc1f-4c42-a8a7-48616ab9ff9c.png)

## Modules
### Song and artist module

```ini
[module/spotify]
type = custom/script
click-left = exec spotify
interval = 2
exec = ~/.config/polybar/scripts/check-sfy-running.sh
format-padding = 1
```
### Controls module

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
