#!/usr/bin/env bash

# Why? University server aka "Helios" forbids usage of Oracle SQL directories
# Which's completely reasonable
# So I can't read photos directly from script
# Therefore, this script exists

DIR="employee_photos"
OUTSQL="load_images_bindata.sql"

rm -- "${OUTSQL}" &>/dev/null
i=1
# for i in $(seq -f "%03g" 1 104);
while [[ $i -le 104 ]]
do
	f="${DIR}/$(printf %03g $i).jpg";
	echo "$f"

	# For some reason, it doesnt work on se.ifmo.ru, but works on my ubuntu station
	hex=$(od -xA n "$f" | tr '\n' ' ' | sed 's/[ \t]//g');
	echo -e "insert into images values (	null, TO_BLOB(\n'${hex}'\n));\n" >> "${OUTSQL}";
	(( i++ ))
done


