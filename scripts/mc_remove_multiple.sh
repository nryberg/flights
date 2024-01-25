#!/bin/bash

echo 
# get filenames
IMPFILES=(data/*.json)

# import the files
for i in ${IMPFILES[@]}
    do
        echo $i
	mc rm box/flightaware/$i
        # psql $PG_NEON -c "\\copy flight_landing from '$i' DELIMITER ',' CSV HEADER"
    done

