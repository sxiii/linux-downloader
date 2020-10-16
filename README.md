## linux-downloader
Bash script for autodownloading of different latest, "bleeding edge" Linux distros and testing them in qemu VM. Other than Linux, it also boots *BSDs families and other opensource projects. Currently around 70 distributions are supported in 8 different "families". Also, booting from iPXE mirrors (netboot.xyz and boot.salstar.sk) is supported.

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
* Basic stuff: linux, bash, curl, wget, awk, grep, xargs, pr (these tools usually are preinstalled on linux)
* Additional: html2text (unsure?) and xpath (for PopOS)
* Some distros are shared as archive. So you'll need xz for guix, bzip2 for minix, zip for haiku & reactos, and, finally 7z for kolibri.

## Currently supported distributions
If you can't find your favourite linux distro in here, please create a github issue with details about it or add support for it yourself and do a pull request.
```
Arch-based:    DEB-based:     RPM-based:     Other:	    Source-based:  Containers:	  BSD:		 Not linux:
0 = archlinux  13 = debian    29 = fedora    36 = alpine    49 = gentoo	   54 = rancheros 60 = freebsd	 64 = openindia
1 = manjaro    14 = ubuntu    30 = centos    37 = tinycore  50 = sabayon   55 = k3os	  61 = netbsd	 65 = minix
2 = arcolinux  15 = linuxmint 31 = opensuse  38 = porteus   51 = calculate 56 = flatcar	  62 = openbsd	 66 = haiku
3 = archbang   16 = altlinux  32 = rosa	     39 = slitaz    52 = nixos	   57 = silverblu 63 = ghostbsd	 67 = menuetos
4 = parabola   17 = zorinos   33 = mandriva  40 = pclinuxos 53 = guix	   58 = photon	  		 68 = kolibrios
5 = endeavour  18 = solus     34 = mageia    41 = void	    		   59 = coreos	  		 69 = reactos
6 = artix      19 = popos     35 = clearos   42 = fourmlinu 		   		  		 70 = freedos
7 = arco       20 = deepin    		     43 = kaos	    		   		  		 
8 = garuda     21 = mxlinux   		     44 = clearlinu 		   		  		 
9 = rebornos   22 = knoppix   		     45 = dragora   		   		  		 
10 = archlabs  23 = kali      		     46 = slackware 		   		  		 
11 = namib     24 = puppy     		     47 = adelie    		   		  		 
12 = obarun    25 = pureos    		     48 = plop	    		   		  		 
	       26 = elementar 		     		    		   		  		 
	       27 = backbox   		     		    		   		  		 
	       28 = devuan    		     		    		   		  		 
```

## How to use?
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
* Fedora 33 Workstation (Pre-release)
* Ubuntu 20.04
* Manjaro 20.1 Mikah

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
3. Adding more distributions (current goal: 100)

## Notes on files
* download.sh is in the main script
* distrofunctions.sh contains all URL/mirror/HTTP scraping stuff

Feel free to do a pull request or ask me to add your favourite distro in the issues.
NB: I prefer the distros updated at least in 2019 or later.

## Author & License
* Written by SecurityXIII
* Project began in August 2020 - but since then improved several times
* Kopimi un-license as well as MIT
