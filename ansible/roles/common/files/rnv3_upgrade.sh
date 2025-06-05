#!/bin/bash
#
# Purpose: Upgrade an existing RNV3 installation in situ while retaining key files
#
#          Process Flow:
#          1) Backup/Stage RNV3 key directories 
#          2) Uninstall existing RNV3 installation
#          3) git clone new repository
#          4) Restore/UnStage RNV3 key directories 
#          5) install_and_upgrade 
#          6) verification tool
#
# Author:  Richard Creasey (AI4Y)
# Created: 28-July-2024
#
# Input parameter:
#   1. Input Repo URL / branch name
#       ./rnv3_upgrade.sh  "https://github.com/jekhokie/raspberry-noaa-v3.git -b aarch64-support"
#
ACNT=$#
REPO=$1
BARG=$2
BRANCH=$3

echo ""
if [[ -z ${REPO} ]]; then
  echo "Argument required:  ./rnv3_upgrade.sh  https://github.com/jekhokie/raspberry-noaa-v3.git -b aarch64-support"
  echo ""
  exit 1
fi

if [[ ${ACNT} -gt 1 ]]; then
  if [[ ${BARG} != "-b" ]]; then
    echo "2nd Argument must be -b"
    echo ""
    echo "                 ./rnv3_upgrade.sh  https://github.com/jekhokie/raspberry-noaa-v3.git -b aarch64-support"
    echo ""
    exit 1
  fi
fi

# ...rest of the script is identical to rn2_upgrade.sh, just with the filename and any v2 references updated to v3 if present...
