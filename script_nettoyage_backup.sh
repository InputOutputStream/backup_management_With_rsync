#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: ./script.sh backup_dir exp_days"
    exit 1
fi

BACKUP_DIR=$1
EXP_DAYS=$2

TARGET_EPOCH=$(date -d "$EXP_DAYS days ago" +%s)

for item in "$BACKUP_DIR"/*; do
    if [ -d "$item" ]; then
        DATE_STR=$(basename "$item" | sed -E 's/^[a-zA-Z]+ ([0-9]{2}-[0-9]{2}-[0-9]{4}).*$/\1/')

        if [[ ! $DATE_STR =~ ^[0-9]{2}-[0-9]{2}-[0-9]{4}$ ]]; then
            echo "Le répertoire $item ne contient pas une date valide dans son nom"
            continue
        fi

        DATE_EPOCH=$(date -d "${DATE_STR:6:4}-${DATE_STR:3:2}-${DATE_STR:0:2}" +%s)
        if [ $? -ne 0 ]; then
            echo "Erreur de conversion de la date pour $item"
            continue
        fi

        if [ $DATE_EPOCH -le $TARGET_EPOCH ]; then
            echo "Suppression du répertoire obsolète : $item"
            rm -rf "$item"
        else
            echo "Répertoire conservé : $item"
        fi
    fi
done
