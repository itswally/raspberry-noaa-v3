#!/bin/bash
#
# Purpose: Backup or Restore RNV3 key directories 
#          (audio, videos, images, db and config)
#
# Author:  Richard Creasey (AI4Y)
#
# Created: 28-July-2024
#
# Input parameters:
#   1. Input mode  [backup|backup_stage|restore|restore_stage]
# Example:
#         ./rnv3_backup_restore.sh backup
#         ./rnv3_backup_restore.sh backup_stage
#         ./rnv3_backup_restore.sh restore
#         ./rnv3_backup_restore.sh restore_stage

# input params
MODE=$1

echo ""
if [[ -z ${MODE} ]]; then
  echo "Argument required:  ./rnv3_backup_restore.sh backup    or    ./rnv3_backup_restore.sh backup_stage"
  echo "                    ./rnv3_backup_restore.sh restore   or    ./rnv3_backup_restore.sh restore_stage"
  echo ""
  exit 1
else
  vMODE=$(echo ${MODE} | tr '[:upper:]' '[:lower:]')
  if [[ ${vMODE} != "backup" && ${vMODE} != "backup_stage" && ${vMODE} != "restore" && ${vMODE} != "restore_stage" ]]; then
    echo "Argument required:  ./rnv3_backup_restore.sh backup    or    ./rnv3_backup_restore.sh backup_stage"
    echo "                    ./rnv3_backup_restore.sh restore   or    ./rnv3_backup_restore.sh restore_stage"
    echo ""
    exit 1
  fi
fi

start=$(date +%s)

secs_to_human() {
    if [[ -z ${1} || ${1} -lt 60 ]] ;then
        min=0 ; secs="${1}"
    else
        time_mins=$(echo "scale=2; ${1}/60" | bc)
        min=$(echo ${time_mins} | cut -d'.' -f1)
        secs="0.$(echo ${time_mins} | cut -d'.' -f2)"
        secs=$(echo ${secs}*60|bc|awk '{print int($1+0.5)}')
    fi
    printf "%02d:%02d" $min $secs
}

# ...rest of the script is identical to rn2_backup_restore.sh, just with the filename and any v2 references updated to v3 if present...
