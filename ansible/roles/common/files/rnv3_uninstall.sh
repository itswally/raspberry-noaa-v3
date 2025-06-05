#!/bin/bash
#
# Purpose: The purpose of this uninstall script is to remove the RNV3 environment 
#          and key packages like satdump, meteordemod, predict, wxtoimg, and nginx. As well
#          as removal of RNV3 crontab entries and Audio, Videos and Images in /srv
#
# Author:  Richard Creasey (AI4Y)
#
# Created: July 20th, 2024

start=$(date +%s)

UNINSTALL_LOG=/tmp/uninstall.log
PACKAGES_BULLSEYE="satdump wxtoimg nginx predict php7.4-intl php8.0-sqlite3 php8.0-mbstring php8.0-fpm"
PACKAGES_BOOKWORM="satdump wxtoimg nginx predict php8.2-intl php8.2-sqlite3 php8.2-mbstring php8.2-fpm"
PATHS="/srv/audio /srv/videos /srv/images $HOME/.config/composer $HOME/.config/gmic $HOME/.config/matplotlib $HOME/.config/meteordemod $HOME/.config/composer $HOME/.config/satdump $HOME/raspberry-noaa-v3 $HOME/.predict $HOME/.noaa-v3.conf $HOME/.wxtoimglic $HOME/.wxtoimgrc /usr/local/bin/rtl_* /var/log/raspberry-noaa-v3 /etc/sudoers.d/020_www-data-atrm-nopasswd /var/www/wx-new /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default /tmp/rtl-sdr /etc/modprobe.d/rtlsdr.conf"
SERVICES="phpsessionclean.service phpsessionclean.timer nginx.service"
OS=$(cat /etc/os-release | grep -E "^DEBIAN_CODENAME|^VERSION_CODENAME" | awk -F"=" '{print $NF}' | sort | head -1)

if [[ ${OS} == "bookworm" ]]; then
  PACKAGES=${PACKAGES_BOOKWORM}
elif [[ ${OS} == "bullseye" ]]; then
  PACKAGES=${PACKAGES_BULLSEYE}
else
  echo "Aborting, unsupported Operating System ${OS}"
  exit 1
fi 

secs_to_human() {
    if [[ -z ${1} || ${1} -lt 60 ]] ;then
        min=0 ; secs="${1}"
    else
        time_mins=$(echo "scale=2; ${1}/60" | bc)
        min=$(echo ${time_mins} | cut -d'.' -f1)
        secs="0.$(echo ${time_mins} | cut -d'.' -f2)"
        secs=$(echo ${secs}*60|bc|awk '{print int($1+0.5)}')
    fi
    echo "Time Elapsed : ${min} minutes and ${secs} seconds."
}

# loggit function
loggit() {
  local log_type=$1
  local log_message=$2

  echo "${log_type} : ${log_message}"

  # log output to a log file
  echo $(date '+%d-%m-%Y %H:%M') "${log_type} : ${log_message}" >> "$UNINSTALL_LOG"
}

# ...rest of the script is identical to rn2_uninstall.sh, just with the filename and any v2 references updated to v3 if present...
