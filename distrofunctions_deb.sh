#!/bin/bash

#####################################################
# Variables:
# - new 		= downloadlink
# - output_path	= filename for the saved file on disk

debianurl() {
	x="https://cdimage.debian.org/cdimage/weekly-builds/amd64/iso-dvd/debian-testing-amd64-DVD-1.iso"
	new="$x"
	output_path "debian.iso"
	notlive
	checkfile $1
}

ubuntultsurl() {
	one="https://releases.ubuntu.com/"
	# ubuntu latest stable im Format 25.04
	two="$(curl -s $one | grep LTS | grep -E href=\"[0-9][0-9]\.[0-9][0-9]\.[0-9]? | tail -n 1 | sed 's:^.*href="::g; s:/">.*::g')"
	mirror="${one}${two}/"
	x=$(curl -s $mirror | grep -m1 desktop-amd64.iso | awk -F\" '{ print $2 }' | awk -F\" '{ print $1 }')
	new="${mirror}${x}"
	output_path "$x"
	checkfile $1
}

kubuntultsurl() {
	one="https://cdimage.ubuntu.com/kubuntu/releases/"
	# Kubuntu LTS im Format 24.04.3
	#two="$(curl -s $one | grep -E '[0-9][0-9]\.[0-9][0-9]\.[0-9]?' | tail -n 1 | html2text | sed 's/\/$//g')"
	three="$(curl -s $one | grep -E '[0-9][0-9]\.[0-9][0-9]\.[0-9]?' | tail -n 1 | sed 's:<li><a href="::g; s:/">.*::g')"
	mirror="${one}${three}/release/"
	x=$(curl -s "$mirror" | grep -m1 desktop-amd64.iso | awk -F\" '{ print $2 }' | awk -F\" '{ print $1 }')
	new="${mirror}${x}"
	output_path "kubuntu_lts_$three.iso"
	checkfile $1
}

neonurl() {
	one="https://neon.kde.org/download/"
	two="$(curl -s $one | grep -m 1 neon-user | awk -F\" '{ print $2 }' | awk -F\" '{ print $1 }')"
	three="${two##*/}"
	new="${two}"
	output_path "${three}"
	checkfile $1
}

kubuntustableurl() {
	one="https://cdimage.ubuntu.com/kubuntu/releases/"
	# Kubuntu LTS im Format 25.04

	two="$(curl -s $one | grep -E '[0-9][0-9]\.[0-9][0-9]' | tail -n 1 | sed 's:<li><a href="::g; s:/">.*::g')"
	mirror="${one}${two}/release/"

	x=$(curl -s "$mirror" | grep -m1 desktop-amd64.iso | awk -F\" '{ print $2 }' | awk -F\" '{ print $1 }')
	new="${mirror}${x}"
	output_path "$x"
	checkfile $1
}

ubuntustableurl() {
	#curl -s https://releases.ubuntu.com/ | grep -E href=\"[0-9][0-9]\.[0-9][0-9]\.[0-9]? | tail -n 1 | sed 's:^.*href="::g; s:/">.*::g'
	one="https://releases.ubuntu.com/"
	# ubuntu latest stable im Format 25.04
	two="$(curl -s $one | grep -E href=\"[0-9][0-9]\.[0-9][0-9]\.[0-9]? | tail -n 1 | sed 's:^.*href="::g; s:/">.*::g')"
	mirror="${one}${two}/"
	x=$(curl -s $mirror | grep -m1 desktop-amd64.iso | awk -F\" '{ print $2 }' | awk -F\" '{ print $1 }')
	new="${mirror}${x}"
	output_path "$x"
	checkfile $1
}

minturl() {
	one="https://mirrors.cicku.me/linuxmint/iso/stable/"
	two="$(curl -s $one | grep -E href=\"[0-9][0-9]\.[0-9] | tail -n 1 | sed 's:^.*href="::g; s:/">.*::g')"
	mirror="$one$two/"
	x=$(curl -s $mirror | grep -m1 cinnamon-64bit | sed 's:^.*href="::g; s:">.*::g')
	new="${mirror}${x}"
	output_path "$x"
	checkfile $1

}

zorinurl() {
	mirror="https://mirrors.dotsrc.org/zorinos/"
	one="$(curl -s $mirror | grep -E href=\"[0-9][0-9] | tail -n 1 | sed 's:^.*href="::g; s:" title.*::g')"
	two="$(curl -s $mirror$one | grep Core-64-bit | awk -F\" '{ print $4 }' | awk -F\" '{ print $1 }')"
	three="$(echo ${two} | tr '[:upper:]' '[:lower:]')"
	new="$mirror$one$two"
	output_path "$three"
	checkfile $1
}
