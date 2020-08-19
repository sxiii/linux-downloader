#!/bin/bash
echo "/-------------------------------------------------------------------------------------------------------------------------\ "
echo "| Script downloads recent (latest release) linux ISOs and spins a VM for a test. This is kinda distrohopper dream machine.| "
echo "| It consist of the file with distro download functions (distrofunctions.sh) as well as this script.                      | "
echo "| Theoretically, the script should always download recent linux ISOs without any updates. But, if the developer(s)        | "
echo "| change the download URL or something else, it might be required to do manual changes - probably in distrofunctions.sh.  | "
echo "| Requirements: linux, bash, curl, wget, awk, grep, xargs, for guix you'll also need 'xz' as it's compressed /------------/ "
echo "| Written by SecurityXIII / August 2020 / Kopimi un-license  /-----------------------------------------------/"
echo "\------------------------------------------------------------/"
echo "+ How to use?"
echo "If you manually pick distros (opt. one or two) you will be prompted about launching a VM for test spin for each distro."
echo "Multiple values are also supported. Please choose:"
echo "* one distribution (e.g. type 0 for archlinux)*"
echo "* several distros - space separated (e.g. for getting both Arch and Debian, type '0 4')*"
echo "* 'all' option, the script will ONLY download ALL of the ISOs (warning: this can take a lot of space!)"

# NB: I wanted to add ElementaryOS but the developers made it way too hard to implement auto-downloading.
# If you can find constant mirror or place for actual release of ElementaryOS, please do a pull-request or just leave a comment.

# "WIP". Todo:	1. Multiple architecture support;
#		2. Multiple download mirror support;

# Add other: void, 4mlinux, kaos, clearlinux, dragora, reactos, haiku, freebsd
# Add sourcebased: pclinuxos, easyos,
# Test: parabola

# Load the functions from distrofunctions.sh:
. distrofunctions.sh

# Categories
arch=(archlinux manjaro arcolinux archbang parabola)
deb=(debian ubuntu linuxmint altlinux zorinos solus popos deepin mxlinux knoppix kali puppy pureos)
rpm=(fedora centos opensuse rosa mandriva mageia clearos)
other=(alpine tinycore porteus slitaz)
sourcebased=(gentoo sabayon calculate nixos guix)

# All distributions
distro_all=("${arch[@]}" "${deb[@]}" "${rpm[@]}" "${other[@]}" "${sourcebased[@]}")

# Legend ## Distroname ## Arch  ## Type     ## Download URL 
archlinux=("ArchLinux" "amd64" "rolling" "archurl")
manjaro=("Manjaro" "amd64" "rolling" "manjarourl")
arcolinux=("Arcolinux" "amd64" "rolling" "arcourl")
archbang=("Archbang" "amd64" "rolling" "archbangurl")
parabola=("Parabola" "amd64" "rolling" "parabolaurl")

debian=("Debian" "amd64" "testing" "debianurl")
ubuntu=("Ubuntu" "amd64" "daily-live" "ubuntuurl")
linuxmint=("LinuxMint" "amd64" "release" "minturl")
altlinux=("ALTLinux" "amd64" "release" "alturl")
zorinos=("ZorinOS" "amd64" "core" "zorinurl")
solus=("Solus" "amd64" "release" "solusurl")
popos=("PopOS" "amd64" "release" "popurl")
deepin=("Deepin" "amd64" "release" "deepinurl")
mxlinux=("MXLinux" "amd64" "release" "mxurl")
knoppix=("Knoppix" "amd64" "release" "knoppixurl")
kali=("Kali" "amd64" "kali-weekly" "kaliurl")
puppy=("Puppy" "amd64" "bionicpup64" "puppyurl")
pureos=("PureOS" "amd64" "release" "pureurl")

fedora=("Fedora" "amd64" "fedora-rawhide-nightly" "fedoraurl")
centos=("CentOS" "amd64" "stream" "centosurl")
opensuse=("OpenSUSE" "amd64" "leap" "suseurl")
rosa=("ROSA" "amd64" "desktop-fresh" "rosaurl")
mandriva=("Mandriva" "amd64" "release" "mandrivaurl")
mageia=("Mageia" "amd64" "release" "mageiaurl")
clearos=("ClearOS" "amd64" "release" "clearurl")

alpine=("Alpine" "amd64" "extended" "alpineurl")
tinycore=("TinyCore" "amd64" "current" "tinycoreurl")
porteus=("Porteus" "amd64" "kiosk" "porteusurl")
slitaz=("SliTaz" "amd64" "rolling" "slitazurl")

gentoo=("Gentoo" "amd64" "admincd" "gentoourl")
sabayon=("Sabayon" "amd64" "daily" "sabayonurl")
calculate=("Calculate" "amd64" "release" "calcurl")
nixos=("NixOS" "amd64" "unstable" "nixurl")
guix=("Guix" "amd64" "release" "guixurl")

for ((i=0; i<${#distro_all[@]}; i++)); do colout+="$i = ${distro_all[$i]} \n"; done
printf "$colout" | paste - - - - - -

echo "Please choose distro to download (type-in number or space-separated multiple numbers):"
read x

# Happens if the input is empty
if [ -z "$x" ]; then echo "Wrong distribution number. Please type-in number of according distro. Exiting"; exit; fi # "Empty" handling

# This questions are asked ONLY if user hadn't used the option "all"
if [ "$x" != "all" ]; then
	for distr in $x; do 

	dist=${distro_all[$distr]}
	typeset -n arr=$dist
	echo "You choose ${arr[0]}, ${arr[2]}-type distro built for ${arr[1]} arch. Do you want to download ${arr[0]} ISO? (y / n)"
	read z
	#if [ $z = "y" ]; then $"${arr[3]}"; wget -c $new ; fi
	if [ $z = "y" ]; then $"${arr[3]}"; fi
	echo "${arr[0]} downloaded, do you want to spin up the QEMU? (y / n)"
	read z

	if [ $z = "y" ]; then
	        # ADD QUEMU AVAILABILITY CHECK
		isoname="$(echo ${arr[0]} | awk '{print tolower($0)}').iso"
		# Uncomment the following two rows (a1 & a2) and comment out third (b1) if you want to make QEMU HDD
		#qemu-img create ./${arr[0]}.img 4G                                                # a1. Creating HDD (if you want changes to be preserved)
		#qemu-system-x86_64 -hda ./${arr[0]}.img -boot d -cdrom ./${arr[0]}*.iso -m 1024   # a2. Booting from CDROM with HDD support (changes will be preserved)
		qemu-system-x86_64 -boot d -cdrom ./$isoname -m 1024                               # b1. This is liveCD boot without HDD (all changes will be lost)
	fi

	done
else

# Only download will happen if user picked "all" option
	if [ "$x" = "all" ]; then i=0; for ((i=0; i<${#distro_all[@]}; i++)); do xx+="$i "; done; x=$xx; fi # "All" handling
	$"${arr[3]}"; #wget -c $new
fi
