-- Desc: This script will store the flights from the land_dump_1090 table
-- into the flights table
INSERT INTO flights 
SELECT 
    timestamp_cst,
    timestamp_gmt,
    ts_epoch_seconds,
    hex ,
    flight_index,
    flight ,
    speed ,
    altitude ,
    track ,
    vertical_rate ,
    aircraft_category ,
    latitude ,
    longitude
from land_dump_1090
WHERE NOT EXISTS (
    SELECT 1
    FROM flights
    WHERE flights.flight_index = land_dump_1090.flight_index
)