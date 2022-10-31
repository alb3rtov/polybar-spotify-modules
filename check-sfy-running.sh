#!/bin/sh

if [ $(pgrep spotify | wc -l) -gt 0 ]
then
  song=$(dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:org.mpris.MediaPlayer2.Player string:Metadata | sed -n '/title/{n;p}' | cut -d '"' -f 2 2> /dev/null)
  band=$(dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:org.mpris.MediaPlayer2.Player string:Metadata | sed -n '/artist/{n;n;p}' | cut -d '"' -f 2 2> /dev/null)
  polybar-msg action '#spotifycontrols.open.0' &> /dev/null
  
  if [ ${#band} -gt 0 ]
  then
    echo "%{F#9feb6a} %{F#696969} $band - $song" 
  else
    echo "%{F#9feb6a} %{F#696969} $song" 
  fi

else
  echo "%{F#66ffffff}"
  polybar-msg action '#spotifycontrols.close.0' &> /dev/null
fi
