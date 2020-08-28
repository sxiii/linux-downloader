## linux-downloader
Bash script for autodownloading of different latest, "bleeding edge" Linux distros and testing them in qemu VM. Currently over 50 distributions are supported in 7 different "families". Also, booting from iPXE mirrors (netboot.xyz and boot.salstar.sk) is also supported.

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
* Additional: some distros are shared as archive. So you'll need xz for guix, bzip2 for minix, zip for haiku & reactos, and, finally 7z for kolibri.

## Currently supported distributions
If you can't find your favourite linux distro in here, please create a github issue with details about it or add support for it yourself and do a pull request.
```
Arch-based:	 DEB-based:	  RPM-based:	   Other:	    Source-based:    Containers:      Not linux:
0 = archlinux	 5 = debian	  19 = fedora	   26 = alpine	    36 = gentoo	     41 = rancheros   47 = freebsd
1 = manjaro	 6 = ubuntu	  20 = centos	   27 = tinycore    37 = sabayon     42 = k3os	      48 = openindiana
2 = arcolinux	 7 = linuxmint	  21 = opensuse	   28 = porteus	    38 = calculate   43 = flatcar     49 = minix
3 = archbang	 8 = altlinux	  22 = rosa	   29 = slitaz	    39 = nixos	     44 = silverblue  50 = haiku
4 = parabola	 9 = zorinos	  23 = mandriva	   30 = pclinuxos   40 = guix	     45 = photon      51 = menuetos
		 10 = solus	  24 = mageia	   31 = void	    		     46 = coreos      52 = kolibrios
		 11 = popos	  25 = clearos	   32 = fourmlinux  		     		      53 = reactos
		 12 = deepin	  		   33 = kaos	    		     		      
		 13 = mxlinux	  		   34 = clearlinux  		     		      
		 14 = knoppix	  		   35 = dragora	    		     		      
		 15 = kali	  		   		    		     		      
		 16 = puppy	  		   		    		     		      
		 17 = pureos	  		   		    		     		      
		 18 = elementary  		     		      
```

## How to use?
If you manually pick distros (opt. one or two) you will be prompted about launching a VM for test spin for each distro.
Multiple values are also supported:
* one distribution (e.g. type 0 for archlinux)*
* several distros - space separated (e.g. for getting both Arch and Debian, type '0 4' (without quotes))*
* 'all' option, the script will ONLY download ALL of the ISOs (warning: this can take a lot of space (80+GB) !)
* 'filesize' option will check the local (downloaded) filesizes of ISOs vs. the current/recent ISOs filesizes on the websites
* 'netbootxyz' option allows you to boot from netboot.xyz via network
* 'netbootsal' option will boot from boot.salstar.sk

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
