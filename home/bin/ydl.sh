#! /bin/bash
#Author: kashu
#My Website: https://kashu.org
#Date: 2016-01-06
#Filename: ydl.sh
#Description: use youtube-dl to download videos
#youtube-dl official website: http://rg3.github.io/youtube-dl/

#XDG_CACHE_HOME=/tmp
#youtube-dl -f `youtube-dl -F "$i" | awk '/best/{print $1}'` "$i"
cd /tmp

YTB=/usr/bin/youtube-dl
#YTB_P=/usr/bin/youtube-dl
#YTB_P="/usr/bin/youtube-dl --proxy http://127.0.0.1:8787 -f 18"
YTB_P="/usr/bin/youtube-dl --proxy http://127.0.0.1:8787"

UPDATE(){
TMP_YTB=/tmp/youtube_dl.`date +%Y%m%d`

# 1) Download the latest youtube-dl to /tmp directory through Lantern Proxy
export http_proxy=http://127.0.0.1:8787/
#wget --no-check-certificate `wget --no-check-certificate -qO - https://rg3.github.io/youtube-dl/download.html|\
#grep 'youtube-dl -O ' -|sed 's/\(.*\)\(http.*dl\ \)\(.*\)/\2/g'` -O $TMP_YTB
wget --no-check-certificate https://yt-dl.org/downloads/latest/youtube-dl -O $TMP_YTB

# 2) Or, use the proxychains
#proxychains wget --no-check-certificate https://yt-dl.org/downloads/latest/youtube-dl -O $TMP_YTB

# 3) You can also use curl to download though Lantern proxy like this way
# curl -x http://127.0.0.1:8787 https://yt-dl.org/downloads/2015.12.31/youtube-dl -o youtube-dl.py

# Check if the youtube-dl is there or is up-to-date
if [ ! -s "$TMP_YTB" ]; then echo -e "\033[41;37myoutube-dl download failed\033[0m!  http://rg3.github.io/youtube-dl/download.html" && exit 1; fi
if [ "`md5sum /tmp/youtube-dl.$(date +%Y%m%d) $(which youtube-dl)|cut -d' ' -f1|uniq|wc -l`" -ne "1" -o ! -e "$YTB" ]; then
	sudo mv $TMP_YTB $YTB && sudo chmod a+x $YTB
fi
test -x $YTB && echo "Great, $YTB is up-to-date!" || { echo "Update failed"; exit 5; }
}

USAGE(){
	echo -e "\033[41;37mUsage:\033[0m $0 URL or $0 /url_list_file.txt"
	echo -e "\033[44;37me.g.\033[0m"
	cat <<- END
	(1) ydl.sh http://v.youku.com/v_show/id_XODE3NjYxODM2.html
	(2) ydl.sh /path/to/url.list.txt
	(3) ydl.sh -u
	END
}

# Check if the youtube-dl is there
test ! -e $YTB && { echo -e "\n${YTB} doesn't exist\nWait a moment, \
we're going to install it...\n"; UPDATE; }

if [ "X$1" != "X" ]; then
	if [ -s "$1" -a -r "$1"  ]; then
		$YTB_P -a "$1"
	elif [ `grep -F / <<< "$1"` ]; then
		$YTB_P "$1"
	elif [ "$1" == "-u" -o "$1" == "-U" ]; then
		UPDATE
	else
		USAGE
	fi
else
	USAGE
fi
