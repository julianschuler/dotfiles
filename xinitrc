#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

export PATH="$HOME/documents/scripts:$PATH"

setxkbmap de nodeadkeys

xss-lock xsecurelock &

exec spectrwm
