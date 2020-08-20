## linux-downloader
Bash script for autodownloading of different Linux distros and testing them in qemu VM.

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
Arch-based:	   DEB-based:	   RPM-based:	   Other:	          Source-based:    Containers:      Not linux:
0 = archlinux	 5 = debian	   18 = fedora	 25 = alpine	    35 = gentoo	     40 = rancheros   46 = freebsd
1 = manjaro	   6 = ubuntu	   19 = centos	 26 = tinycore    36 = sabayon     41 = k3os	      47 = openindiana
2 = arcolinux	 7 = linuxmint 20 = opensuse 27 = porteus	    37 = calculate   42 = flatcar     48 = minix
3 = archbang	 8 = altlinux	 21 = rosa	   28 = slitaz	    38 = nixos	     43 = silverblue  49 = haiku
4 = parabola	 9 = zorinos	 22 = mandriva 29 = pclinuxos   39 = guix	       44 = photon      50 = menuetos
               10 = solus	   23 = mageia	 30 = void	    		               45 = coreos      51 = kolibrios
		           11 = popos	   24 = clearos	 31 = fourmlinux  		     		                      52 = reactos
		           12 = deepin	  		         32 = kaos	    		     		      
		           13 = mxlinux	  		         33 = clearlinux  		     		      
		           14 = knoppix	  		         34 = dragora	    		     		      
		           15 = kali	  		   		    		     		      
		           16 = puppy	  		   		    		     		      
		           17 = pureos	  		   		    		     		      
```

## How to use?
If you manually pick distros (opt. one or two) you will be prompted about launching a VM for test spin for each distro.
Multiple values are also supported:
* one distribution downloading (e.g. type 0 for archlinux)*"
* several distros - space separated (e.g. for getting both Arch and Debian, type '0 4' (without quotes))*"
* 'all' option, the script will ONLY download ALL of the ISOs (warning: this can take a lot of space (80+GB) !)"

## Help needed
"Work-in-progress". To do:	
1. Multiple architecture support
2. Multiple download mirror support
3. Adding more distributions

## Notes
* automation is in the main script
* all URL/mirror/HTTP scraping are done in the distrofunctions.sh file

Feel free to do a pull request or ask me to add your favourite distro in the issues.
NB: I prefer the distros updated at least in 2019 or later.

## Author & License
* Written by SecurityXIII / August 2020 / Kopimi un-license
