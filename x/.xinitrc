#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

#xset +fp /usr/share/fonts/local
xset fp rehash
xrdb ~/.Xresources
setxkbmap us -option compose:ralt -option ctrl:nocaps
xsetroot -cursor_name left_ptr &
hsetroot -fill ~/Windows/Users/gmc/Dropbox/pix/wallpapers/simpledesktops.com/elefanto_wallpaper.png &
dropbox &
start-pulseaudio-x11 &
compton &
dunst -conf ~/.config/dunst/dunstrc &
sxhkd &
#redshift -l 60.1726430:24.9194430 &
eval $(ssh-agent) &
exec bspwm -c ~/.config/bspwm/bspwmrc
