#!/bin/bash
# Script that downloads recent linux distro ISOs for you.
# Theoretically, the script should always download recent linux ISOs without any updates.
# But if the developers change the download URL or something else, it might be required to do manual changes.
# Requirements: linux, bash, curl, wget, awk, grep, xargs
# Written by SecurityXIII / August 2020

# WARNING! Script is UNFINISHED.
# WORK IN PROGRESS

# Categories
arch=(archlinux manjaro arcolinux archbang)
deb=(debian ubuntu linuxmint altlinux zorinos elementaryos popos deepin mxlinux knoppix kali puppy)
rpm=(fedora centos opensuse rosa)
other=(alpine tinycore porteus slitaz)
sourcebased=(gentoo sabayon calculate nixos)
# All distributions
distro_all=("${arch[@]}" "${deb[@]}" "${rpm[@]}" "${other[@]}" "${sourcebased[@]}")

# Legend ## Distroname ## Arch  ## Type     ## Download URL 
archlinux=("ArchLinux" "amd64" "rolling" "archurl")
manjaro=("Manjaro" "amd64" "rolling" "manjarourl")
arcolinux=("Arcolinux" "amd64" "rolling" "arcourl")
archbang=("Archbang" "amd64" "rolling" "archbangurl")

debian=("Debian" "amd64" "testing" "debianurl")
ubuntu=("Ubuntu" "amd64" "daily-live" "ubuntuurl")
linuxmint=("Linux Mint" "amd64" "release" "minturl")
altlinux=("ALT Linux" "amd64" "release" "alturl")
zorinos=("ZorinOS" "amd64" "core" "zorinurl")
elementaryos=("Elementary OS" "amd64" "release" "elementurl")
popos=("PopOS" "amd64" "release" "popurl")
deepin=("Deepin" "amd64" "release" "deepinurl")
mxlinux=("MX Linux" "amd64" "release" "mxurl")
knoppix=("Knoppix" "amd64" "release" "knoppixurl")
kali=("Kali Linux" "amd64" "kali-weekly" "kaliurl")
puppy=("Puppy Linux" "amd64" "bionicpup64" "puppyurl")

fedora=("Fedora" "amd64" "fedora-rawhide-nightly" "fedoraurl")
centos=("CentOS" "amd64" "stream" "centosurl")
opensuse=("OpenSUSE" "amd64" "leap" "suseurl")
rosa=("ROSA Linux" "amd64" "desktop-fresh" "rosaurl")

alpine=("Alpine" "amd64" "extended" "alpineurl")
tinycore=("TinyCore" "amd64" "current" "tinycoreurl")
porteus=("Porteus" "amd64" "kiosk" "porteusurl")
slitaz=("SliTaz" "amd64" "rolling" "slitazurl")

gentoo=("Gentoo" "amd64" "admincd" "gentoourl")
sabayon=("Sabayon" "amd64" "daily" "sabayonurl")
calculate=("Calculate Linux" "amd64" "release" "calcurl")
nixos=("NixOS" "amd64" "unstable" "nixurl")

echo "This script will download recent (latest) linux distribution ISO for you."
echo "Please choose distro to download (type-in number):"

for ((i=0; i<${#distro_all[@]}; i++)); do echo $i = ${distro_all[$i]}; done

read x; dist=${distro_all[$x]}

typeset -n arr=$dist
echo "You choose $x - ${arr[0]}, ${arr[2]}-type distro built for ${arr[1]} arch. Do you want to download ${arr[0]} ISO? (y / n)"

read z

# Functions that update latest distro URL
archurl () {
mirror="http://mirrors.evowise.com/archlinux/iso/latest/"
x=$(curl -s $mirror | grep -m1 archlinux- | awk -F".iso" '{ print $1 }' | awk -F\" '{ print $2 }');
new="$mirror/$x.iso"
}

manjarourl () {
mirror="https://manjaro.org/downloads/official/xfce/"
new=$(curl -s $mirror | grep -m1 "manjaro/storage/xfce" | awk -F\" '{ print $2 }')
}

arcourl () {
mirror="https://bike.seedhost.eu/arcolinux/iso/"
x=$(curl -s $mirror | grep -m1 arcolinux- | awk -F">" '{ print $3 }' | awk -F"<" '{ print $1 }')
new="$mirror/$x"
}

archbangurl () {
mirror="https://sourceforge.net/projects/archbang/files/latest/download"
new="$mirror -O archbang-latest.iso"
}

debianurl () {
new="https://cdimage.debian.org/cdimage/weekly-builds/amd64/iso-dvd/debian-testing-amd64-DVD-1.iso"
}

ubuntuurl () {
mirror="http://cdimage.ubuntu.com/daily-live/current/"
x=$(curl $mirror | grep -m1 desktop-amd64.iso | awk -F\" '{ print $2 }' | awk -F\" '{ print $1 }')
new="$mirror/$x"
}

minturl () {
mirror="https://linuxmint.com/download.php"
x=$(curl $mirror | grep "latest release" | awk -F"Mint" '{ print $2 }' | awk -F"," '{ print $1 }' | xargs)
new="http://mirrors.evowise.com/linuxmint/stable/$x/linuxmint-$x-cinnamon-64bit.iso"
}

alturl () {
new="http://mirror.yandex.ru/altlinux-nightly/current/regular-cinnamon-latest-x86_64.iso"
}

zorinurl () {
mirror="https://sourceforge.net/projects/zorin-os/files/latest/download"
new="$mirror -O zorinos-core-64bit-latest.iso"
}

elementurl () {
echo "Sorry, Elementary OS can be only manually downloaded via the URL: https://elementary.io"
exit
}

popurl () {
mirror="https://pop-iso.sfo2.cdn.digitaloceanspaces.com"
x=$(curl -s $mirror | html2text | grep intel_5 | tail -2 | head -1 | awk -F".iso" '{ print $1 }')
v=$(echo $x | awk -F"_" '{ print $2 }')
arch=$(echo $x | awk -F"_" '{ print $3 }')
new="$mirror/$v/$arch/$x.iso"
}

deepinurl () {
mirror="https://sourceforge.net/projects/deepin/files/latest/download"
new="$mirror -O deepin-latest.iso"
}

mxurl () {
mirror="https://sourceforge.net/projects/mx-linux/files/latest/download"
new="$mirror -O mx-x64-latest.iso"
}

knoppixurl () {
mirror="http://mirror.yandex.ru/knoppix/DVD/"
x=$(curl -s $mirror | grep -m1 EN.iso | awk -F">" '{ print $2 }' | awk -F"<" '{ print $1 }')
new="$mirror/$x"
}

kaliurl () {
mirror="http://cdimage.kali.org/kali-weekly/"
x=$(curl -s $mirror | grep -m1 live-amd64.iso | awk -F">" '{ print $7 }' | awk -F"<" '{ print $1 }')
new="$mirror/$x"
}

puppyurl () {
mirror="http://distro.ibiblio.org/puppylinux/puppy-bionic/bionicpup64/"
x=$(curl -s $mirror | grep -m1 uefi.iso | awk -F">" '{ print $4 }' | awk -F"<" '{ print $1 }')
new="$mirror/$x"
}

fedoraurl () {
mirror="https://www.happyassassin.net/nightlies.html"
new=$(curl -s $mirror | grep -A7 "Fedora Rawhide" | grep .iso | awk -F\" '{ print $2 }')
}

centosurl () {
mirrorone="https://www.centos.org/centos-stream/"
one=$(curl -s $mirrorone | grep x86_64 | awk -F\" '{ print $2 }' | awk -F"/" '{ print $5 }')
mirror="http://mirror.yandex.ru/centos/$one/isos/x86_64/"
x=$(curl -s $mirror | grep -m1 dvd1 | awk -F\" '{ print $2 }' | awk -F\" '{ print $1 }')
new="$mirror/$x"
}

suseurl () {
mirrorone="https://software.opensuse.org/distributions/leap"
one=$(curl -s $mirrorone | grep -m1 "openSUSE Leap" | awk -F"Leap" '{ print $2 }' | awk -F"<" '{ print $1 }' | xargs)
mirror="http://mirror.yandex.ru/opensuse/distribution/leap/$one/iso/"
x=$(curl -s $mirror | grep -m1 "x86_64.iso" | awk -F\" '{ print $2 }')
new="$mirror/$x"
}

rosaurl () {
mirror="https://www.rosalinux.ru/rosa-linux-download-links/"
new="$(curl -s $mirror | grep -A3 -m1 KDE4 | grep 64-bit | awk -F\" '{ print $4 }')"
}

alpineurl () {
mirrorone="https://alpinelinux.org/downloads/"
one=$(curl -s $mirrorone | grep Current | awk -F">" '{ print $3 }' | awk -F"<" '{ print $1 }')
shortv=$(echo $one | awk -F"." '{ print $1"."$2}')
new="http://dl-cdn.alpinelinux.org/alpine/v$shortv/releases/x86_64/alpine-extended-$one-x86_64.iso"
}

tinycoreurl () {
mirrorone="http://tinycorelinux.net/downloads.html"
one=$(curl -s $mirrorone | grep TinyCore-current.iso | awk -F\" '{ print $2 }')
mirror="http://tinycorelinux.net/"
new="$mirror/$one"
}

porteusurl () {
mirrorone="https://porteus-kiosk.org/download.html"
one=$(curl -s $mirrorone | grep "Porteus-Kiosk.*x86_64.iso" | grep -m1 public| awk -F\" '{ print $2 }')
mirror="https://porteus-kiosk.org/"
new="$mirror/$one"
}

slitazurl () {
new="http://mirror.slitaz.org/iso/rolling/slitaz-rolling-core64.iso"
}

gentoourl () {
mirror="https://gentoo.c3sl.ufpr.br//releases/amd64/autobuilds"
one=$(curl -s "$mirror/latest-iso.txt" | grep "admin" | awk '{ print $1 }')
new="$mirror/$one"
}

sabayonurl () {
new="http://sabayonlinux.mirror.garr.it/mirrors/sabayonlinux//iso/daily/Sabayon_Linux_DAILY_amd64_Xfce.iso"
}

calcurl () {
mirror="https://mirror.yandex.ru/calculate/nightly/"
x=$(curl -s $mirror | grep "<a" | tail -1 | awk -F">" '{ print $2 }' | awk -F"<" '{ print $1 }')
mirror+=$x
x=$(curl -s $mirror | grep -m1 cldc | awk -F\" '{ print $2 }')
new="$mirror/$x"
echo $new
}

nixurl () {
mirror="https://channels.nixos.org/nixos-unstable"
saved=$(curl -sL $mirror)
dir=$(echo $saved | awk -F"nixos" '{ print $26 }')
file=$(echo $saved | awk -F"nixos" '{ print $28 }' | awk -F".iso" '{ print $1 }')
result="nixos"; result+=$dir; result+="nixos"; result+=$file
new="https://releases.nixos.org/nixos/unstable/$result.iso"
}

if [ $z = "y" ]; then $"${arr[3]}"; wget $new ; fi
# Add multiple download support with "1,2,3,10"
# Add all support with "all"
