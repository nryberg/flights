#!/bin/bash

echo 
# get filenames
IMPFILES=(data/*.json)

# import the files
for i in ${IMPFILES[@]}
    do
        echo $i
        a="$(cut -d'/' -f2 <<<"$i")"
        echo $a
      	mc rm littlebox/flights/$a --force --dangerous
        # psql $PG_NEON -c "\\copy flight_landing from '$i' DELIMITER ',' CSV HEADER"
    done

