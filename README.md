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
* Additional: html2text (required to download recent Fedora)
* Some distros are shared as archive. So you'll need xz for guix, bzip2 for minix, zip for haiku & reactos, and, finally 7z for kolibri.

## Currently supported distributions
If you can't find your favourite linux distro in here, please create a github issue with details about it or add support for it yourself and do a pull request.
```
Arch-based:    DEB-based:     RPM-based:     Other:	    Source-based:  Containers:	  BSD:		 Not linux:
0 = archlinux  5 = debian     20 = fedora    27 = alpine    39 = gentoo	   44 = rancheros 50 = freebsd	 54 = openindia
1 = manjaro    6 = ubuntu     21 = centos    28 = tinycore  40 = sabayon   45 = k3os	  51 = netbsd	 55 = minix
2 = arcolinux  7 = linuxmint  22 = opensuse  29 = porteus   41 = calculate 46 = flatcar	  52 = openbsd	 56 = haiku
3 = archbang   8 = altlinux   23 = rosa	     30 = slitaz    42 = nixos	   47 = silverblu 53 = ghostbsd	 57 = menuetos
4 = parabola   9 = zorinos    24 = mandriva  31 = pclinuxos 43 = guix	   48 = photon	  		 58 = kolibrios
	       10 = solus     25 = mageia    32 = void	    		   49 = coreos	  		 59 = reactos
	       11 = popos     26 = clearos   33 = fourmlinu 		   		  		 60 = freedos
	       12 = deepin    		     34 = kaos	    		   		  		 
	       13 = mxlinux   		     35 = clearlinu 		   		  		 
	       14 = knoppix   		     36 = dragora   		   		  		 
	       15 = kali      		     37 = slackware 		   		  		 
	       16 = puppy     		     38 = adelie    		   		  		 
	       17 = pureos    		     		    		   		  		 
	       18 = elementar 		     		    		   		  		 
	       19 = backbox   			   		    		     		           		      
```

## How to use?
If you manually pick distros (opt. one or two) you will be prompted about launching a VM for test spin for each distro.
Multiple values are also supported:
* one distribution (e.g. type 0 for archlinux)*
* several distros - space separated (e.g. for getting both Arch and Debian, type '0 4' (without quotes))*
* 'all' option, the script will ONLY download ALL of the ISOs (warning: this can take a lot of space (~105 GB) as well as several hours to download everything!)
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
