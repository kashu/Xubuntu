#!/bin/bash
#Author: kashu
#My Website: https://kashu.org
#Date: 2015-08-03
#Filename: hosts.sh
#Description: Download and update the latest hosts file.

# Check user privilege
if [ `id -u` -ne "0" ]; then echo "User has insufficient privileage!" && exit 1; fi
# Check if wget is executable
test -x `which wget` || { echo "wget is not executable"; exit 2; }

DATE=`date +%Y%m%d`

# Download the hosts file from github.com
wget -r --retry-connrefused --no-check-certificate https://raw.githubusercontent.c\
om/racaljk/hosts/master/hosts -O /tmp/hosts."$DATE" || { echo "The hosts \
file download failed!"; exit 3; }

# Backup the existing hosts file before overwrite it.
mv -f /etc/hosts /etc/hosts."$DATE"

if [ -f /etc/hosts.base ]; then
	cat /etc/hosts.base >| /etc/hosts
else
	:>| /etc/hosts
fi

cat /tmp/hosts."$DATE" >> /etc/hosts
chmod a+r /etc/hosts && clear

# Have fun!
cat <<- END > /dev/stdout
Cool! The new hosts file has been updated. 
Enjoy the Internet!
END

