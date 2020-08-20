#!/bin/bash

# Download functions and commands

wgetcmd () { wget -c $new; }

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
new="$mirror/$x.iso -O archlinux.iso"
wgetcmd
}

manjarourl () {
mirror="https://manjaro.org/downloads/official/xfce/"
x=$(curl -s $mirror | grep -m1 "manjaro/storage/xfce" | awk -F\" '{ print $2 }')
new="$x -O manjaro.iso"
wgetcmd
}

arcourl () {
mirror="https://bike.seedhost.eu/arcolinux/iso/"
x=$(curl -s $mirror | grep -m1 arcolinux- | awk -F">" '{ print $3 }' | awk -F"<" '{ print $1 }')
new="$mirror/$x -O arcolinux.iso"
wgetcmd
}

archbangurl () {
mirror="https://sourceforge.net/projects/archbang/files/latest/download"
new="$mirror -O archbang.iso"
wgetcmd
}

parabolaurl () {
mirror="https://wiki.parabola.nu/Get_Parabola"
x=$(curl -s $mirror | grep systemd | grep lxde | grep ".iso" | grep Web | awk -F"redirector" '{ print $2 }' | awk -F\" '{ print $1 }')
new="https://redirector$x -O parabola.iso"
wgetcmd
}

debianurl () {
x="https://cdimage.debian.org/cdimage/weekly-builds/amd64/iso-dvd/debian-testing-amd64-DVD-1.iso"
new="$x -O debian.iso"
wgetcmd
}

ubuntuurl () {
mirror="http://cdimage.ubuntu.com/daily-live/current/"
x=$(curl $mirror | grep -m1 desktop-amd64.iso | awk -F\" '{ print $2 }' | awk -F\" '{ print $1 }')
new="$mirror/$x -O ubuntu.iso"
wgetcmd
}

minturl () {
mirror="https://linuxmint.com/download.php"
x=$(curl $mirror | grep "latest release" | awk -F"Mint" '{ print $2 }' | awk -F"," '{ print $1 }' | xargs)
new="http://mirrors.evowise.com/linuxmint/stable/$x/linuxmint-$x-cinnamon-64bit.iso -O linuxmint.iso"
wgetcmd
}

alturl () {
x="http://mirror.yandex.ru/altlinux-nightly/current/regular-cinnamon-latest-x86_64.iso"
new="$x -O altlinux.iso"
wgetcmd
}

zorinurl () {
mirror="https://sourceforge.net/projects/zorin-os/files/latest/download"
new="$mirror -O zorinos.iso"
wgetcmd
}

solusurl () {
mirror="https://getsol.us/download/"
x=$(curl -s $mirror | grep -m1 iso | awk -F\" '{ print $2 }')
new="$x -O solus.iso"
wgetcmd
}

popurl () {
mirror="https://pop-iso.sfo2.cdn.digitaloceanspaces.com"
x=$(curl -s $mirror | html2text | grep intel_5 | tail -2 | head -1 | awk -F".iso" '{ print $1 }')
v=$(echo $x | awk -F"_" '{ print $2 }')
arch=$(echo $x | awk -F"_" '{ print $3 }')
new="$mirror/$v/$arch/$x.iso -O popos.iso"
wgetcmd
}

deepinurl () {
mirror="https://sourceforge.net/projects/deepin/files/latest/download"
new="$mirror -O deepin.iso"
notlive
wgetcmd
}

mxurl () {
mirror="https://sourceforge.net/projects/mx-linux/files/latest/download"
new="$mirror -O mxlinux.iso"
wgetcmd
}

knoppixurl () {
mirror="http://mirror.yandex.ru/knoppix/DVD/"
x=$(curl -s $mirror | grep -m1 EN.iso | awk -F">" '{ print $2 }' | awk -F"<" '{ print $1 }')
new="$mirror/$x -O knoppix.iso"
wgetcmd
}

kaliurl () {
mirror="http://cdimage.kali.org/kali-weekly/"
x=$(curl -s $mirror | grep -m1 live-amd64.iso | awk -F">" '{ print $7 }' | awk -F"<" '{ print $1 }')
new="$mirror/$x -O kali.iso"
wgetcmd
}

puppyurl () {
mirror="http://distro.ibiblio.org/puppylinux/puppy-bionic/bionicpup64/"
x=$(curl -s $mirror | grep -m1 uefi.iso | awk -F">" '{ print $4 }' | awk -F"<" '{ print $1 }')
new="$mirror/$x -O puppy.iso"
wgetcmd
}

pureurl () {
mirror="http://downloads.pureos.net/amber/live/gnome/"
dd=$(date +%Y)
one=$(curl -s $mirror | grep $dd | tail -1 | awk -F\" '{ print $2 }')
two=$(curl -s $mirror/$one | grep "hybrid.iso<" | awk -F\" '{ print $2 }')
new="$mirror/$one/$two -O pureos.iso"
wgetcmd
}

fedoraurl () {
mirror="https://www.happyassassin.net/nightlies.html"
x=$(curl -s $mirror | grep -A7 "Fedora Rawhide" | grep .iso | awk -F\" '{ print $4 }')
new="$x -O fedora.iso"
notlive
wgetcmd
}

centosurl () {
mirrorone="https://www.centos.org/centos-stream/"
one=$(curl -s $mirrorone | grep x86_64 | awk -F\" '{ print $2 }' | awk -F"/" '{ print $5 }')
mirror="http://mirror.yandex.ru/centos/$one/isos/x86_64/"
x=$(curl -s $mirror | grep -m1 dvd1 | awk -F\" '{ print $2 }' | awk -F\" '{ print $1 }')
new="$mirror/$x -O centos.iso"
notlive
wgetcmd
}

suseurl () {
mirrorone="https://software.opensuse.org/distributions/leap"
one=$(curl -s $mirrorone | grep -m1 "openSUSE Leap" | awk -F"Leap" '{ print $2 }' | awk -F"<" '{ print $1 }' | xargs)
mirror="http://mirror.yandex.ru/opensuse/distribution/leap/$one/iso/"
x=$(curl -s $mirror | grep -m1 "x86_64.iso" | awk -F\" '{ print $2 }')
new="$mirror/$x -O opensuse.iso"
wgetcmd
}

rosaurl () {
mirror="https://www.rosalinux.ru/rosa-linux-download-links/"
x="$(curl -s $mirror | grep -A3 -m1 KDE4 | grep 64-bit | awk -F\" '{ print $4 }')"
new="$x -O rosa.iso"
wgetcmd
}

mandrivaurl () {
mirror="https://sourceforge.net/projects/openmandriva/files/latest/download"
new="$mirror -O mandriva.iso"
wgetcmd
}

mageiaurl () {
mirror="http://mirror.yandex.ru/mageia/iso/cauldron/"
one=$(curl -s $mirror | grep "href=\"mageia" | awk -F">" '{ print $2 }' | awk -F"<" '{ print $1 }')
two=$(curl -s $mirror/$one | grep Plasma | awk -F">" '{ print $2 }' | awk -F"<" '{ print $1 }')
x=$(curl -s $mirror/$one/$two | grep ".iso\"" | awk -F\" '{ print $2 }')
new="$mirror/$one/$two/$x -O mageia.iso"
wgetcmd
}

clearurl () {
mirror="https://www.clearos.com/products/purchase/clearos-downloads"
one=$(curl -s $mirror | grep -m1 ".iso\"")
two=${one%.iso*}
curl -s ${two#*http://}.iso
new="$(cat ClearOS*iso | grep -m1 .iso | awk -F\' '{ print $2 }') -O clearos.iso"
rm ${two#*http://}.iso
notlive
wgetcmd
}

alpineurl () {
mirrorone="https://alpinelinux.org/downloads/"
one=$(curl -s $mirrorone | grep Current | awk -F">" '{ print $3 }' | awk -F"<" '{ print $1 }')
shortv=$(echo $one | awk -F"." '{ print $1"."$2}')
x="http://dl-cdn.alpinelinux.org/alpine/v$shortv/releases/x86_64/alpine-extended-$one-x86_64.iso"
new="$x -O alpine.iso"
wgetcmd
}

tinycoreurl () {
mirrorone="http://tinycorelinux.net/downloads.html"
one=$(curl -s $mirrorone | grep TinyCore-current.iso | awk -F\" '{ print $2 }')
mirror="http://tinycorelinux.net/"
new="$mirror/$one -O tinycore.iso"
wgetcmd
}

porteusurl () {
mirrorone="https://porteus-kiosk.org/download.html"
one=$(curl -s $mirrorone | grep "Porteus-Kiosk.*x86_64.iso" | grep -m1 public| awk -F\" '{ print $2 }')
mirror="https://porteus-kiosk.org/"
new="$mirror/$one -O porteus.iso"
wgetcmd
}

slitazurl () {
x="http://mirror.slitaz.org/iso/rolling/slitaz-rolling-core64.iso"
new="$x -O slitaz.iso"
wgetcmd
}

pclinuxosurl () {
mirror="http://ftp.nluug.nl/pub/os/Linux/distr/pclinuxos/pclinuxos/live-cd/64bit/"
x="pclinuxos$(curl -s $mirror | grep -m1 .iso | awk -F"pclinuxos" '{ print $2 }' | awk -F\" '{ print $1 }')"
new="$mirror$x -O pclinuxos.iso"
wgetcmd
}

voidurl () {
mirror="https://alpha.de.repo.voidlinux.org/live/current/"
x=$(curl -s $mirror | grep "live" | grep -m1 "x86_64" | awk -F">" '{ print $2 }' | awk -F"<" '{ print $1 }')
new="$mirror/$x -O void.iso"
wgetcmd
}

fourmurl () {
mirror="https://sourceforge.net/projects/linux4m/files/latest/download"
new="$mirror -O 4mlinux.iso"
wgetcmd
}

kaosurl () {
mirror="https://sourceforge.net/projects/kaosx/files/latest/download"
new="$mirror -O kaos.iso"
wgetcmd
}

clearurl () {
mirror="https://clearlinux.org/downloads"
x=$(curl -s $mirror | grep live | grep -m1 iso | awk -F\" '{ print $2 }')
new="$x -O clearlinux.iso"
wgetcmd
}

dragoraurl () {
mirror="http://rsync.dragora.org/current/iso/beta/"
x=$(curl -s $mirror | grep -m1 x86_64 | awk -F\' '{ print $2 }')
new="$mirror$x -O dragora.iso"
wgetcmd
}

gentoourl () {
mirror="https://gentoo.c3sl.ufpr.br//releases/amd64/autobuilds"
one=$(curl -s "$mirror/latest-iso.txt" | grep "admin" | awk '{ print $1 }')
new="$mirror/$one -O gentoo.iso"
notlive
wgetcmd
}

sabayonurl () {
x="http://sabayonlinux.mirror.garr.it/mirrors/sabayonlinux//iso/daily/Sabayon_Linux_DAILY_amd64_Xfce.iso"
new="$x -O sabayon.iso"
wgetcmd
}

calcurl () {
mirror="https://mirror.yandex.ru/calculate/nightly/"
x=$(curl -s $mirror | grep "<a" | tail -1 | awk -F">" '{ print $2 }' | awk -F"<" '{ print $1 }')
mirror+=$x
x=$(curl -s $mirror | grep -m1 cldc | awk -F\" '{ print $2 }')
new="$mirror/$x -O calculate.iso"
wgetcmd
}

nixurl () {
mirror="https://channels.nixos.org/nixos-unstable"
saved=$(curl -sL $mirror)
dir=$(echo $saved | awk -F"nixos" '{ print $26 }')
file=$(echo $saved | awk -F"nixos" '{ print $28 }' | awk -F".iso" '{ print $1 }')
result="nixos"; result+=$dir; result+="nixos"; result+=$file
x="https://releases.nixos.org/nixos/unstable/$result.iso"
new="$x -O nixos.iso"
notlive
wgetcmd
}

guixurl () {
mirror="https://guix.gnu.org/en/download/"
x=$(curl -s $mirror | grep ".iso" | awk -F"https://" '{ print $2 }' | awk -F\" '{ print $1 }')
new="https://$x"
notlive
wgetcmd
echo "Please wait, unpacking guix..."
xz -d -v ./guix*xz
mv guix*iso guix.iso
}

rancherurl () {
mirror="https://github.com/rancher/os/releases/latest"
x=$(curl -s -L $mirror | grep -m1 rancheros.iso | awk -F\" '{ print $2 }')
new="https://github.com$x -O rancheros.iso"
wgetcmd
}

k3osurl () {
mirror="https://github.com/rancher/k3os/releases/latest"
x=$(curl -s -L $mirror | grep -m1 k3os-amd64.iso | awk -F\" '{ print $2 }')
new="https://github.com$x -O k3os.iso"
wgetcmd
}

flatcarurl () {
mirror="https://alpha.release.flatcar-linux.net/amd64-usr/current/flatcar_production_iso_image.iso"
new="$mirror -O flatcar.iso"
wgetcmd
}

silverblueurl () {
mirror="https://silverblue.fedoraproject.org/download"
x=$(curl -s $mirror | grep -m1 x86_64 | awk -F\' '{ print $2 }')
new="$x -O silverblue.iso"
wgetcmd
}

photonurl () {
mirror="https://github.com/vmware/photon/wiki/Downloading-Photon-OS"
x=$(curl -s $mirror | grep -m1 "Full ISO" | awk -F\" '{ print $2 }')
new="$x -O photonos.iso"
notlive
wgetcmd
}

coreosurl () {
mirror="https://builds.coreos.fedoraproject.org/streams/next.json"
x=$(curl -s $mirror | grep iso | grep location | awk -F\" '{ print $4 }')
new="$x -O coreos.iso"
wgetcmd
}

freebsdurl () {
notlinux
mirror="https://www.freebsd.org/where.html"
x=$(curl -s $mirror | grep -m1 "amd64/amd64" | awk -F\" '{ print $2 }')
one=$(curl -s $x | grep -m1 dvd1 | awk -F"FreeBSD" '{ print $2 }' | awk -F\" '{ print $1 }')
new+=$x; new+="FreeBSD"; new+=$one; new+=" -O freebsd.iso"
wgetcmd
}

indianaurl () {
notlinux
mirror="https://www.openindiana.org/download/"
x=$(curl -s $mirror | grep "Live DVD" | awk -F"http://" '{ print $2 }' | awk -F\" '{ print $1 }')
new="http://$x -O openindiana.iso"
wgetcmd
}

minixurl () {
notlinux
mirror="https://wiki.minix3.org/doku.php?id=www:download:start"
x=$(curl -s $mirror | grep -m1 iso.bz2 | awk -F"http://" '{ print $2 }' | awk -F\" '{ print $1 }')
new="http://$x -O minix.iso.bz2"
[ ! -f minix.iso ] && wgetcmd && echo "Please wait, unpacking minix..." && bzip2 -d minix.iso.bz2 || echo "Minix already downloaded."
}

haikuurl () {
notlinux
mirror="https://download.haiku-os.org/nightly-images/x86_64/"
x=$(curl -s $mirror | grep -m1 zip | awk -F\" '{ print $2 }')
new="$x -O haiku.zip"
[ ! -f haiku.iso ] && wgetcmd && echo "Please wait, unzipping haiku..." && unzip haiku.zip && rm ReadMe.md && mv haiku*iso haiku.iso || echo "Haiku already downloaded."
}

menueturl () {
notlinux
mirror="http://www.menuetos.be/download.php?CurrentMenuetOS"
new="$mirror -O menuetos.zip"
[ ! -f menuetos.img ] && wgetcmd && echo "Please wait, unzipping menuetos..." && unzip menuetos.zip && mv M64*.IMG menuetos.img && rm menuetos.zip || echo "Menuet already downloaded."
}

kolibrios () {
notlinux
mirror="http://builds.kolibrios.org/eng/latest-iso.7z"
new="$mirror -O kolibrios.7z"
[ ! -f kolibrios.iso ] && wgetcmd && echo "Un7zipping kolibri..." && 7z x kolibrios.7z && mv kolibri.iso kolibrios.iso && rm kolibrios.7z || echo "Kolibri already downloaded."
}

reactosurl () {
notlinux
mirror="https://sourceforge.net/projects/reactos/files/latest/download"
new="$mirror -O reactos.zip"
[ ! -f reactos.iso ] && wgetcmd && echo "Please wait, unzipping reactos..." && unzip reactos.zip && mv React*iso reactos.iso && rm reactos.zip || echo "Menuet already downloaded."
}
