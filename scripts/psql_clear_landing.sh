#!/bin/bash

# get filenames
IMPFILES=(path/FileNamepart.csv)

# import the files
for i in ${IMPFILES[@]}
    do
        psql -U user -d database -c "\copy TABLE_NAME from '$i' DELIMITER ';' CSV HEADER"
        # move the imported file
        mv $i /FilePath
    done