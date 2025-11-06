#!/bin/bash

#####################################################
# Variables:
# - new 		= downloadlink
# - output_path	= filename for the saved file on disk

cachyosurl() {
	one="https://build.cachyos.org/ISO/desktop/"
	# ubuntu latest stable im Format 25.04
	two="$(curl -s $one | grep -E [0-9]{6} | tail -n 1 | sed 's:^.*href="::g; s:/\" title.*::g')"

	mirror="${one}${two}/"
	x=$(curl -s $mirror | grep ${two}.iso | head -n 1 | sed 's:^.*href="::g; s:" title.*::g')
	new="${mirror}${x}"

	output_path "$x"
	checkfile $1
}

manjarourl() {
	# crawl iso-name from sourceforge and dl it later from https://download.manjaro.org/kde/
	mirrorsf="https://sourceforge.net/projects/manjarolinux/files/kde/"
	mirrormanjaro="https://download.manjaro.org/kde/"
	one=$(curl -s $mirrorsf | grep -E download_url\":\"https:\/\/sourceforge\.net | sed 's:http:\nhttp:g; s:","url.*::g' | tail -n 1 | sed 's:download::g')

	echo "one: $one"

	two="$(curl -s $one | grep href | grep manjaro | grep -v minimal | grep .iso\/download | awk -F\" '{ print $6 }' | awk -F\" '{ print $1 }')"
	three="$(echo $two | sed 's:/download::g')"
	four="${three##*/}"
	five="$(echo $three | sed 's/https://g; s://sourceforge.net/projects/manjarolinux/files/kde/::g' | awk -F/ '{print $1}')"
	# one: https://sourceforge.net/projects/manjarolinux/files/kde/25.0.10/
	# two: https://sourceforge.net/projects/manjarolinux/files/kde/25.0.10/manjaro-kde-25.0.10-251013-linux612.iso/download
	# three: https://sourceforge.net/projects/manjarolinux/files/kde/25.0.10/manjaro-kde-25.0.10-251013-linux612.iso
	# four: manjaro-kde-25.0.10-251013-linux612.iso
	# five: 25.0.10

	# dl from manjaro server, SF is too slow
	new="$mirrormanjaro$five/$four"
	output_path "$four"
	checkfile $1
}

fedoraurl() {
	mirror="https://ftp-stud.hs-esslingen.de/pub/fedora/linux/releases/"
	one="$(curl -s $mirror | grep 'href' | awk -F"\"" '{ print $8 }' | tail -n 2 | head -n 1)"
	two="$(curl -s ${mirror}${one}KDE/x86_64/iso/ | grep iso | awk -F"\"" '{ print $8 }' | tail -n 1)"
	three="$(echo $two | tr '[:upper:]' '[:lower:]')"
	new="${mirror}${one}KDE/x86_64/iso/${two}"
	output_path "${three}"
	checkfile $1
}
