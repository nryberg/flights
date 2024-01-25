#!/bin/bash

echo 
# get filenames
IMPFILES=(results/*.csv)

# import the files
for i in ${IMPFILES[@]}
    do
        echo $i
        psql $PG_LITTLEBOX -c "\\copy flight_landing from '$i' DELIMITER ',' CSV HEADER"
        psql $PG_NEON -c "\\copy flight_landing from '$i' DELIMITER ',' CSV HEADER"
        # move the imported file
        mv $i ./archive
    done

psql $PG_LITTLEBOX -c "
delete from  flights;

with landing as 
(
select
	distinct *
from
	flight_landing fl
where
	alt > 0
	and speed > 0
),
newer as (
select
	lg.*
from
	landing lg
left join flights fl
on
	lg.hex = fl.hex
	and lg.ts_epoch = fl.ts_epoch
where fl.hex is null
)
insert
	into
	flights 
select
	*
from
	newer
	;

delete from flight_landing ;"


psql $PG_NEON -c "
delete from  flights;

with landing as 
(
select
	distinct *
from
	flight_landing fl
where
	alt > 0
	and speed > 0
),
newer as (
select
	lg.*
from
	landing lg
left join flights fl
on
	lg.hex = fl.hex
	and lg.ts_epoch = fl.ts_epoch
where fl.hex is null
)
insert
	into
	flights 
select
	*
from
	newer
	;

delete from flight_landing ;"