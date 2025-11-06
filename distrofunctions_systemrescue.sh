#!/bin/bash

#####################################################
# Variables:
# - new 		= downloadlink
# - output_path	= filename for the saved file on disk

systemrescueurl() {
	one="https://www.system-rescue.org/Download/"
	# use DL from fastly
	two="$(curl -s $one | grep -E fastly.*iso | grep -E fastly.*iso | sed 's:^.*href="::g; s:">.*::g')"
	#echo "two: $two"
	x="${two##*/}"
	#echo "x: $x"
	new="$two"
	output_path "$x"
	checkfile $1
}

rescuezillaurl() {
	one="https://rescuezilla.com/download"
	two="$(curl -s $one | grep -E latest.*iso | sed 's:^.*href="::g; s:">.*::g' | head -n 1)"
	#echo "two: $two"
	x="${two##*/}"
	#echo "x: $x"
	new="$two"
	output_path "$x"
	checkfile $1

}

parroturl() {
	one="https://deb.parrot.sh/direct/parrot/iso/"
	two=$(curl -s $one | grep -E [0-9]?[0-9]\.[0-9][0-9]?\/ | tail -n 1 | sed 's:^.*href="::g; s:">.*::g')
	#echo "two: $two"
	mirror="$one$two"
	three="$(curl -s $mirror | grep security.*.iso\< | sed 's:^.*href="::g; s:">.*::g')"
	#echo "three: $three"
	new="$one$two$three"
	filename="$(echo "$three" | tr '[:upper:]' '[:lower:]')"
	#echo "new: $new"
	output_path "$filename"
	checkfile $1
}

kaliurl() {
	mirror="http://cdimage.kali.org/"
	one="$(curl -s $mirror | grep -E kali-[0-9]{4} | tail -n 1 | sed 's:^.*href="::g; s:" title.*::g')"
	#echo "one: $one"
	two="$(curl -s $mirror$one | grep -m1 live-amd64.iso | awk -F">" '{ print $4 }' | awk -F"<" '{ print $1 }')"
	#echo "two: $two"
	x=$(curl -s $mirror | grep -m1 live-amd64.iso | awk -F">" '{ print $7 }' | awk -F"<" '{ print $1 }')
	new="$mirror$one$two"
	output_path "$two"
	checkfile $1
}
