# Start X at login
status is-login && [ -z "$DISPLAY" -a "$XDG_VTNR" = 1 ]  && exec startx &> /dev/null
