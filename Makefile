.PHONY:	pkg clean
pkg:	PKGBUILD ltspice-latest.xml ltspice.sh
	makepkg -f
clean:
	rm -rf src pkg
	rm -f *.tar.xz LTspiceXVII.exe
