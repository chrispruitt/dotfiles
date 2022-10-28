#!/bin/bash

SCRIPT=$(basename $0 | sed 's/_/ /')

exec > >(trap "" INT TERM; sed "s/^/${SCRIPT}: /")
exec 2> >(trap "" INT TERM; sed "s/^/${SCRIPT}: (stderr) /" >&2)


function exit_if_not_desktop(){
    # limit this to desktop environments
    case "$XDG_CURRENT_DESKTOP" in
        KDE)
            # do nothing
            ;;
        GNOME)
            # do nothing
            ;;
        *)
            exit 0
            ;;
    esac
}

function exit_if_installed(){
    which $1 > /dev/null 2>/dev/null
    [ $? -eq 0 ] && [ ! "$FORCE_REINSTALL" = "y" ] && exit 0
    echo "installing.."

    TMPDIR=$(mktemp -d)
    trap 'rm -rf -- "$TMPDIR"' EXIT
    cd $TMPDIR
}


function exit_if_installed_with_flatpak(){
    isInstalled=$(flatpak list | grep $1)
    if [[ -z "$isInstalled" || ! "$FORCE_REINSTALL" = "y" ]]; then
        exit 0
    fi;
    
    echo installing $1
    TMPDIR=$(mktemp -d)
    trap 'rm -rf -- "$TMPDIR"' EXIT
    cd $TMPDIR
}