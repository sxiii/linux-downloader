#!/bin/bash

# Download functions and commands

wgetcmd () { 
echo "Downloading $new to $output"
wget -q --show-progress -c "$new" -O "$output" -o /dev/null
}

# Function to only get filesize
getsize () { 
abc=$(wget --spider $new 2>&1)
y=$(echo $abc | awk -F"Length:" '{ print $2 }' | awk -F"[" '{ print $1 }')
ss=$(ls -l -B $output | awk -F" " '{ print $5 }')
sh=$(ls -lh $output | awk -F" " '{ print $5 }')
printf "File: $new has size: $y while on disk it is $output - $ss ($sh) \n"
}

# This can be adopted for using torrents instead of direct HTTP/FTP files
# ariacmd () { aria2c --seed-time=0 -c $new; } # Set seeding time after downloading to zero ( this is sad :-( remove --seed-time=0 if you like to seed :-) )

# Other functions

notlive () {
echo " / / ---------------------------------------------------------------------- \ \ "
echo " | | Note: this is not a live disk (it'll require further installation).    | | "
echo " \ \ -----------------------------------------------------------------------/ / "
}

notlinux () {
echo " / / ------------------------------------------------------------------------------------- \ \ "
echo " | | Note: this isn't actually linux. It was included as it's important opensource project | | "
echo " \ \ --------------------------------------------------------------------------------------/ / "
}

empty () {
echo "The file $output is empty. Please download it first." # This function does nothing
}

checkfile () {
if [ "$1" == "filesize" ]; then 
	[ -s $output ] && getsize || empty 
else
	wgetcmd
fi
}

# Update latest distro URL functions

archurl () {
mirror="https://archlinux.org/download/"
x=$(curl -s $mirror | grep -m1 geo | awk -F"\"" '{ print $2 }')
y=$(curl -s $x | grep -m1 archlinux | awk -F".iso" '{ print $1 }' | awk -F"\"" '{ print $2 }' );
new="$x/$y.iso"
output="archlinux.iso"
checkfile $1
}

manjarourl () {
mirror="https://manjaro.org/download/"
x=$(curl -s $mirror | grep btn-fi | grep xfce | awk -F"\"" '{ print $4 }')
new="$x"
output="manjaro.iso"
checkfile $1
}

arcourl () {
mirror="https://bike.seedhost.eu/arcolinux/iso/"
x=$(curl -s $mirror | grep -m1 arcolinux- | awk -F">" '{ print $3 }' | awk -F"<" '{ print $1 }')
new="$mirror/$x"
output="arcolinux.iso"
checkfile $1
}

archbangurl () {
mirror="https://sourceforge.net/projects/archbang/files/latest/download"
new="$mirror"
output="archbang.iso"
checkfile $1
}

parabolaurl () {
mirror="https://wiki.parabola.nu/Get_Parabola"
new=$(curl -s $mirror | grep iso | grep Web | awk -F"\"" '{ print $18 }' | grep iso -m1)
output="parabola.iso"
checkfile $1
}

endeavoururl () {
mirror="https://sourceforge.net/projects/endeavouros-repository/files/latest/download"
new="$mirror"
output="endeavour.iso"
checkfile $1
}

artixurl () {
mirror="https://mirrors.dotsrc.org/artix-linux/iso/"
x=$(curl -s $mirror | grep mate-openrc | head -1 | awk -F\" '{ print $2 }')
new="$mirror/$x"
output="artix.iso"
checkfile $1
}

arcourl () {
mirror="https://sourceforge.net/projects/arcolinux/files/latest/download"
new="$mirror"
output="arco.iso"
checkfile $1
}

garudaurl () {
mirror="https://sourceforge.net/projects/garuda-linux/files/latest/download"
new="$mirror"
output="garuda.iso"
checkfile $1
}

rebornurl () {
mirror="https://sourceforge.net/projects/rebornos/files/latest/download"
new="$mirror"
output="rebornos.iso"
checkfile $1
}

archlabsurl () {
mirror="https://sourceforge.net/projects/archlabs-linux-minimo/files/latest/download"
new="$mirror"
output="archlabs.iso"
checkfile $1
}

namiburl () {
mirror="https://sourceforge.net/projects/namib-gnu-linux/files/latest/download"
new="$mirror"
output="namib.iso"
checkfile $1
}

obarunurl () {
mirror="https://repo.obarun.org/iso/"
x=$(curl -s $mirror | grep "<tr><td" | tail -1 | awk -F"href=\"" '{ print $2 }' | awk -F"/" '{ print $1 }')
y=$(curl -s $mirror/$x/ | grep obarun | head -1 | awk -F"href=\"" '{ print $2 }' | awk -F\" '{ print $1 }')
new="$mirror/$x/$y"
output="obarun.iso"
checkfile $1
}

archcrafturl () {
mirror="https://sourceforge.net/projects/archcraft/files/latest/download"
new="$mirror"
output="archcraft.iso"
checkfile $1
}

peuxurl () {
mirror="https://sourceforge.net/projects/peux-os/files/latest/download"
new="$mirror"
output="peuxos.iso"
checkfile $1
}

debianurl () {
x="https://cdimage.debian.org/cdimage/weekly-builds/amd64/iso-dvd/debian-testing-amd64-DVD-1.iso"
new="$x"
output="debian.iso"
notlive
checkfile $1
}

ubuntuurl () {
mirror="http://cdimage.ubuntu.com/daily-live/current/"
x=$(curl -s $mirror | grep -m1 desktop-amd64.iso | awk -F\" '{ print $2 }' | awk -F\" '{ print $1 }')
new="$mirror/$x"
output="ubuntu.iso"
checkfile $1
}

minturl () {
mirror="https://linuxmint.com/edition.php?id=302"
new=$(curl -s $mirror | grep -m2 iso | grep -m1 -vwE "Torrent" | awk -F"\"" '{ print $2 }')
output="linuxmint.iso"
checkfile $1
}

alturl () {
x="http://mirror.yandex.ru/altlinux-nightly/current/regular-cinnamon-latest-x86_64.iso"
new="$x"
output="altlinux.iso"
checkfile $1
}

zorinurl () {
mirror="https://sourceforge.net/projects/zorin-os/files/latest/download"
new="$mirror"
output="zorinos.iso"
checkfile $1
}

popurl () {
echo "Warning! Right now PopOS downloading is broken. Maybe I'll fix it later."
}

deepinurl () {
mirror="https://sourceforge.net/projects/deepin/files/latest/download"
new="$mirror"
output="deepin.iso"
notlive
checkfile $1
}

mxurl () {
mirror="https://sourceforge.net/projects/mx-linux/files/latest/download"
new="$mirror"
output="mxlinux.iso"
checkfile $1
}

knoppixurl () {
mirror="http://mirror.yandex.ru/knoppix/DVD/"
x=$(curl -s $mirror | grep -m1 "EN.iso\"" | awk -F"\"" '{ print $2 }')
new="$mirror/$x"
output="knoppix.iso"
checkfile $1
}

kaliurl () {
mirror="http://cdimage.kali.org/kali-weekly/"
x=$(curl -s $mirror | grep -m1 live-amd64.iso | awk -F">" '{ print $7 }' | awk -F"<" '{ print $1 }')
new="$mirror/$x"
output="kali.iso"
checkfile $1
}

puppyurl () {
mirror="http://distro.ibiblio.org/puppylinux/puppy-bionic/bionicpup64/"
x=$(curl -s $mirror | grep -m1 uefi.iso | awk -F">" '{ print $4 }' | awk -F"<" '{ print $1 }')
new="$mirror/$x"
output="puppy.iso"
checkfile $1
}

pureurl () {
mirror="https://pureos.net/download/"
new=$(curl -s $mirror | grep -m1 iso | awk -F"\"" '{ print $2 }')
output="pureos.iso"
checkfile $1
}

elementurl () {
mirror="https://elementary.io"
one=$(curl -s $mirror 2>&1 | grep -m1 download-link | awk -F"//" '{ print $2 }' | awk -F\" '{ print $1 }')
new="$one"
output="elementaryos.iso"
checkfile $1
}

backboxurl () {
mirror="https://bit.ly/2yNWmF3"
new="$mirror"
output="backbox.iso"
checkfile $1
}

devuanurl () {
mirror="https://www.devuan.org/get-devuan"
x=$(curl -s $mirror | grep -A5 HTTPS | grep href | awk -F"\"" '{ print $2 }')
one=$(curl -s $x | grep daed | awk -F"\"" '{ print $4 }')
two=$(curl -s $x/$one | grep desktop-live | awk -F"\"" '{ print $4 }')
three=$(curl -s $x/$one/$two | grep -m1 amd64 | awk -F"\"" '{ print $4 }')
new="$x/$one/$two/$three"
output="devuan.iso"
checkfile $1
}

jingosurl () {
mirror="https://download.jingos.com/os/JingOS-V0.9-a25ea3.iso"
new="$mirror"
output="jingos.iso"
checkfile $1
}

cutefishosurl () {
mirror="https://sourceforge.net/projects/cutefish-ubuntu/files/latest/download"
new="$mirror"
output="cutefishos.iso"
checkfile $1
}

fedoraurl () {
mirror="https://getfedora.org/en/workstation/download/"
new=$(curl -s $mirror | html2text | grep -m2 iso | awk -F "(" 'NR%2{printf "%s",$0;next;}1' | awk -F"(" '{ print $2 }' | awk -F")" '{ print $1 }')
# Legacy
#mirror="https://www.happyassassin.net/nightlies.html"
#x=$(curl -s $mirror | grep -m1 Fedora-Workstation-Live-x86_64-Rawhide | awk -F\" '{ print $4 }')
#new="$x"
output="fedora.iso"
checkfile $1
}

centosurl () {
mirror="https://www.centos.org/centos-stream/"
x=$(curl -s $mirror | grep -m1 x86_64 | awk -F"\"" '{ print $2 }' | awk -F"&amp" '{ print $1 }')
new=$(curl $x | grep https -m1)
output="centos.iso"
notlive
checkfile $1
}

suseurl () {
mirror="https://get.opensuse.org/tumbleweed/#download"
new=$(curl -s $mirror | grep -m1 Current.iso | awk -F"\"" '{ print $2 }' | awk -F"\"" '{ print $1 }')
output="opensuse.iso"
checkfile $1
}

rosaurl () {
mirror="https://www.rosalinux.ru/rosa-linux-download-links/"
new=$(curl -s $mirror | html2text | grep -m1 "64-bit ISO" | awk -F"(" '{ print $2 }' | awk -F" " '{ print $1 }')
output="rosa.iso"
checkfile $1
}

mandrivaurl () {
mirror="https://sourceforge.net/projects/openmandriva/files/latest/download"
new="$mirror"
output="mandriva.iso"
checkfile $1
}

mageiaurl () {
mirror="https://mirror.yandex.ru/mageia/iso/cauldron/"
one=$(curl -s $mirror | grep Live-Xfce-x86_64 | awk -F"\"" '{ print $2 }')
two=$(curl -s $mirror/$one | grep -m1 "x86_64.iso" | awk -F"\"" '{ print $2 }')
new="$mirror/$one/$two"
output="mageia.iso"
checkfile $1
}

clearosurl () {
mirror="https://www.clearos.com/products/purchase/clearos-downloads"
one=$(curl -s $mirror | grep -m1 ".iso\"")
two=${one%.iso*}
two=${two#*http://}.iso
link="https://$two"
new=$(curl -s "$link" | grep window.open | awk -F\' '{ print $2 }')
#new="$(cat ClearOS*iso | grep -m1 .iso | awk -F\' '{ print $2 }')"
output="clearos.iso"
#rm ${two#*http://}.iso
notlive
checkfile $1
}

almaurl () {
mirror="https://mirrors.almalinux.org"
x=$(curl -s "$mirror/isos.html" | grep x86_64 | tail -1 | awk -F"\"" '{ print $2 }')
one=$(curl -s "$mirror/$x" | grep iso | wc -l)
two=$(( $RANDOM % $one + 1 ))
three=$(curl -s "$mirror/$x" | grep iso | head -n$two | tail -1 | awk -F"\"" '{ print $2 }')
four=$(curl -s "$three/" | grep -m1 dvd.iso | html2text | grep -m1 iso | awk -F"AlmaLinux" '{ print $2 }' | awk -F".iso" '{ print $1 }')
new="$three/AlmaLinux$four.iso"
output="alma.iso"
checkfile $1
}

rockyurl () {
mirror="https://rockylinux.org/download"
new=$(curl -s $mirror | html2text | grep -m1 DVD | awk -F'(' '{ print $2 }' | awk -F')' '{ print $1 }')
output="rocky.iso"
checkfile $1
}

alpineurl () {
mirrorone="https://alpinelinux.org/downloads/"
one=$(curl -s $mirrorone | grep Current | awk -F">" '{ print $3 }' | awk -F"<" '{ print $1 }')
shortv=$(echo $one | awk -F"." '{ print $1"."$2}')
x="http://dl-cdn.alpinelinux.org/alpine/v$shortv/releases/x86_64/alpine-extended-$one-x86_64.iso"
new="$x"
output="alpine.iso"
checkfile $1
}

tinycoreurl () {
mirrorone="http://tinycorelinux.net/downloads.html"
one=$(curl -s $mirrorone | grep TinyCore-current.iso | awk -F\" '{ print $2 }')
mirror="http://tinycorelinux.net/"
new="$mirror/$one"
output="tinycore.iso"
checkfile $1
}

porteusurl () {
mirrorone="https://porteus-kiosk.org/download.html"
one=$(curl -s $mirrorone | grep "Porteus-Kiosk.*x86_64.iso" | grep -m1 public| awk -F\" '{ print $2 }')
mirror="https://porteus-kiosk.org/"
new="$mirror/$one"
output="porteus.iso"
checkfile $1
}

slitazurl () {
x="http://mirror.slitaz.org/iso/rolling/slitaz-rolling-core64.iso"
new="$x"
output="slitaz.iso"
checkfile $1
}

pclinuxosurl () {
mirror="http://ftp.nluug.nl/pub/os/Linux/distr/pclinuxos/pclinuxos/live-cd/64bit/"
x="pclinuxos$(curl -s $mirror | grep -m1 .iso | awk -F"pclinuxos" '{ print $2 }' | awk -F\" '{ print $1 }')"
new="$mirror$x"
output="pclinuxos.iso"
checkfile $1
}

voidurl () {
mirror="https://alpha.de.repo.voidlinux.org/live/current/"
x=$(curl -s $mirror | grep "live" | grep -m1 "x86_64" | awk -F">" '{ print $2 }' | awk -F"<" '{ print $1 }')
new="$mirror/$x"
output="void.iso"
checkfile $1
}

fourmurl () {
mirror="https://sourceforge.net/projects/linux4m/files/latest/download"
new="$mirror"
output="4mlinux.iso"
checkfile $1
}

kaosurl () {
mirror="https://sourceforge.net/projects/kaosx/files/latest/download"
new="$mirror"
output="kaos.iso"
checkfile $1
}

clearurl () {
mirror="https://clearlinux.org/downloads"
x=$(curl -s $mirror | grep live | grep -m1 iso | awk -F\" '{ print $2 }')
new="$x"
output="clearlinux.iso"
checkfile $1
}

dragoraurl () {
mirror="http://rsync.dragora.org/current/iso/beta/"
echo "Unfortunately, current Dragora mirror ($mirror) is unavailable"
#x=$(curl -s $mirror | grep -m1 x86_64 | awk -F\' '{ print $2 }')
#new="$mirror$x"
#output="dragora.iso"
#checkfile $1
}

slackwareurl () {
mirror="https://mirrors.slackware.com/slackware/slackware-iso/"
x=$(curl -s $mirror | grep slackware64 | tail -1 | awk -F"slack" '{ print $2 }' | awk -F"/" '{ print $1 }')
other="slack$x"
y=$(curl -s "$mirror/$other/" | grep dvd.iso | head -1 | awk -F"slack" '{ print $2 }' | awk -F\" '{ print $1 }')
new="$mirror"; new+="$other"; new+="/slack"; new+="$y"
echo "new=$new"
output="slackware.iso"
checkfile $1
}

adelieurl () {
mirror="https://www.adelielinux.org/download/"
x=$(curl -s $mirror | html2text | grep "Listing]" | awk -F"(" '{ print $2 }' | awk -F")" '{ print $1 }')
y=$(curl -s $x | grep live-mate | grep -m1 "x86_64" | awk -F"\"" '{ print $2 }')
new="$x$y"
output="adelie.iso"
checkfile $1
}

plopurl () {
mirror="https://www.plop.at/en/ploplinux/downloads/full.html"
x="$(curl -s $mirror | grep x86_64.iso | head -1 | awk -F"https://" '{ print $2 }' | awk -F".iso" '{ print $1 }')"
new="https://$x.iso"
output="plop.iso"
checkfile $1
}

solusurl () {
mirror="https://getsol.us/download/"
echo "Unfortunately, current Solus mirror ($mirror) is unavailable"
#x=$(curl -s $mirror | grep -m1 iso | awk -F\" '{ print $2 }')
#new="$x"
#output="solus.iso"
#checkfile $1
}

gentoourl () {
mirror="https://gentoo.c3sl.ufpr.br//releases/amd64/autobuilds"
one=$(curl -s "$mirror/latest-iso.txt" | grep "admin" | awk '{ print $1 }')
new="$mirror/$one"
output="gentoo.iso"
notlive
checkfile $1
}

sabayonurl () {
mirror="https://www.sabayon.org/desktop/"
echo "Unfortunately, current Sabayon mirror ($mirror) is unavailable"
#x=$(curl -s $mirror | grep GNOME.iso | head -1 | awk -F"http://" '{ print $2 }' | awk -F\" '{ print $1 }')
#new="http://$x"
#output="sabayon.iso"
#checkfile $1
}

calcurl () {
mirror="http://mirror.yandex.ru/calculate/nightly/"
x=$(curl -s $mirror | grep "<a" | tail -1 | awk -F">" '{ print $2 }' | awk -F"<" '{ print $1 }')
mirror+=$x
x=$(curl -s $mirror | grep -m1 cldc | awk -F\" '{ print $2 }')
new="$mirror$x"
output="calculate.iso"
checkfile $1
}

nixurl () {
mirror="https://channels.nixos.org/nixos-unstable"
saved=$(curl -sL $mirror)
dir=$(echo $saved | awk -F"nixos" '{ print $26 }')
file=$(echo $saved | awk -F"nixos" '{ print $28 }' | awk -F".iso" '{ print $1 }')
result="nixos"; result+=$dir; result+="nixos"; result+=$file
x="https://releases.nixos.org/nixos/unstable/$result.iso"
new="$x"
output="nixos.iso"
notlive
checkfile $1
}

guixurl () {
mirror="https://guix.gnu.org/en/download/"
x=$(curl -s $mirror | grep ".iso" | awk -F"https://" '{ print $2 }' | awk -F\" '{ print $1 }')
new="https://$x"
output="guix.iso.xz"
notlive
checkfile $1
[ -f "guix.iso" ] && echo "Please wait, unpacking guix..." && xz -k -d -v ./guix*xz && mv guix*iso guix.iso
}

rancherurl () {
mirror="https://github.com/rancher/os/releases/latest"
x=$(curl -s -L $mirror | grep -m1 rancheros.iso | awk -F\" '{ print $2 }')
new="https://github.com$x"
output="rancheros.iso"
checkfile $1
}

k3osurl () {
mirror="https://github.com/rancher/k3os/releases/latest"
x=$(curl -s -L $mirror | grep -m1 k3os-amd64.iso | awk -F\" '{ print $2 }')
new="https://github.com$x"
output="k3os.iso"
checkfile $1
}

flatcarurl () {
mirror="https://alpha.release.flatcar-linux.net/amd64-usr/current/flatcar_production_iso_image.iso"
new="$mirror"
output="flatcar.iso"
checkfile $1
}

silverblueurl () {
mirror="https://silverblue.fedoraproject.org/download"
x=$(curl -s $mirror | grep -m1 x86_64 | awk -F\' '{ print $2 }')
new="$x"
output="silverblue.iso"
checkfile $1
}

photonurl () {
mirror="https://github.com/vmware/photon/wiki/Downloading-Photon-OS"
x=$(curl -s $mirror | grep -m1 "Full ISO" | awk -F\" '{ print $2 }')
new="$x"
output="photonos.iso"
notlive
checkfile $1
}

coreosurl () {
mirror="https://builds.coreos.fedoraproject.org/streams/next.json"
x=$(curl -s $mirror | grep iso | grep location | awk -F\" '{ print $4 }')
new="$x"
output="coreos.iso"
checkfile $1
}

freebsdurl () {
mirror="https://www.freebsd.org/where/"
x=$(curl -s $mirror | grep -m1 "amd64/amd64" | awk -F\" '{ print $2 }')
one=$(curl -s $x | grep -m1 dvd1 | awk -F"FreeBSD" '{ print $2 }' | awk -F\" '{ print $1 }')
new=$x; new+="FreeBSD"; new+=$one; 
output="freebsd.iso"
notlinux
checkfile $1
}

netbsdurl () {
mirror="https://www.netbsd.org/" 
#mirror="https://wiki.netbsd.org/ports/amd64/"
new=$(curl -s $mirror | grep -m1 "CD" | awk -F\" '{ print $4 }')
output="netbsd.iso"
notlinux
checkfile $1
}

openbsdurl () {
mirror="https://www.openbsd.org/faq/faq4.html"
new=$(curl -s $mirror | grep -m1 -e 'iso.*amd64' | awk -F\" '{ print $2 }')
output="openbsd.iso"
notlinux
checkfile $1
}

ghostbsdurl () {
mirror="http://download.fr.ghostbsd.org/development/amd64/latest/"
x=$(curl -s $mirror | grep ".iso<" | tail -1 | awk -F\" '{ print $2 }')
new="$mirror$x"
output="ghostbsd.iso"
notlinux
checkfile $1
}

hellosystemurl () {
# https://github.com/helloSystem/ISO/releases/download/r0.5.0/hello-0.5.0_0E223-FreeBSD-12.2-amd64.iso
mirror="https://github.com/helloSystem/ISO/releases/latest"
x=$(curl -s -L $mirror | grep FreeBSD | grep -m1 iso | awk -F\" '{ print $2 }')
new="https://github.com$x"
output="hellosystem.iso"
notlinux
checkfile $1
}

indianaurl () {
mirror="https://www.openindiana.org/download/"
x=$(curl -s $mirror | grep "Live DVD" | awk -F"http://" '{ print $2 }' | awk -F\" '{ print $1 }')
new="http://$x"
output="openindiana.iso"
notlinux
checkfile $1
}

minixurl () {
mirror="https://wiki.minix3.org/doku.php?id=www:download:start"
x=$(curl -s $mirror | grep -m1 iso.bz2 | awk -F"http://" '{ print $2 }' | awk -F\" '{ print $1 }')
new="http://$x"
output="minix.iso.bz2"
if [ "$1" == "filesize" ]; then
	notlinux
	notlive
	getsize
	else
	[ ! -f $output ] && wgetcmd && echo "Please wait, unpacking minix..." && bzip2 -k -d $output || echo "Minix already downloaded."
fi
}

haikuurl () {
mirror="https://download.haiku-os.org/nightly-images/x86_64/"
x=$(curl -s $mirror | grep -m1 zip | awk -F\" '{ print $2 }')
new="$x"
output="haiku.zip"
if [ "$1" == "filesize" ]; then 
	notlinux
	getsize
	else
	[ ! -f $output ] && wgetcmd && echo "Please wait, unzipping haiku..." && unzip haiku.zip && rm ReadMe.md && mv haiku*iso haiku.iso || echo "Haiku already downloaded."
fi
}

menueturl () {
mirror="http://www.menuetos.be/download.php?CurrentMenuetOS"
new="$mirror"
output="menuetos.zip"
if [ "$1" == "filesize" ]; then 
	notlinux
	getsize
	else
	[ ! -f $output ] && wgetcmd && echo "Wait, unzipping menuetos..." && unzip menuetos.zip && mv M64*.IMG menuetos.img || echo "Menuet already downloaded."
fi
}

kolibrios () {
mirror="http://builds.kolibrios.org/eng/latest-iso.7z"
new="$mirror"
output="kolibrios.7z"
if [ "$1" == "filesize" ]; then
	notlinux
	getsize
	else
	[ ! -f $output ] && wgetcmd && echo "Un7zipping kolibri..." && 7z x kolibrios.7z && mv kolibri.iso kolibrios.iso || echo "Kolibri already downloaded."
fi
}

reactosurl () {
mirror="https://sourceforge.net/projects/reactos/files/latest/download"
new="$mirror"
output="reactos.zip"
if [ "$1" == "filesize" ]; then 
	notlinux
	getsize
	else
[ ! -f $output ] && wgetcmd && echo "Please wait, unzipping reactos..." && unzip reactos.zip && mv React*iso reactos.iso || echo "Menuet already downloaded."
fi
}

freedosurl () {
#mirror="https://sourceforge.net/projects/freedos/files/latest/download"
mirror="https://www.freedos.org/download/download/FD12CD.iso"
new="$mirror"
output="freedos.iso"
notlinux
checkfile $1
}

netbootxyz () {
mirror="https://boot.netboot.xyz/ipxe/netboot.xyz.iso"
new="$mirror"
output="netboot.xyz.iso"
checkfile $1
}

netbootsal () {
mirror="http://boot.salstar.sk/ipxe/ipxe.iso"
new="$mirror"
output="ipxe.iso"
checkfile $1
}

# this one is currently broken
netbootipxe () {
#mirror="http://cloudboot.nchc.org.tw/cloudboot/cloudboot_img/cloudboot_1.0.iso"
mirror="http://boot.ipxe.org/ipxe.iso"
new="$mirror"
output="bootipxe.iso"
checkfile $1
}
