#!/bin/bash
# Script that downloads recent linux distro ISOs for you.
# Requirements: linux, bash, curl, wget, awk, grep
# Written by SecurityXIII / August 2020

# WARNING! Script is UNFINISHED.
# WORK IN PROGRESS

# Categories
arch=(archlinux manjaro arcolinux archbang)
deb=(debian ubuntu linuxmint altlinux zorinos elementaryos popos deepin mxlinux knoppix kali puppy)
rpm=(fedora centos opensuse rosa)
other=(alpine tinycore porteus slitaz)
sourcebased=(gentoo sabayon nixos slackware)
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
zorinos=("ZorinOS" "amd64" "release" "zorinurl")

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
mirror=""
x=$()
new="$mirror/$x.iso"
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

if [ $z = "y" ]; then $"${arr[3]}"; wget $new ; fi

# Add multiple download support with "1,2,3,10"
# Add all support with "all"
