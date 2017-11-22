#!/bin/bash

unset WINEPREFIX

if [ ! -d "${HOME}/.ltspice" ]; then
	mkdir -p "${HOME}/.ltspice"
	touch "${HOME}/.ltspice/scad3.ini"
fi

if grep "LTspice" "${HOME}/.wine/system.reg" ; then
	echo "Registry is written"
else
	echo "Writing registry..."
	cat /usr/share/ltspice/system.reg >> "${HOME}/.wine/system.reg"
fi

if [ ! -d "${HOME}/.wine/drive_c" ]; then
	wineboot -i
fi

if [ ! -L "${HOME}/.wine/drive_c/Program Files/LTC/LTspiceXVII" ]; then
	mkdir -p "${HOME}/.wine/drive_c/Program Files/LTC"
	ln -snf "/usr/share/ltspice" "${HOME}/.wine/drive_c/Program Files/LTC/LTspiceXVII" 
fi

wine 'C:\Program Files\LTC\LTspiceXVII\XVIIx64.exe' -ini "${HOME}/.ltspice/scad3.ini" "$@"
