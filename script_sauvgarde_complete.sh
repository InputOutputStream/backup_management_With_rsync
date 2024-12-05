#!/bin/bash

if [ -z $1 ] || [ -z $2 ]
then
	echo "./script.sh user@hostname:/src_dir  dsc_dir"
	exit 1
fi

 if [[ "$SOURCE_DIRS" == *@*:* && "$TARGET_DIR" == *@*:* ]]; then
    echo "Both source and destination are remote. Running rsync from the destination host."
    ssh $(echo $TARGET_DIR | cut -d'@' -f1)@$(echo $TARGET_DIR | cut -d'@' -f2 | cut -d':' -f1) "rsync -av --del --stats $SOURCE_DIRS ${TARGET_DIR##*:}"
else
    rsync -av --del --stats "$SOURCE_DIRS" "$TARGET_DIR"
fi

SOURCE_DIRS=$1
TARGET_DIR=$2

rsync -av --del --stats $SOURCE_DIRS $TARGET_DIR

echo "Backup Terminé"
