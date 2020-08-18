#!/bin/bash

# Other functions

notlive () {
echo " / / ---------------------------------------------------------------------- \ \ "
echo " | | Note: this is not a live disk (it'll require further installation).    | | "
echo " \ \ -----------------------------------------------------------------------/ / "
}

# Functions that update latest distro URL

archurl () {
mirror="http://mirrors.evowise.com/archlinux/iso/latest/"
x=$(curl -s $mirror | grep -m1 archlinux- | awk -F".iso" '{ print $1 }' | awk -F\" '{ print $2 }');
new="$mirror/$x.iso -O archlinux.iso"
}

manjarourl () {
mirror="https://manjaro.org/downloads/official/xfce/"
x=$(curl -s $mirror | grep -m1 "manjaro/storage/xfce" | awk -F\" '{ print $2 }')
new="$x -O manjaro.iso"
}

arcourl () {
mirror="https://bike.seedhost.eu/arcolinux/iso/"
x=$(curl -s $mirror | grep -m1 arcolinux- | awk -F">" '{ print $3 }' | awk -F"<" '{ print $1 }')
new="$mirror/$x -O arcolinux.iso"
}

archbangurl () {
mirror="https://sourceforge.net/projects/archbang/files/latest/download"
new="$mirror -O archbang.iso"
}

debianurl () {
x="https://cdimage.debian.org/cdimage/weekly-builds/amd64/iso-dvd/debian-testing-amd64-DVD-1.iso"
new="$x -O debian.iso"
}

ubuntuurl () {
mirror="http://cdimage.ubuntu.com/daily-live/current/"
x=$(curl $mirror | grep -m1 desktop-amd64.iso | awk -F\" '{ print $2 }' | awk -F\" '{ print $1 }')
new="$mirror/$x -O ubuntu.iso"
}

minturl () {
mirror="https://linuxmint.com/download.php"
x=$(curl $mirror | grep "latest release" | awk -F"Mint" '{ print $2 }' | awk -F"," '{ print $1 }' | xargs)
new="http://mirrors.evowise.com/linuxmint/stable/$x/linuxmint-$x-cinnamon-64bit.iso -O linuxmint.iso"
}

alturl () {
x="http://mirror.yandex.ru/altlinux-nightly/current/regular-cinnamon-latest-x86_64.iso"
new="$x -O altlinux.iso"
}

zorinurl () {
mirror="https://sourceforge.net/projects/zorin-os/files/latest/download"
new="$mirror -O zorinos.iso"
}

solusurl () {
mirror="https://getsol.us/download/"
x=$(curl -s $mirror | grep -m1 iso | awk -F\" '{ print $2 }')
new="$x -O solus.iso"
}

popurl () {
mirror="https://pop-iso.sfo2.cdn.digitaloceanspaces.com"
x=$(curl -s $mirror | html2text | grep intel_5 | tail -2 | head -1 | awk -F".iso" '{ print $1 }')
v=$(echo $x | awk -F"_" '{ print $2 }')
arch=$(echo $x | awk -F"_" '{ print $3 }')
new="$mirror/$v/$arch/$x.iso -O popos.iso"
}

deepinurl () {
mirror="https://sourceforge.net/projects/deepin/files/latest/download"
new="$mirror -O deepin.iso"
notlive
}

mxurl () {
mirror="https://sourceforge.net/projects/mx-linux/files/latest/download"
new="$mirror -O mxlinux.iso"
}

knoppixurl () {
mirror="http://mirror.yandex.ru/knoppix/DVD/"
x=$(curl -s $mirror | grep -m1 EN.iso | awk -F">" '{ print $2 }' | awk -F"<" '{ print $1 }')
new="$mirror/$x -O knoppix.iso"
}

kaliurl () {
mirror="http://cdimage.kali.org/kali-weekly/"
x=$(curl -s $mirror | grep -m1 live-amd64.iso | awk -F">" '{ print $7 }' | awk -F"<" '{ print $1 }')
new="$mirror/$x -O kali.iso"
}

puppyurl () {
mirror="http://distro.ibiblio.org/puppylinux/puppy-bionic/bionicpup64/"
x=$(curl -s $mirror | grep -m1 uefi.iso | awk -F">" '{ print $4 }' | awk -F"<" '{ print $1 }')
new="$mirror/$x -O puppy.iso"
}

fedoraurl () {
mirror="https://www.happyassassin.net/nightlies.html"
x=$(curl -s $mirror | grep -A7 "Fedora Rawhide" | grep .iso | awk -F\" '{ print $4 }')
new="$x -O fedora.iso"
}

centosurl () {
mirrorone="https://www.centos.org/centos-stream/"
one=$(curl -s $mirrorone | grep x86_64 | awk -F\" '{ print $2 }' | awk -F"/" '{ print $5 }')
mirror="http://mirror.yandex.ru/centos/$one/isos/x86_64/"
x=$(curl -s $mirror | grep -m1 dvd1 | awk -F\" '{ print $2 }' | awk -F\" '{ print $1 }')
new="$mirror/$x -O centos.iso"
}

suseurl () {
mirrorone="https://software.opensuse.org/distributions/leap"
one=$(curl -s $mirrorone | grep -m1 "openSUSE Leap" | awk -F"Leap" '{ print $2 }' | awk -F"<" '{ print $1 }' | xargs)
mirror="http://mirror.yandex.ru/opensuse/distribution/leap/$one/iso/"
x=$(curl -s $mirror | grep -m1 "x86_64.iso" | awk -F\" '{ print $2 }')
new="$mirror/$x -O opensuse.iso"
}

rosaurl () {
mirror="https://www.rosalinux.ru/rosa-linux-download-links/"
x="$(curl -s $mirror | grep -A3 -m1 KDE4 | grep 64-bit | awk -F\" '{ print $4 }')"
new="$x -O rosa.iso"
}

alpineurl () {
mirrorone="https://alpinelinux.org/downloads/"
one=$(curl -s $mirrorone | grep Current | awk -F">" '{ print $3 }' | awk -F"<" '{ print $1 }')
shortv=$(echo $one | awk -F"." '{ print $1"."$2}')
x="http://dl-cdn.alpinelinux.org/alpine/v$shortv/releases/x86_64/alpine-extended-$one-x86_64.iso"
new="$x -O alpine.iso"
}

tinycoreurl () {
mirrorone="http://tinycorelinux.net/downloads.html"
one=$(curl -s $mirrorone | grep TinyCore-current.iso | awk -F\" '{ print $2 }')
mirror="http://tinycorelinux.net/"
new="$mirror/$one -O tinycore.iso"
}

porteusurl () {
mirrorone="https://porteus-kiosk.org/download.html"
one=$(curl -s $mirrorone | grep "Porteus-Kiosk.*x86_64.iso" | grep -m1 public| awk -F\" '{ print $2 }')
mirror="https://porteus-kiosk.org/"
new="$mirror/$one -O porteus.iso"
}

slitazurl () {
x="http://mirror.slitaz.org/iso/rolling/slitaz-rolling-core64.iso"
new="$x -O slitaz.iso"
}

gentoourl () {
mirror="https://gentoo.c3sl.ufpr.br//releases/amd64/autobuilds"
one=$(curl -s "$mirror/latest-iso.txt" | grep "admin" | awk '{ print $1 }')
new="$mirror/$one -O gentoo.iso"
notlive
}

sabayonurl () {
x="http://sabayonlinux.mirror.garr.it/mirrors/sabayonlinux//iso/daily/Sabayon_Linux_DAILY_amd64_Xfce.iso"
new="$x -O sabayon.iso"
}

calcurl () {
mirror="https://mirror.yandex.ru/calculate/nightly/"
x=$(curl -s $mirror | grep "<a" | tail -1 | awk -F">" '{ print $2 }' | awk -F"<" '{ print $1 }')
mirror+=$x
x=$(curl -s $mirror | grep -m1 cldc | awk -F\" '{ print $2 }')
new="$mirror/$x -O calculate.iso"
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
}
