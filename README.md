## linux-downloader
Bash script for autodownloading of different latest, "bleeding edge" Linux distros and testing them in qemu VM. Other than Linux, it also boots *BSDs families and other opensource projects. Currently around 60 distributions are supported in 8 different "families". Also, booting from iPXE mirrors (netboot.xyz and boot.salstar.sk) is supported.

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
0 = archlinux  13 = debian    28 = fedora    35 = alpine    47 = gentoo	   52 = rancheros 58 = freebsd	 62 = openindia
1 = manjaro    14 = ubuntu    29 = centos    36 = tinycore  48 = sabayon   53 = k3os	  59 = netbsd	 63 = minix
2 = arcolinux  15 = linuxmint 30 = opensuse  37 = porteus   49 = calculate 54 = flatcar	  60 = openbsd	 64 = haiku
3 = archbang   16 = altlinux  31 = rosa	     38 = slitaz    50 = nixos	   55 = silverblu 61 = ghostbsd	 65 = menuetos
4 = parabola   17 = zorinos   32 = mandriva  39 = pclinuxos 51 = guix	   56 = photon	  		 66 = kolibrios
5 = endeavour  18 = solus     33 = mageia    40 = void	    		   57 = coreos	  		 67 = reactos
6 = artix      19 = popos     34 = clearos   41 = fourmlinu 		   		  		 68 = freedos
7 = arco       20 = deepin    		     42 = kaos	    		   		  		 
8 = garuda     21 = mxlinux   		     43 = clearlinu 		   		  		 
9 = rebornos   22 = knoppix   		     44 = dragora   		   		  		 
10 = archlabs  23 = kali      		     45 = slackware 		   		  		 
11 = namib     24 = puppy     		     46 = adelie    		   		  		 
12 = obarun    25 = pureos    		     		    		   		  		 
	       26 = elementar 		     		    		   		  		 
	       27 = backbox
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

## Help needed
"Work-in-progress". To do:	
1. Multiple architecture support
2. Multiple download mirror support
3. Adding more distributions

## Notes
* automation.sh is in the main script
* distrofunctions.sh contains all URL/mirror/HTTP scraping stuff

Feel free to do a pull request or ask me to add your favourite distro in the issues.
NB: I prefer the distros updated at least in 2019 or later.

## Author & License
* Written by SecurityXIII / August 2020 / Kopimi un-license
