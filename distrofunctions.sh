#!/bin/bash

# Download functions and commands

wgetcmd () { 
echo "Downloading $new to $output"
wget -q --show-progress -c $new -O $output -o /dev/null
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

# Update latest distro URL functions

archurl () {
mirror="http://mirrors.evowise.com/archlinux/iso/latest/"
x=$(curl -s $mirror | grep -m1 archlinux- | awk -F".iso" '{ print $1 }' | awk -F\" '{ print $2 }');
new="$mirror/$x.iso"
output="archlinux.iso"
[ "$1" == "filesize" ] && getsize || wgetcmd
}

manjarourl () {
mirror="https://manjaro.org/downloads/official/xfce/"
x=$(curl -s $mirror | grep -m1 "manjaro/storage/xfce" | awk -F\" '{ print $2 }')
new="$x"
output="manjaro.iso"
[ "$1" == "filesize" ] && getsize || wgetcmd
}

arcourl () {
mirror="https://bike.seedhost.eu/arcolinux/iso/"
x=$(curl -s $mirror | grep -m1 arcolinux- | awk -F">" '{ print $3 }' | awk -F"<" '{ print $1 }')
new="$mirror/$x"
output="arcolinux.iso"
[ "$1" == "filesize" ] && getsize || wgetcmd
}

archbangurl () {
mirror="https://sourceforge.net/projects/archbang/files/latest/download"
new="$mirror"
output="archbang.iso"
[ "$1" == "filesize" ] && getsize || wgetcmd
}

parabolaurl () {
mirror="https://wiki.parabola.nu/Get_Parabola"
x=$(curl -s $mirror | grep systemd | grep lxde | grep ".iso" | grep Web | awk -F"redirector" '{ print $2 }' | awk -F\" '{ print $1 }')
new="https://redirector$x"
output="parabola.iso"
[ "$1" == "filesize" ] && getsize || wgetcmd
}

debianurl () {
x="https://cdimage.debian.org/cdimage/weekly-builds/amd64/iso-dvd/debian-testing-amd64-DVD-1.iso"
new="$x"
output="debian.iso"
[ "$1" == "filesize" ] && getsize || notlive; wgetcmd
}

ubuntuurl () {
mirror="http://cdimage.ubuntu.com/daily-live/current/"
x=$(curl -s $mirror | grep -m1 desktop-amd64.iso | awk -F\" '{ print $2 }' | awk -F\" '{ print $1 }')
new="$mirror/$x"
output="ubuntu.iso"
[ "$1" == "filesize" ] && getsize || wgetcmd
}

minturl () {
mirror="https://linuxmint.com/download.php"
x=$(curl -s $mirror | grep "latest release" | awk -F"Mint" '{ print $2 }' | awk -F"," '{ print $1 }' | xargs)
new="http://mirrors.evowise.com/linuxmint/stable/$x/linuxmint-$x-cinnamon-64bit.iso"
output="linuxmint.iso"
[ "$1" == "filesize" ] && getsize || wgetcmd
}

alturl () {
x="http://mirror.yandex.ru/altlinux-nightly/current/regular-cinnamon-latest-x86_64.iso"
new="$x"
output="altlinux.iso"
[ "$1" == "filesize" ] && getsize || wgetcmd
}

zorinurl () {
mirror="https://sourceforge.net/projects/zorin-os/files/latest/download"
new="$mirror"
output="zorinos.iso"
[ "$1" == "filesize" ] && getsize || wgetcmd
}

solusurl () {
mirror="https://getsol.us/download/"
x=$(curl -s $mirror | grep -m1 iso | awk -F\" '{ print $2 }')
new="$x"
output="solus.iso"
[ "$1" == "filesize" ] && getsize || wgetcmd
}

popurl () {
mirror="https://pop-iso.sfo2.cdn.digitaloceanspaces.com"
x=$(curl -s $mirror | html2text | grep intel_5 | tail -2 | head -1 | awk -F".iso" '{ print $1 }')
v=$(echo $x | awk -F"_" '{ print $2 }')
arch=$(echo $x | awk -F"_" '{ print $3 }')
new="$mirror/$v/$arch/$x.iso"
output="popos.iso"
[ "$1" == "filesize" ] && getsize || wgetcmd
}

deepinurl () {
mirror="https://sourceforge.net/projects/deepin/files/latest/download"
new="$mirror"
output="deepin.iso"
[ "$1" == "filesize" ] && getsize || notlive; wgetcmd
}

mxurl () {
mirror="https://sourceforge.net/projects/mx-linux/files/latest/download"
new="$mirror"
output="mxlinux.iso"
[ "$1" == "filesize" ] && getsize || wgetcmd
}

knoppixurl () {
mirror="http://mirror.yandex.ru/knoppix/DVD/"
x=$(curl -s $mirror | grep -m1 EN.iso | awk -F">" '{ print $2 }' | awk -F"<" '{ print $1 }')
new="$mirror/$x"
output="knoppix.iso"
[ "$1" == "filesize" ] && getsize || wgetcmd
}

kaliurl () {
mirror="http://cdimage.kali.org/kali-weekly/"
x=$(curl -s $mirror | grep -m1 live-amd64.iso | awk -F">" '{ print $7 }' | awk -F"<" '{ print $1 }')
new="$mirror/$x"
output="kali.iso"
[ "$1" == "filesize" ] && getsize || wgetcmd
}

puppyurl () {
mirror="http://distro.ibiblio.org/puppylinux/puppy-bionic/bionicpup64/"
x=$(curl -s $mirror | grep -m1 uefi.iso | awk -F">" '{ print $4 }' | awk -F"<" '{ print $1 }')
new="$mirror/$x"
output="puppy.iso"
[ "$1" == "filesize" ] && getsize || wgetcmd
}

pureurl () {
mirror="http://downloads.pureos.net/amber/live/gnome/"
dd=$(date +%Y)
one=$(curl -s $mirror | grep $dd | tail -1 | awk -F\" '{ print $2 }')
two=$(curl -s $mirror/$one | grep "hybrid.iso<" | awk -F\" '{ print $2 }')
new="$mirror/$one/$two"
output="pureos.iso"
[ "$1" == "filesize" ] && getsize || wgetcmd
}

fedoraurl () {
mirror="https://www.happyassassin.net/nightlies.html"
x=$(curl -s $mirror | grep -A100 "Fedora Rawhide" | grep "Workstation" | grep x86_64 | grep passedlink | awk -F\" '{ print $4 }')
new="$x"
output="fedora.iso"
[ "$1" == "filesize" ] && getsize || notlive; wgetcmd
}

centosurl () {
mirrorone="https://www.centos.org/centos-stream/"
one=$(curl -s $mirrorone | grep x86_64 | awk -F\" '{ print $2 }' | awk -F"/" '{ print $5 }')
mirror="http://mirror.yandex.ru/centos/$one/isos/x86_64/"
x=$(curl -s $mirror | grep -m1 dvd1 | awk -F\" '{ print $2 }' | awk -F\" '{ print $1 }')
new="$mirror/$x"
output="centos.iso"
[ "$1" == "filesize" ] && getsize || notlive; wgetcmd
}

suseurl () {
mirrorone="https://software.opensuse.org/distributions/leap"
one=$(curl -s $mirrorone | grep -m1 "openSUSE Leap" | awk -F"Leap" '{ print $2 }' | awk -F"<" '{ print $1 }' | xargs)
mirror="http://mirror.yandex.ru/opensuse/distribution/leap/$one/iso/"
x=$(curl -s $mirror | grep -m1 "x86_64.iso" | awk -F\" '{ print $2 }')
new="$mirror/$x"
output="opensuse.iso"
[ "$1" == "filesize" ] && getsize || wgetcmd
}

rosaurl () {
mirror="https://www.rosalinux.ru/rosa-linux-download-links/"
x="$(curl -s $mirror | grep -A3 -m1 KDE4 | grep 64-bit | awk -F\" '{ print $4 }')"
new="$x"
output="rosa.iso"
[ "$1" == "filesize" ] && getsize || wgetcmd
}

mandrivaurl () {
mirror="https://sourceforge.net/projects/openmandriva/files/latest/download"
new="$mirror"
output="mandriva.iso"
[ "$1" == "filesize" ] && getsize || wgetcmd
}

mageiaurl () {
mirror="http://mirror.yandex.ru/mageia/iso/cauldron/"
one=$(curl -s $mirror | grep "href=\"mageia" | awk -F">" '{ print $2 }' | awk -F"<" '{ print $1 }')
two=$(curl -s $mirror/$one | grep Plasma | awk -F">" '{ print $2 }' | awk -F"<" '{ print $1 }')
x=$(curl -s $mirror/$one/$two | grep ".iso\"" | awk -F\" '{ print $2 }')
new="$mirror/$one/$two/$x"
output="mageia.iso"
[ "$1" == "filesize" ] && getsize || wgetcmd
}

clearurl () {
mirror="https://www.clearos.com/products/purchase/clearos-downloads"
one=$(curl -s $mirror | grep -m1 ".iso\"")
two=${one%.iso*}
curl -s ${two#*http://}.iso
new="$(cat ClearOS*iso | grep -m1 .iso | awk -F\' '{ print $2 }')"
output="clearos.iso"
rm ${two#*http://}.iso
[ "$1" == "filesize" ] && getsize || notlive; wgetcmd
}

alpineurl () {
mirrorone="https://alpinelinux.org/downloads/"
one=$(curl -s $mirrorone | grep Current | awk -F">" '{ print $3 }' | awk -F"<" '{ print $1 }')
shortv=$(echo $one | awk -F"." '{ print $1"."$2}')
x="http://dl-cdn.alpinelinux.org/alpine/v$shortv/releases/x86_64/alpine-extended-$one-x86_64.iso"
new="$x"
output="alpine.iso"
[ "$1" == "filesize" ] && getsize || wgetcmd
}

tinycoreurl () {
mirrorone="http://tinycorelinux.net/downloads.html"
one=$(curl -s $mirrorone | grep TinyCore-current.iso | awk -F\" '{ print $2 }')
mirror="http://tinycorelinux.net/"
new="$mirror/$one"
output="tinycore.iso"
[ "$1" == "filesize" ] && getsize || wgetcmd
}

porteusurl () {
mirrorone="https://porteus-kiosk.org/download.html"
one=$(curl -s $mirrorone | grep "Porteus-Kiosk.*x86_64.iso" | grep -m1 public| awk -F\" '{ print $2 }')
mirror="https://porteus-kiosk.org/"
new="$mirror/$one"
output="porteus.iso"
[ "$1" == "filesize" ] && getsize || wgetcmd
}

slitazurl () {
x="http://mirror.slitaz.org/iso/rolling/slitaz-rolling-core64.iso"
new="$x"
output="slitaz.iso"
[ "$1" == "filesize" ] && getsize || wgetcmd
}

pclinuxosurl () {
mirror="http://ftp.nluug.nl/pub/os/Linux/distr/pclinuxos/pclinuxos/live-cd/64bit/"
x="pclinuxos$(curl -s $mirror | grep -m1 .iso | awk -F"pclinuxos" '{ print $2 }' | awk -F\" '{ print $1 }')"
new="$mirror$x"
output="pclinuxos.iso"
[ "$1" == "filesize" ] && getsize || wgetcmd
}

voidurl () {
mirror="https://alpha.de.repo.voidlinux.org/live/current/"
x=$(curl -s $mirror | grep "live" | grep -m1 "x86_64" | awk -F">" '{ print $2 }' | awk -F"<" '{ print $1 }')
new="$mirror/$x"
output="void.iso"
[ "$1" == "filesize" ] && getsize || wgetcmd
}

fourmurl () {
mirror="https://sourceforge.net/projects/linux4m/files/latest/download"
new="$mirror"
output="4mlinux.iso"
[ "$1" == "filesize" ] && getsize || wgetcmd
}

kaosurl () {
mirror="https://sourceforge.net/projects/kaosx/files/latest/download"
new="$mirror"
output="kaos.iso"
[ "$1" == "filesize" ] && getsize || wgetcmd
}

clearurl () {
mirror="https://clearlinux.org/downloads"
x=$(curl -s $mirror | grep live | grep -m1 iso | awk -F\" '{ print $2 }')
new="$x"
output="clearlinux.iso"
[ "$1" == "filesize" ] && getsize || wgetcmd
}

dragoraurl () {
mirror="http://rsync.dragora.org/current/iso/beta/"
x=$(curl -s $mirror | grep -m1 x86_64 | awk -F\' '{ print $2 }')
new="$mirror$x"
output="dragora.iso"
[ "$1" == "filesize" ] && getsize || wgetcmd
}

gentoourl () {
mirror="https://gentoo.c3sl.ufpr.br//releases/amd64/autobuilds"
one=$(curl -s "$mirror/latest-iso.txt" | grep "admin" | awk '{ print $1 }')
new="$mirror/$one"
output="gentoo.iso"
[ "$1" == "filesize" ] && getsize || notlive; wgetcmd
}

sabayonurl () {
x="http://sabayonlinux.mirror.garr.it/mirrors/sabayonlinux//iso/daily/Sabayon_Linux_DAILY_amd64_Xfce.iso"
new="$x"
output="sabayon.iso"
[ "$1" == "filesize" ] && getsize || wgetcmd
}

calcurl () {
mirror="https://mirror.yandex.ru/calculate/nightly/"
x=$(curl -s $mirror | grep "<a" | tail -1 | awk -F">" '{ print $2 }' | awk -F"<" '{ print $1 }')
mirror+=$x
x=$(curl -s $mirror | grep -m1 cldc | awk -F\" '{ print $2 }')
new="$mirror/$x"
output="calculate.iso"
[ "$1" == "filesize" ] && getsize || wgetcmd
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
[ "$1" == "filesize" ] && getsize || notlive; wgetcmd
}

guixurl () {
mirror="https://guix.gnu.org/en/download/"
x=$(curl -s $mirror | grep ".iso" | awk -F"https://" '{ print $2 }' | awk -F\" '{ print $1 }')
new="https://$x"
output="guix.iso.xz"
[ "$1" == "filesize" ] && getsize || notlive; wgetcmd
[ -f "guix.iso" ] && echo "Please wait, unpacking guix..." && xz -k -d -v ./guix*xz && mv guix*iso guix.iso
}

rancherurl () {
mirror="https://github.com/rancher/os/releases/latest"
x=$(curl -s -L $mirror | grep -m1 rancheros.iso | awk -F\" '{ print $2 }')
new="https://github.com$x"
output="rancheros.iso"
[ "$1" == "filesize" ] && getsize || wgetcmd
}

k3osurl () {
mirror="https://github.com/rancher/k3os/releases/latest"
x=$(curl -s -L $mirror | grep -m1 k3os-amd64.iso | awk -F\" '{ print $2 }')
new="https://github.com$x"
output="k3os.iso"
[ "$1" == "filesize" ] && getsize || wgetcmd
}

flatcarurl () {
mirror="https://alpha.release.flatcar-linux.net/amd64-usr/current/flatcar_production_iso_image.iso"
new="$mirror"
output="flatcar.iso"
[ "$1" == "filesize" ] && getsize || wgetcmd
}

silverblueurl () {
mirror="https://silverblue.fedoraproject.org/download"
x=$(curl -s $mirror | grep -m1 x86_64 | awk -F\' '{ print $2 }')
new="$x"
output="silverblue.iso"
[ "$1" == "filesize" ] && getsize || wgetcmd
}

photonurl () {
mirror="https://github.com/vmware/photon/wiki/Downloading-Photon-OS"
x=$(curl -s $mirror | grep -m1 "Full ISO" | awk -F\" '{ print $2 }')
new="$x"
output="photonos.iso"
[ "$1" == "filesize" ] && getsize || notlive; wgetcmd
}

coreosurl () {
mirror="https://builds.coreos.fedoraproject.org/streams/next.json"
x=$(curl -s $mirror | grep iso | grep location | awk -F\" '{ print $4 }')
new="$x"
output="coreos.iso"
[ "$1" == "filesize" ] && getsize || wgetcmd
}

freebsdurl () {
mirror="https://www.freebsd.org/where.html"
x=$(curl -s $mirror | grep -m1 "amd64/amd64" | awk -F\" '{ print $2 }')
one=$(curl -s $x | grep -m1 dvd1 | awk -F"FreeBSD" '{ print $2 }' | awk -F\" '{ print $1 }')
new=$x; new+="FreeBSD"; new+=$one; output="freebsd.iso"
[ "$1" == "filesize" ] && getsize || notlinux; wgetcmd
}

indianaurl () {
mirror="https://www.openindiana.org/download/"
x=$(curl -s $mirror | grep "Live DVD" | awk -F"http://" '{ print $2 }' | awk -F\" '{ print $1 }')
new="http://$x"
output="openindiana.iso"
[ "$1" == "filesize" ] && getsize || notlinux; wgetcmd
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
