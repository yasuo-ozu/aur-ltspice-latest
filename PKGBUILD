# Maintainer: Yasuo Ozu <yasuo@ozu.email>
pkgname=ltspice-latest
pkgver=263df6855d6d79277240
pkgrel=1
epoch=
pkgdesc=""
arch=("x86_64")
url=""
license=('custom')
groups=()
depends=("wine")
makedepends=("netcat" "gendesk" "imagemagick" "wget")
checkdepends=()
optdepends=()
provides=()
conflicts=()
replaces=()
backup=()
options=()
install=
changelog=
source=("http://ltspice.linear-tech.com/software/LTspiceXVII.exe" "ltspice.sh" "$pkgname.xml" "system.reg")
md5sums=('SKIP' 'SKIP' 'SKIP' 'SKIP')

prepare() {
	wget -O "${pkgname}.jpg" "https://pbs.twimg.com/profile_images/839168408490913792/ukNPeWwa_200x200.jpg" 
	convert "${pkgname}.jpg" "${pkgname}.png"
	gendesk -f --pkgname "$pkgname" --pkgdesc "$pkgdesc" --name="LTSpice XVII" --exec="ltspice"
	echo "MimeType=application/x-ltspice-asc;" >> "${srcdir}/$pkgname.desktop"
}

pkgver() {
	(
		/bin/echo -ne "HEAD /software/LTspiceXVII.exe HTTP/1.1\r\n"
		/bin/echo -ne "Host: ltspice.linear-tech.com\r\n"
		/bin/echo -ne "User-Agent: Mozilla/5.0 (X11; Linux x86_64) Chrome\r\n"
		/bin/echo -ne "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8\r\n"
		/bin/echo -ne "Referer: http://www.linear-tech.co.jp/designtools/software/\r\n"
		/bin/echo -ne "Accept-Encoding: gzip, deflate\r\n"
		/bin/echo -ne "Accept-Language: ja,en-US;q=0.8,en;q=0.6\r\n"
		/bin/echo -ne "\r\n"
	) | nc ltspice.linear-tech.com 80|sed -ne '/^ETag/p'|sed -e 's/^.*\"\(.*\)\".*$/\1/' -e 's/\-//g'
}

build() {
	mkdir -p "${srcdir}/wine"
	export WINEPREFIX="${srcdir}/wine"
	echo "Now I ran LTSpice installer."
	echo "Please install to default directory and close application quickly after installed."
	wine LTspiceXVII.exe || :
	sleep 10
	ln -snf "${srcdir}/wine/drive_c/Program Files/LTC/LTspiceXVII" "${srcdir}/ltspice"
	echo "Removing files..."
	grep "${srcdir}/wine" -rl "/home/"`whoami`"/.local/share/applications/" | cat
	grep "${srcdir}/wine" -rl "/home/"`whoami`"/.local/share/applications/" | xargs -I{} rm "{}"
}

package() {
	#mkdir -p "${pkgdir}/usr/share/ltspice"
	mkdir -p "${pkgdir}/usr/share/licenses/ltspice"

	install -D -m644 "${srcdir}/ltspice/License.txt" "${pkgdir}/usr/share/licenses/ltspice/LICENSE"
	cp -r "${srcdir}/wine/drive_c/Program Files/LTC/LTspiceXVII" "${pkgdir}/usr/share/ltspice"
	chmod 0755 -R "${pkgdir}/usr/share/ltspice"
	chmod 0755 -R "${pkgdir}/usr/share/licenses/ltspice"

	install -D -m755 "${srcdir}/ltspice.sh" "${pkgdir}/usr/bin/ltspice"
	install -Dm644 "system.reg" "$pkgdir/usr/share/ltspice/system.reg"

	# Install desktop entry
	install -Dm644 "$pkgname.desktop" "$pkgdir/usr/share/applications/$pkgname.desktop"
	install -Dm644 "$pkgname.xml" "$pkgdir/usr/share/mime/packages/$pkgname.xml"
	install -Dm644 "$pkgname.png" "$pkgdir/usr/share/pixmaps/$pkgname.png"
}
