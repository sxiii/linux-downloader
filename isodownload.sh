#!/bin/bash

######################
# set colors here
lgreen="\e[1;92m"
white="\e[0;97m"
lblue="\e[1;34m"
red='\033[0;31m'    # Red
green='\033[0;32m'  # Green
yellow='\033[0;33m' # Yellow
blue='\033[0;34m'   # Blue
purple='\033[0;35m' # Purple
cyan='\033[0;36m'   # Cyan
# BG colors
onblack='\033[40m'  # Black
onred='\033[41m'    # Red
ongreen='\033[42m'  # Green
onyellow='\033[43m' # Yellow
onblue='\033[44m'   # Blue
onpurple='\033[45m' # Purple
oncyan='\033[46m'   # Cyan
onwhite='\033[47m'  # White
# reset color
reset="\e[0m"

#################################################################################################################################################
# Variables

######################
# Ventoy directory
# - specify your Ventoy mount point
# - e.g. un Ubuntu: /media/$USER/Ventoy/
#
ventoymount="/media/$USER/Ventoy/"

######################
# Ventoy directory
# - specify the subfolder on the Ventoy-USB-drive relativ to mount point
# - e.g. "ISOs/" points to /media/ralf/Ventoy/ISOs and all the downloads go to /media/ralf/Ventoy/ISOs/subfolder
# - subfolder is the 5th position in distro array
#
ventoydir="ISOs/"

######################
# Categories
# - define categories for distros, make sure you set it in distro-legends below
# - syntax:
#    category=(distro1 distro2 distro3)
#
deb=(kubuntu_lts kubuntu_stable kde_neon ubuntu_lts ubuntu_stable linuxmint zorinos)
sysres=(systemrescuecd rescuezilla parrot kali)
arch=(manjaro fedora cachyos)

######################
# All distributions
category_names=("${purple}DEB-based" "SystemRescue" "Arch-based${reset}")
distro_all=("deb" "sysres" "arch")
distro_arr=("${deb[@]}" "${sysres[@]}" "${arch[@]}" "${other[@]}" "${sourcebased[@]}")

######################
# distro-characteristics
# - set characteristics for each distro
#
# Legend:
## Distroname   ## Arch   ## Type   ## Download URL function name   ## Download subfolder

### Debian/Ubuntu-based distros
#debian=("Debian" "amd64" "testing" "debianurl")
kubuntu_lts=("Kubuntu" "amd64" "LTS" "kubuntultsurl" "Linux")
kubuntu_stable=("Kubuntu" "amd64" "stable" "kubuntustableurl" "Linux")
#ubuntu_daily=("Ubuntu" "amd64" "daily-live" "ubuntuurl")
kde_neon=("KDE Neon" "amd64" "UserEdition" "neonurl" "Linux")
ubuntu_lts=("Ubuntu" "amd64" "LTS" "ubuntultsurl" "Linux")
ubuntu_stable=("Ubuntu" "amd64" "stable" "ubuntustableurl" "Linux")
linuxmint=("LinuxMint" "amd64" "release" "minturl" "Linux")
zorinos=("ZorinOS" "amd64" "core" "zorinurl" "Linux")

### SystemRescue CDs
systemrescuecd=("SystemRescueCD" "amd64" "stable" "systemrescueurl" "Systemrescue")
rescuezilla=("Rescuezilla" "amd64" "latest" "rescuezillaurl" "Systemrescue")
parrot=("ParrotOS" "amd64" "testing" "parroturl" "Systemrescue")
kali=("Kali Linux" "amd64" "stable" "kaliurl" "Systemrescue")

### Arch-based distros
cachyos=("CachyOS" "amd64" "desktop" "cachyosurl" "Linux")
manjaro=("Manjaro" "amd64" "full" "manjarourl" "Linux")
fedora=("Fedora" "amd64" "stable" "fedoraurl" "Linux")

ventoyisos=(kubuntu_lts kubuntu_stable ubuntu_lts ubuntu_stable linuxmint systemrescuecd rescuezilla parrot cachyos)

#################################################################################################################################################
# Main code - do not change anything below until you know, what you are doing

# Load the functions from distrofunctions_*.sh:
for i in ./distrofunctions_*.sh; do
	. $i
done

normalmode() {
	clear
	echo "OS-Downloader"
	echo -e "#####################################################################################\n"

	checkventoyusb
	drawmenu

	echo -e "'ventoy' includes '${ventoyisos[@]}'\n"
	echo -e "#####################################################################################\n"
	while true; do
		echo -n "Please choose distro to download (by number(s), space-separated or 'ventoy'): "
		read x

		# draw menu if needed
		if [ "$x" = "menu" ]; then
			clear
			drawmenu
			exit
		fi

		# input is empty
		if [ -z "$x" ]; then
			echo "Empty distribution number. Please type-in number of according distro."
			continue
		else
			break
		fi
	done

	# If user didn't use option "all" or "ventoy"
	if [ "$x" != "all" ] && [ "$x" != "ventoy" ] && [ "$noconfirm" != "1" ]; then
		for distr in $x; do
			# test, if entered value for distro is greater than total numbers of distros - reduved by one, as it is beginning with 0
			if [ ${distr} -gt $((${#distro_arr[@]} - 1)) ]; then
				echo "No distro with that number found"
				continue
			fi
			dist=${distro_arr[$distr]}
			typeset -n arr=$dist

			echo -e -n "\n${green}${arr[0]}${reset} ${blue}${arr[2]}${reset} (${arr[1]}). Do you want to download ${arr[0]} ISO? (y / n) "
			read z
			if [ $z = "y" ]; then $"${arr[3]}"; fi
		done
		echo "No further distros for downloading specified."
	else
		# automatic download of specified ISOs when "all" or "ventoy" option, no questions asked.
		if [ "$x" = "ventoy" ] || [ "$x" = "all" ]; then
			if [ "$x" = "ventoy" ]; then
				# use only distros specified in "ventoyisos"
				distro_arr=("${ventoyisos[@]}")
				echo "ventoy option"
			fi
			echo "autoremuming all downloads"
			autoresumedl=1
			for ((i = 0; i < ${#distro_arr[@]}; i++)); do xx+="$i "; done
			x=$xx
			for distr in $x; do
				dist=${distro_arr[$distr]}
				typeset -n arr=$dist
				$"${arr[3]}"
			done
		fi

		if [ "$noconfirm" = "1" ]; then
			for distr in $x; do
				dist=${distro_arr[$distr]}
				typeset -n arr=$dist
				$"${arr[3]}"
			done
		fi
	fi
}

quickmode() {
	IFS=,
	for distr in $distros; do
		dist=${distro_arr[$distr]}
		typeset -n arr=$dist
		$"${arr[3]}"
	done
	exit 0
}

VALID_ARGS=$(getopt -o hysod: --long help,noconfirm,silent,output_ dir,distro: -- "$@")
if [[ $? -ne 0 ]]; then
	exit 1
fi

eval set -- "$VALID_ARGS"
while [ : ]; do
	case "$1" in
	-h | --help)
		helpsection
		echo "Valid command line flags:"
		echo "-h/--help: Show this help"
		echo "-y/--noconfirm: Download specified distro without confirmation. "
		echo "-s/--silent: Don't show help or extra info."
		echo "-o/--output_dir: Path where the downloaded files will be stored."
		echo "-d/--distro: Download distributions specified in the comma-separated list. Example: 0,2,34"
		exit 0
		;;
	-y | --noconfirm)
		echo "-y/--noconfirm option specified. Script will download specified distro without confirmation."
		noconfirm=1
		shift
		;;
	-s | --silent)
		echo "-s/--silent option specified. Script will not show help or extra info."
		silent=1
		shift
		;;
	-o | --output_dir)
		echo "-o/--output_dir option specified. The images will be downloaded in \"$3\"."
		output_dir=$3
		shift
		;;
	-d | --distro)
		echo "-d/--distro option specified. Script will download distributions with the following numbers: '$2'"
		distros="$2"
		quickmode
		;;
	--)
		shift
		break
		;;
	esac
done

#if [ "$silent" != "1" ]; then helpsection; fi

normalmode
