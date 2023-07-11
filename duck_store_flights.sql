-- Desc: This script will store the flights from the land_dump_1090 table
-- into the flights table
INSERT INTO flights 
SELECT 
    dm.timestamp_cst,
    dm.timestamp_gmt,
    dm.ts_epoch_seconds,
    dm.hex ,
    dm.flight_index,
    dm.flight ,
    dm.speed ,
    dm.altitude ,
    dm.track ,
    dm.vertical_rate ,
    dm.aircraft_category ,
    dm.latitude ,
    dm.longitude
from land_dump_1090 as dm 
LEFT JOIN flights
ON flights.flight_index = dm.flight_index
WHERE flights.flight_index IS NULL;
