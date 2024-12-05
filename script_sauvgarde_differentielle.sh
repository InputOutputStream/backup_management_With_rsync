#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
    echo "Usage: ./script_sauvegarde.sh user@source_host:/src_dir dst_dir last_backup_dir"
    exit 1
fi

SOURCE_DIR=$1
TARGET_DIR=$2
LAST_BACKUP_DIR=$3

# Format de la date lundi 21-02-2008 01:30:54
DATE=$(date +"%A %d-%m-%Y %H:%M:%S")

# Jour de la semaine
DAY_OF_WEEK=$(date +"%A")


if [[ "$DAY_OF_WEEK" == "dimanche" ]]; then
    echo "No backup needed on weekends. Exiting."
    exit 0
 fi

NEW_BACKUP_DIR="$TARGET_DIR/$DATE"

if [ -n "$LAST_BACKUP_DIR" ]; then
    rsync -av --del --stats --link-dest="$LAST_BACKUP_DIR" "$SOURCE_DIR" "$NEW_BACKUP_DIR"
else
    rsync -av --del --stats "$SOURCE_DIR" "$NEW_BACKUP_DIR"
fi

echo "Backup Terminé"
