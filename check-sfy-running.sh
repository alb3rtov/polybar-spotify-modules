#!/bin/sh

if [ $(pgrep spotify | wc -l) -gt 0 ]
then
  song=$(dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:org.mpris.MediaPlayer2.Player string:Metadata | sed -n '/title/{n;p}' | cut -d '"' -f 2 2> /dev/null)
	band=$(dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:org.mpris.MediaPlayer2.Player string:Metadata | sed -n '/artist/{n;n;p}' | cut -d '"' -f 2 2> /dev/null)
  polybar-msg action '#spotifycontrols.open.0' > /dev/null 2>&1
  
  if [ ${#band} -gt 0 ]
  then
    wp_song=$(echo $song | sed "s/[(][^)]*[)]//g")
    total_length=$((${#wp_song} + ${#band}))
    if [ $total_length -gt 30 ]
    then
      all_title=$(echo $band - $wp_song)
      fixed_title=$(echo $all_title | cut -c1-27)
      echo "%{F#9feb6a} %{F#696969} $fixed_title.." 
    else
      echo "%{F#9feb6a} %{F#696969} $band - $wp_song" 
    fi
  else #advertisement
    echo "%{F#9feb6a} %{F#696969} $song" 
  fi

else
	echo "%{F#66ffffff}"
  polybar-msg action '#spotifycontrols.close.0' > /dev/null 2>&1
fi
