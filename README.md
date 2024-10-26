## linux-downloader
Bash script for autodownloading of different latest, "bleeding edge" Linux distros and testing them in qemu VM. Other than Linux, it also boots *BSDs families and other opensource projects. Currently about 100 Linux, BSD and alternative OS distributions are supported in 8 different "families". Also, booting from iPXE mirrors (netboot.xyz and boot.salstar.sk) is supported.

## Linux Distrohopper Dream Machine Script
```
/----------------------------------------------------------------------------------\
| Script downloads recent (latest release) linux ISOs and spins a VM for a test.   |
| This is distrohopper dream machine. It consist of the file with distro download  | 
| functions (distrofunctions.sh) as well as this script. Theoretically, the script | 
| should always download recent linux ISOs without any updates. But, if the dev(s) |
| change the download URL or something else, it might be required to do manual     |
| changes - distrofunctions.sh.                                                    |
\----------------------------------------------------------------------------------/
```

## Requirements: 
* Basic stuff: `linux`, `bash`, `curl`, `wget`, `awk`, `grep`, `xargs`, `pr` (these tools usually are preinstalled on linux)
* Additional depencency: `html2text` (for PopOS, Fedora, Rosa, Alma, Rocky, Adelie), `aria2` (for PopOS)
* If you want to run a VM after downloading, you'll need `QEMU`
* Some distros are shared as archive. So you'll need `xz` for guix, `bzip2` for minix, `zip` for haiku & reactos, and, finally `7z` for kolibri.
### Install all deps on Arch-based distro
`sudo pacman -S html2text aria2 p7zip xz bzip2 qemu`
### Install all deps on Debian based distro
`sudo apt-get install html2text aria2 p7zip xz-utils bzip2 qemu`

## Currently supported distributions
If you can't find your favourite linux distro in here, please create a github issue with details about it or add support for it yourself and do a pull request.
```
Arch-based:	     DEB-based:		  RPM-based:	       Other:		    Source-based:	 Containers and DCs:  BSD, NAS, Firewall:  Not linux:
0 = archlinux	     17 = debian	  35 = fedora	       52 = alpine	    69 = gentoo		 77 = rancheros	      85 = freebsd	   99 = openindiana
1 = manjaro	     18 = ubuntu	  36 = centos	       53 = tinycore	    70 = sabayon	 78 = k3os	      86 = netbsd	   100 = minix
2 = arcolinux	     19 = linuxmint	  37 = opensuse	       54 = porteus	    71 = calculate	 79 = flatcar	      87 = openbsd	   101 = haiku
3 = archbang	     20 = zorinos	  38 = rosa	       55 = slitaz	    72 = nixos		 80 = silverblue      88 = ghostbsd	   102 = menuetos
4 = parabola	     21 = popos		  39 = altlinux	       56 = pclinuxos	    73 = guix		 81 = photon	      89 = hellosystem	   103 = kolibri
5 = endeavour	     22 = deepin	  40 = mandriva	       57 = void	    74 = crux		 82 = coreos	      90 = dragonflybsd	   104 = reactos
6 = artix	     23 = mxlinux	  41 = mageia	       58 = fourmlinux	    75 = gobolinux	 83 = dcos	      91 = pfsense	   105 = freedos
7 = arco	     24 = knoppix	  42 = clearos	       59 = kaos	    76 = easyos		 84 = proxmox	      92 = opnsense	   
8 = garuda	     25 = kali		  43 = alma	       60 = clearlinux	    			 		      93 = midnightbsd	   
9 = rebornos	     26 = puppy		  44 = rocky	       61 = dragora	    			 		      94 = truenas	   
10 = archlabs	     27 = pureos	  45 = qubes	       62 = slackware	    			 		      95 = nomadbsd	   
11 = namib	     28 = elementary	  46 = nobara	       63 = adelie	    			 		      96 = hardenedbsd	   
12 = obarun	     29 = backbox	  47 = ultramarine     64 = plop	    			 		      97 = xigmanas	   
13 = archcraft	     30 = devuan	  48 = springdale      65 = solus	    			 		      98 = clonos	   
14 = peux	     31 = jingos	  49 = berry	       66 = peropesis	    			 		      			   
15 = bluestar	     32 = cutefishos	  50 = risios	       67 = openmamba	    			 		      			   
16 = xerolinux	     33 = parrot	  51 = eurolinux       68 = pisi	    			 		      			   
		     34 = tailsos
```

## How to use?
1. `git clone https://github.com/sxiii/linux-downloader`
2. `cd linux-downloader`
3. `./download.sh`
If you manually pick distros (opt. one or two) you will be prompted about launching a VM for test spin for each distro.
Multiple values are also supported:
* one distribution (e.g. type 0 for archlinux)*
* several distros - space separated (e.g. for getting both Arch and Manjaro, type '0 1' (without quotes))*
* 'all' option, the script will ONLY download ALL of the ISOs (warning: this can take a lot of space (~128 GB) as well as several hours to download everything!)
* 'filesize' option will check the local (downloaded) filesizes of ISOs vs. the current/recent ISOs filesizes on the websites
* 'netbootxyz' option allows you to boot from netboot.xyz via network
* 'netbootsal' option will boot from boot.salstar.sk

## Verified as working
This script verified as working correctly on the following OSes:
* Garuda Linux Soaring Talon
* Fedora 33 Workstation (Pre-release)
* Ubuntu 20.04
* Manjaro 21.0.5 Ornara
* Probably will work almost everywhere 

## How to add distribution yourself
0. Clone the repo, if you hadn't already, and enter the resuling folder: 
```
git clone https://github.com/sxiii/linux-downloader && cd linux-downloader
```
1. Open file "download.sh" with your favourite text editor. In the according row of "Categories", add the name of your distro in the end of the array.
2. In the same file, little bit down further, add your distro variable (array) like this: (the order is the same as in "Categories")
```
distroname=("Full Distro Name" "arch" "releasename" "distronameurl")
```
Here is the real example to make it more obvious:
```
obarun=("Obarun" "amd64" "rolling" "obarunurl")
```
3. Save & close the "download.sh" file. Now, open "distrofunctions.sh" file. This is more tricky. We need to AUTOMATICALLY get the URL of the most recent distribution (fixed-links are forbidden as they will destroy the idea behind this script of always get the recent release). So you need to find a way to get the recent release full download URL. For example, if we want to download from Sourceforge.net, make a new function like this:
```
distronameurl () {
mirror="https://sourceforge.net/projects/SF-Project-Name/files/latest/download"
new="$mirror"
output="distroname.iso"
checkfile $1
}
```
Here you will need to edit: function name (distronameurl), mirror address (in this example we're downloading project "SF-Project-Name" from sourceforge), output file name. Checkfile is the function that checks if file exists and downloads the file if not, so don't touch it. If you are going to download not from sourceforge, but from some other website, please check the other distributions for examples - there are plenty of examples of how to parse websites to get the recent download links automatically. In the end, you need to supply "new" variable with full ISO URL, as well as "output" var with filename (and mirror variable is there for cleaniness of the code and code consistancy). Other than that, you can use "grep, awk, xargs" or other classic UNIX tools to parse the HTML (or several files) and get the actual download link. If you'll create temporary files, please don't forget to remove them in the end of the function. You can as well parse file listings like HTTP or FTP server mirror hosts. If you can't write the correct code, feel free to create an issue and ask me for help.

4. Now, save the "distrofunctions.sh" file. Run the ./download.sh script, type-in number of your distribution, and check, that it's downloaded correctly.
5. Last but very important, please create a pull request, so I could check and add distribution of your choice.

Thank you!

## Help needed
"Work-in-progress". To do:	
1. Multiple architecture support
2. Multiple download mirror support
~3. Adding more distributions (current goal: 100)~

## Notes on files
* download.sh is in the main script
* distrofunctions.sh contains all URL/mirror/HTTP scraping stuff

Feel free to do a pull request or ask me to add your favourite distro in the issues.
NB: I prefer the distros updated at least during the last 2-3 years (ideally, 1 year). Exceptions can be historically important releases and rare/special operating systems.

## Author & License
* Written by SecurityXIII
* Project began in August 2020 - but since then improved several times
* Kopimi un-license as well as MIT
