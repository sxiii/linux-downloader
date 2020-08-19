## linux-downloader
Bash script for autodownloading of different Linux distros and testing them in qemu VM.

## Linux Distrohopper Dream Machine Script
```
/----------------------------------------------------------------------------------------------------------------------------------------\
| Script downloads recent (latest release) linux ISOs and spins a VM for a test. This is kinda distrohopper dream machine.               |
| It consist of the file with distro download functions (distrofunctions.sh) as well as this script.                                     |
| Theoretically, the script should always download recent linux ISOs without any updates. But, if the developer(s)                       |
| change the download URL or something else, it might be required to do manual changes - probably in distrofunctions.sh.                 |
| Requirements: linux, bash, curl, wget, awk, grep, xargs, paste, column (this tools usually are preinstalled on linux)                  |
| Some distros are shared as archive. So you'll need xz for guix, bzip2 for minix, zip for haiku & reactos, and, finally 7z for kolibri. |
| Written by SecurityXIII / August 2020 / Kopimi un-license  /---------------------------------------------------------------------------/
\------------------------------------------------------------/
```

+ How to use?
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

Feel free to do a pull request or ask me to add your favourite distro in the issues.
NB: I prefer the distros updated at least in 2019 or later.
