#!/bin/bash

helpsection() {
	# colortest
	# 	echo -e "${red}red ${blue}blue ${green}green ${greennew}greennew ${yellow}yellow ${bluenew}bluenew ${purple}purple ${cyan}cyan${reset}"
	# 	echo
	# 	echo -e "${red}${onblack}red ${blue}${onyellow}blue ${green}${onpurple}green ${greennew}greennew ${yellow}${oncyan}yellow ${bluenew}bluenew ${purple}${onwhite}purple ${cyan}cyan${reset}"

	echo "/----------------------------------------------------------------------------------------------------------------------------------------\ "
	echo "| Requirements: linux, bash, curl, wget, awk, grep, xargs, pr (these tools usually are preinstalled on linux)                            | "
	echo "| Some distros are shared as archive. So you'll need xz for guix, bzip2 for minix, zip for haiku & reactos, and, finally 7z for kolibri. | "
	echo "| Written by SecurityXIII / Aug 2020 ~ Jan 2023 / Kopimi un-license /--------------------------------------------------------------------/ "
	echo "\-------------------------------------------------------------------/"
	echo "+ How to use?"
	echo " If you manually pick distros (opt. one or two) you will be prompted about launching a VM for test spin for each distro."
	echo " Multiple values are also supported. Please choose one out of five options:"
	echo "* one distribution (e.g. type 0 for archlinux)*"
	echo "* several distros - space separated (e.g. for getting both Arch and Debian, type '0 4' (without quotes))*"
	echo "* 'all' option, the script will ONLY download ALL of the ISOs"
}

drawmenu() {
	q=0

	for ((i = 0; i < ${#distro_all[@]}; i++)); do
		col+="${category_names[$i]} \n"
		dist=${distro_all[$i]}
		typeset -n arr=$dist
		for ((d = 0; d < ${#arr[@]}; d++)); do
			col+="$q = ${arr[$d]} \n"
			((q++))
		done
		printf "$col" >col$i.tmp
		col=""
	done

	pr -m -t -w270 -l20 col*tmp && rm *tmp
}

# Download functions and commands

output_path() {
	isoname="$1"
	#if $output_dir is not empty, then
	if [ -n "$output_dir" ]; then
		local output_path="${output_dir}/"
	fi
	#
	# 	output_dir="${arr[4]}"
	#
	# 	output="${output_dir}/$1"
	if [ $ventoyusb = "1" ]; then
		output_dir="${ventoymount}${ventoydir}${arr[4]}"

	else
		output_dir="${arr[4]}"
	fi
	echo -e "\n-----------------------------------------------------------------------------"
	echo -e "${bold}${purple}${isoname}${reset}"
	echo -e "\nDL-directory is set to ${blue}'$output_dir'${reset}\n"
	output="${output_dir}/$1"
}

wgetcmd() {
	if [ -n "$output_dir" ] && [ ! -d "$output_dir" ]; then
		echo
		echo -n -e "The iso destination path ${blue}'$output_dir'${reset} doesn't exist. Do you want to create it ? (y / n): "
		read create_path
		if [ "$create_path" = "y" ]; then
			mkdir -p "$output_dir"
		else
			echo "destination path not created - exit here"
			exit 1
		fi
	fi

	echo -e "Downloading ${blue}$new${reset} to ${green}$output${reset}"
	echo

	if [ -f "$output_dir/$isoname" ]; then
		echo -e "There is already a file named ${green}$isoname${reset} in your output directory ${blue}($output_dir)${reset}."

		getsize
		if [ $? = "1" ]; then
			# autoresumedl is set by option "all" or "ventoy"
			if [ "$autoresumedl" != "1" ]; then
				echo -n "Do you want to replace it/continue downloading (y) or abort (n)? (y / n): "
				read replace_iso
				if [ "$replace_iso" = "n" ]; then
					echo "exit 1"
					exit 1
				elif [ "$replace_iso" = "y" ]; then
					echo "replacing iso and try to continue the download"
				fi
			fi
		fi
	fi
	wget -q --show-progress -c "$new" -O "$output" -o /dev/null
}

####################
# Function to get filesize of both files - remote and local - to compare
# return 0: local file has the same size as remote file - nothing to do or download
# return 1: local file has a different size as the remote file - ask user in wgetcmd
#
getsize() {
	# set to en because Length is sometimes translated
	export LANG=en_US.UTF-8

	abc=$(wget --spider $new 2>&1)
	remisosize=$(echo $abc | awk -F"Length:" '{ print $2 }' | awk -F"[" '{ print $1 }')
	remisosizebytes=$(echo $remisosize | awk '{ print $1 }')
	hdisosizes=$(ls -l -B $output | awk -F" " '{ print $5 }')
	hdisosizeh=$(ls -lh $output | awk -F" " '{ print $5 }')

	if [ $remisosizebytes = $hdisosizes ]; then
		echo "remote and local file have the same size - nothing to do here"
		return 0
	else
		echo -e "\nFile to download:"
		echo "$new"
		echo -e "has size: ${green}$remisosize${reset}"
		echo -e "\nFile on disk: (in '$output_dir')"
		echo "$isoname"
		echo -e "has size:   ${blue}$hdisosizes ($hdisosizeh) ${reset}\n"
		return 1
	fi
}

empty() {
	echo "The file $output is empty. Please download it first." # This function does nothing
}

checkfile() {
	if [ "$1" == "filesize" ]; then
		[ -s $output ] && getsize || empty
	else
		wgetcmd
	fi
}

####################
# Function to check, if a ventoy USB drive is mounted
# and ask the user to use it for downloading direct to that drive
# useful to update the isos on the drive
# https://www.ventoy.net/
#
checkventoyusb() {
	if [ -d "$ventoymount" ]; then
		echo -n "Ventoy USB drive is Mounted. Do you want to use it for downloading? (y / n): "
		read useventoy
		if [ "$useventoy" = "n" ]; then
			echo -e "Ventoy folder is not used\n"
			ventoyusb=0
		elif [ "$useventoy" = "y" ]; then
			echo -e "Ventoy USB drive is set for downloading\n"
			ventoyusb=1
		fi
	fi
}
