#! /bin/bash

switch () {
    local h=$HOME
    local cfg=$HOME/.config

    usage () {
        echo 'Temporary'
    }

    case $1 in
        -l | --dark )        local t=$h/.styles/luma
                             ;;
        -d | --light )       local t=$h/.styles/duma
                             ;;
        -h | --help )        usage
                             exit
                             ;;
        * )                  usage
                             exit 1
    esac

    rm $cfg/bspwm/bspwmrc-style
    rm $h/.mozilla/firefox/main/chrome/userChrome.css
    rm $h/.mozilla/firefox/main/chrome/userContent.css
    rm $h/.mozilla/firefox/auxiliary/chrome/userChrome.css
    rm $h/.mozilla/firefox/auxiliary/chrome/userContent.css
    rm $cfg/gtk-2.0/gtkrc-2.0
    rm $cfg/gtk-3.0/settings.ini
    rm $cfg/tint2/tint2rc
    rm $cfg/picom/picom.conf
    rm $cfg/xorg/Xresources

    ln -s $t/xorg/Xresources $cfg/xorg/Xresources
    ln -s $t/bspwm/bspwmrc-style $cfg/bspwm/bspwmrc-style
    ln -s $t/firefox/userChrome.css $h/.mozilla/firefox/primary/chrome/userChrome.css
    ln -s $t/firefox/userContent.css $h/.mozilla/firefox/primary/chrome/userContent.css
    ln -s $t/firefox/userChrome.css $h/.mozilla/firefox/auxiliary/chrome/userChrome.css
    ln -s $t/firefox/userContent.css $h/.mozilla/firefox/auxiliary/chrome/userContent.css
    ln -s $t/gtk-2.0/gtkrc-2.0 $cfg/gtk-2.0/gtkrc-2.0
    ln -s $t/gtk-3.0/settings.ini $cfg/gtk-3.0/settings.ini
    ln -s $t/tint2/tint2rc $cfg/tint2/tint2rc
    ln -s $t/picom/picom.conf $cfg/picom/picom.conf
    ln -s $t/rofi/style.rasi $cfg/rofi/style.rasi

    killall tint2
    killall pasystray
    killall nm-applet
    tint2 &
    pasystray &
    nm-applet &

    xrdb -merge $h/.Xresources
    bash $cfg/bspwm/bspwmrc-style
}

switch "$@"
