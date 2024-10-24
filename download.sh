#!/usr/bin/env bash

helpsection () {
echo "/----------------------------------------------------------------------------------------------------------------------------------------\ "
echo "| Script downloads recent (latest release) linux ISOs and spins a VM for a test. This is kinda distrohopper dream machine.               | "
echo "| It consist of the file with distro download functions (distrofunctions.sh) as well as this script (download.sh).                       | "
echo "| Theoretically, the script should always download recent linux ISOs without any updates. But, if the developer(s)                       | "
echo "| change the download URL or something else, it might be required to do manual changes - probably in distrofunctions.sh.                 | "
echo "| Requirements: linux, bash, curl, wget, awk, grep, xargs, pr (these tools usually are preinstalled on linux)                            | "
echo "| Some distros are shared as archive. So you'll need xz for guix, bzip2 for minix, zip for haiku & reactos, and, finally 7z for kolibri. | "
echo "| Written by SecurityXIII / Aug 2020 ~ Jan 2023 / Kopimi un-license /--------------------------------------------------------------------/ "
echo "\-------------------------------------------------------------------/"
echo "+ How to use?"
echo " If you manually pick distros (opt. one or two) you will be prompted about launching a VM for test spin for each distro."
echo " Multiple values are also supported. Please choose one out of five options:"
echo "* one distribution (e.g. type 0 for archlinux)*"
echo "* several distros - space separated (e.g. for getting both Arch and Debian, type '0 4' (without quotes))*"
echo "* 'all' option, the script will ONLY download ALL of the ISOs (warning: this can take a lot of space (100+GB) !)"
echo "* 'filesize' option will check the local (downloaded) filesizes of ISOs vs. the current/recent ISOs filesizes on the websites"
echo "* 'netbootxyz' option allows you to boot from netboot.xyz via network"
echo "* 'netbootsal' option will boot from boot.salstar.sk"
}

# the public ipxe mirror does not work
#echo "* 'netbootipxe' option will boot from boot.ipxe.org"

# NB: I wanted to add ElementaryOS but the developers made it way too hard to implement auto-downloading.
# If you can find constant mirror or place for actual release of ElementaryOS, please do a pull-request or just leave a comment.

# "WIP". Todo:	1. Multiple architecture support;
#		2. Multiple download mirror support;

ram=1024 # Amount (mb) of RAM, for VM.
cmd="qemu-system-x86_64" # The name of the qemu file to launch

# Load the functions from distrofunctions.sh:
. distrofunctions.sh

# Categories
arch=(archlinux manjaro arcolinux archbang parabola endeavour artix arco garuda rebornos archlabs namib obarun archcraft peux bluestar xerolinux)
deb=(debian ubuntu ubuntuserver linuxmint zorinos popos deepin mxlinux knoppix kali puppy pureos elementary backbox devuan jingos cutefishos parrot tailsos)
rpm=(fedora centos opensuse rosa altlinux mandriva mageia clearos alma rocky qubes nobara ultramarine springdale berry risios eurolinux)
other=(alpine tinycore porteus slitaz pclinuxos void fourmlinux kaos clearlinux dragora slackware adelie plop solus peropesis openmamba pisi)
sourcebased=(gentoo sabayon calculate nixos guix crux gobolinux easyos)
containers=(rancheros k3os flatcar silverblue photon coreos dcos proxmox)
bsd=(freebsd netbsd openbsd ghostbsd hellosystem dragonflybsd pfsense opnsense midnightbsd truenas nomadbsd hardenedbsd xigmanas clonos)
notlinux=(openindiana minix haiku menuetos kolibri reactos freedos)

# All distributions
category_names=("Arch-based" "DEB-based" "RPM-based" "Other" "Source-based" "Containers and DCs" "BSD, NAS, Firewall" "Not linux")
distro_all=("arch" "deb" "rpm" "other" "sourcebased" "containers" "bsd" "notlinux")
distro_arr=("${arch[@]}" "${deb[@]}" "${rpm[@]}" "${other[@]}" "${sourcebased[@]}" "${containers[@]}" "${bsd[@]}" "${notlinux[@]}")

# Legend ## Distroname ## Arch  ## Type     ## Download URL function name

# Archlinux-based distros
archlinux=("ArchLinux" "amd64" "rolling" "archurl")
manjaro=("Manjaro" "amd64" "rolling" "manjarourl")
arcolinux=("Arcolinux" "amd64" "rolling" "arcourl")
archbang=("Archbang" "amd64" "rolling" "archbangurl")
parabola=("Parabola" "amd64" "rolling" "parabolaurl")
endeavour=("EendeavourOS" "amd64" "latest" "endeavoururl")
artix=("ArtixLinux" "amd64" "daily" "artixurl")
arco=("ArcoLinux" "amd64" "release" "arcourl")
garuda=("Garuda" "amd64" "release" "garudaurl")
rebornos=("RebornOS" "amd64" "release" "rebornurl")
archlabs=("ArchLabs" "amd64" "release" "archlabsurl")
namib=("Namib" "amd64" "release" "namiburl")
obarun=("Obarun" "amd64" "rolling" "obarunurl")
archcraft=("ArchCraft" "amd64" "release" "archcrafturl")
peux=("Peux" "amd64" "release" "peuxurl")
bluestar=("Bluestar" "amd64" "release" "bluestarurl")
xerolinux=("XeroLinux" "amd64" "rolling" "xerourl")

# Consider in the future if the distros continue to evolve
# https://sourceforge.net/projects/calinixos/
# https://sourceforge.net/projects/hefftorlinux/

# Debian/Ubuntu-based distros
debian=("Debian" "amd64" "testing" "debianurl")
ubuntu=("Ubuntu" "amd64" "daily-live" "ubuntuurl")
ubuntuserver=("Ubuntu Server" "amd64" "daily-live" "ubuntuserverurl")
linuxmint=("LinuxMint" "amd64" "release" "minturl")
zorinos=("ZorinOS" "amd64" "core" "zorinurl")
popos=("PopOS" "amd64" "release" "popurl")
deepin=("Deepin" "amd64" "release" "deepinurl")
mxlinux=("MXLinux" "amd64" "release" "mxurl")
knoppix=("Knoppix" "amd64" "release" "knoppixurl")
kali=("Kali" "amd64" "kali-weekly" "kaliurl")
puppy=("Puppy" "amd64" "bionicpup64" "puppyurl")
pureos=("PureOS" "amd64" "release" "pureurl")
elementary=("ElementaryOS" "amd64" "release" "elementurl")
backbox=("Backbox" "amd64" "release" "backboxurl")
devuan=("Devuan" "amd64" "beowulf" "devuanurl")
jingos=("JingOS" "amd64" "v0.9" "jingosurl")
cutefishos=("CutefishOS" "amd64" "release" "cutefishosurl")
parrot=("Parrot" "amd64" "testing" "parroturl")
tailsos=("Tailsos" "amd64" "stable" "tailsurl" )

# Add if wanted
# https://distrowatch.com/table.php?distribution=rebeccablackos
# https://distrowatch.com/table.php?distribution=regata
# https://distrowatch.com/table.php?distribution=uruk
# https://distrowatch.com/table.php?distribution=netrunner

# Fedora/RedHat-based distros
fedora=("Fedora" "amd64" "Workstation" "fedoraurl")
centos=("CentOS" "amd64" "stream" "centosurl")
opensuse=("OpenSUSE" "amd64" "tumbleweed" "suseurl")
rosa=("ROSA" "amd64" "desktop-fresh" "rosaurl")
altlinux=("ALTLinux" "amd64" "release" "alturl")
mandriva=("Mandriva" "amd64" "release" "mandrivaurl")
mageia=("Mageia" "amd64" "cauldron" "mageiaurl")
clearos=("ClearOS" "amd64" "release" "clearosurl")
alma=("AlmaLinux" "amd64" "release" "almaurl")
rocky=("RockyLinux" "amd64" "rc" "rockyurl")
qubes=("QubesOS" "amd64" "release" "qubesurl")
nobara=("Nobara" "amd64" "release" "nobaraurl")
ultramarine=("Ultramarine" "amd64" "release" "ultraurl")
springdale=("Springdale" "amd64" "release" "springurl")
berry=("Berry" "amd64" "release" "berryurl")
risios=("RisiOS" "amd64" "release" "risiurl")
eurolinux=("EuroLinux" "amd64" "release" "eurourl")

# Other distros
alpine=("Alpine" "amd64" "extended" "alpineurl")
tinycore=("TinyCore" "amd64" "current" "tinycoreurl")
porteus=("Porteus" "amd64" "kiosk" "porteusurl")
slitaz=("SliTaz" "amd64" "rolling" "slitazurl")
pclinuxos=("PCLinuxOS" "amd64" "livecd" "pclinuxosurl")
void=("Void" "amd64" "live" "voidurl")
fourmlinux=("4mlinux" "amd64" "release" "fourmurl")
kaos=("kaos" "amd64" "release" "kaosurl")
clearlinux=("ClearLinux" "amd64" "release" "clearurl")
dragora=("Dragora" "amd64" "release" "dragoraurl")
slackware=("Slackware" "amd64" "current" "slackwareurl")
adelie=("Adelie" "amd64" "rc1" "adelieurl")
plop=("Plop" "amd64" "current-stable" "plopurl")
solus=("Solus" "amd64" "release" "solusurl")
peropesis=("Peropesis" "amd64" "live" "peropesisurl")
openmamba=("Openmamba" "amd64" "rolling" "openmambaurl")
pisi=("Pisilinux" "amd64" "release" "pisiurl")

# Source-based distros
gentoo=("Gentoo" "amd64" "admincd" "gentoourl")
sabayon=("Sabayon" "amd64" "daily" "sabayonurl")
calculate=("Calculate" "amd64" "release" "calcurl")
nixos=("NixOS" "amd64" "unstable" "nixurl")
guix=("Guix" "amd64" "release" "guixurl")
crux=("CRUX" "amd64" "release" "cruxurl")
gobolinux=("GoboLinux" "amd64" "release" "gobourl")
easyos=("EasyOS" "amd64" "dunfell" "easyurl")

# Distros for containers and data-centers
rancheros=("RancherOS" "amd64" "release" "rancherurl")
k3os=("K3OS" "amd64" "release" "k3osurl")
flatcar=("Flatcar" "amd64" "release" "flatcarurl")
silverblue=("Silverblue" "amd64" "release" "silverblueurl")
photon=("PhotonOS" "amd64" "fulliso" "photonurl")
coreos=("CoreOS" "amd64" "next" "coreosurl")
dcos=("DC/OS" "amd64" "script" "dcosurl")
proxmox=("Proxmox" "amd64" "stable" "proxmoxurl" )

# FreeBSD family
freebsd=("FreeBSD" "amd64" "release" "freebsdurl")
netbsd=("NetBSD" "amd64" "release" "netbsdurl")
openbsd=("OpenBSD" "amd64" "release" "openbsdurl")
ghostbsd=("GhostBSD" "amd64" "release" "ghostbsdurl")
hellosystem=("HelloSystem" "amd64" "v0.5" "hellosystemurl")
dragonflybsd=("DragonflyBSD" "amd64" "release" "dragonurl")
pfsense=("pfSense" "amd64" "release" "pfsenseurl")
opnsense=("opnsense" "amd64" "release" "opnsenseurl")
midnightbsd=("midnightbsd" "amd64" "release" "midnightbsdurl")
truenas=("truenas" "amd64" "release" "truenasurl")
nomadbsd=("nomadbsd" "amd64" "release" "nomadbsdurl")
hardenedbsd=("hardenedbsd" "amd64" "latest" "hardenedbsdurl")
xigmanas=("xigmanas" "amd64" "release" "xigmanasurl")
clonos=("clonos" "amd64" "release" "clonosurl")

# Add more FreeBSD stuff
# https://en.wikipedia.org/wiki/List_of_BSD_operating_systems
# https://en.wikipedia.org/wiki/List_of_products_based_on_FreeBSD

# Not linux, but free

# Add More Solaris stuff https://solaris.com

openindiana=("OpenIndiana" "amd64" "release" "indianaurl")
minix=("MINIX" "amd64" "release" "minixurl")
haiku=("Haiku" "amd64" "nightly" "haikuurl")
menuetos=("MenuetOS" "amd64" "release" "menueturl")
kolibri=("Kolibri" "amd64" "release" "kolibriurl")
reactos=("ReactOS" "amd64" "release" "reactosurl")
freedos=("FreeDOS" "amd64" "release" "freedosurl")

drawmenu () {

 q=0;

 for ((i=0; i<${#distro_all[@]}; i++)); do
	 col+="${category_names[$i]}: \n"
	 dist=${distro_all[$i]}
	 typeset -n arr=$dist
	 for ((d=0; d<${#arr[@]}; d++)); do
		 col+="$q = ${arr[$d]} \n"
		 (( q++ ));
	 done
 printf "$col" > col$i.tmp
 col=""
 done

 pr -m -t -w170 col*tmp && rm *tmp

}

normalmode () {
	drawmenu
	echo "Please choose distro to download (type-in number or space-separated multiple numbers):"
	read x 
			
	# Happens if the input is empty
	if [ -z "$x" ]; then echo "Empty distribution number. Please type-in number of according distro. Exiting"; exit; fi # "Empty" handling
	
	# Happens if we ask only for menu
	if [ "$x" = "menu" ]; then drawmenu; exit; fi
	
	# This questions are asked ONLY if user hadn't used the option "all".
	if [ "$x" != "all" ] && [ "$x" != "filesize" ] && [ "$x" != "netbootxyz" ] && [ "$x" != "netbootsal" ] && [ "$noconfirm" != "1" ] && [ "$x" != "netbootipxe" ]; then
		for distr in $x; do 
		dist=${distro_arr[$distr]}
		typeset -n arr=$dist
	
		echo "You choose ${arr[0]} distro ${arr[2]}, built for ${arr[1]} arch. Do you want to download ${arr[0]} ISO? (y / n)"
		read z
		if [ $z = "y" ]; then $"${arr[3]}"; fi
		echo "${arr[0]} downloaded, do you want to spin up the QEMU? (y / n)"
		read z
	
		if [ $z = "y" ]; then
			isoname="$(echo ${arr[0]} | awk '{print tolower($0)}').iso"
			if ! type $cmd > /dev/null 2>&1; then
				echo "qemu seems not installed. Cannot run VM, skipping."
			else
			# Uncomment the following two rows (a1 & a2) and comment out others if you want to make QEMU HDD
			# qemu-img create ./${arr[0]}.img 4G                                                # a1. Creating HDD (if you want changes to be preserved)
			# qemu-system-x86_64 -hda ./${arr[0]}.img -boot d -cdrom ./${arr[0]}*.iso -m 1024   # a2. Booting from CDROM with HDD support (changes will be preserved)
				[ -f ./$isoname ] && $cmd -boot d -cdrom ./$isoname -m $ram           # b1. This is liveCD boot without HDD (all changes will be lost)
			# This is for floppy .IMG support
			# [ ! -f ./$isoname ] && imgname="$(echo ${arr[0]} | awk '{print tolower($0)}').img" && [ -f ./$imgname ] && $cmd --fda ./$imgname -m $ram
  				[ ! -f ./$isoname ] && imgname="$(echo ${arr[0]} | awk '{print tolower($0)}').img" && [ -f ./$imgname ] && $cmd -drive format=raw,file=$imgname -m $ram
			fi
		fi
	
		done
	else
	
	# All handling: automatic download will happen if user picked "all" option, no questions asked.
		if [ "$x" = "all" ]; then 
			for ((i=0; i<${#distro_arr[@]}; i++)); do xx+="$i "; done; x=$xx; 
			#for ((i=0; i<${#distro_arr[@]}; i++)); do 
			for distr in $x; do 
				dist=${distro_arr[$distr]}
				typeset -n arr=$dist
				$"${arr[3]}"
			done
		#done
		fi
		
		if [ "$noconfirm" = "1" ]; then 
			for distr in $x; do 
				dist=${distro_arr[$distr]}
				typeset -n arr=$dist
				$"${arr[3]}"
			done
		#done
		fi
		
	# Sizecheck handling: show the distribution file sizes
		if [ "$x" = "filesize" ]; then 
		for ((i=0; i<${#distro_arr[@]}; i++)); do xx+="$i "; done; x=$xx;
		#for ((i=0; i<${#distro_arr[@]}; i++)); do 
			for distr in $x; do 
				dist=${distro_arr[$distr]}
				typeset -n arr=$dist	
				$"${arr[3]}" "filesize"
			done
		#done
		fi
		
		if [ "$x" = "netbootxyz" ]; then
			echo "Downloading netboot image from netboot.xyz, please wait..." && netbootxyz
			echo "Loading netboot.xyz.iso..." && $cmd -boot d -cdrom netboot.xyz.iso -m $ram
		fi
	
		if [ "$x" = "netbootsal" ]; then
			echo "Downloading netboot image from boot.salstar.sk, please wait..." && netbootsal
			echo "Loading ipxe.iso..." && $cmd -boot d -cdrom ipxe.iso -m $ram
		fi
	
		if [ "$x" = "netbootipxe" ]; then
                	echo "Downloading netboot image from boot.ipxe.org, please wait..." && netbootipxe
                	echo "Loading bootipxe.iso..." && $cmd -boot d -cdrom bootipxe.iso -m $ram
		fi
	fi
}

quickmode () {
	IFS=,
	for distr in $distros; do
		dist=${distro_arr[$distr]}
		typeset -n arr=$dist	
		$"${arr[3]}"
	done
	exit 0;
}

VALID_ARGS=$(getopt -o hysod: --long help,noconfirm,silent,output_dir,distro: -- "$@")
if [[ $? -ne 0 ]]; then
    exit 1;
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
        exit 0;
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
    --) shift; 
        break 
        ;;
  esac
done

if [ "$silent" != "1" ]; then helpsection; fi

normalmode
