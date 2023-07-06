with fix_ts as (
    select
        epoch_ms(cast(ts_epoch_seconds * 1000 as bigint)) as timestamp_gmt,
        ts_epoch_seconds,
        hex,
        concat(cast(ts_epoch_seconds as varchar(20)) , hex) as flight_index,
        flight,
        speed,
        -- 0 as altitude,
        --cast(altitude as VARCHAR) as altitude,
        case when altitude = 'ground' then 0 else cast(altitude as bigint) end as altitude,
        track,
        vertical_rate,
        aircraft_category,
        latitude,
        longitude
    from
        read_json_auto('dump_1090_history_processed.json', 
        columns={ts_epoch_seconds: 'FLOAT', 
        hex: 'VARCHAR', 
        flight: 'VARCHAR', 
        speed: 'INTEGER', 
        altitude: 'VARCHAR', 
        track: 'INTEGER', 
        vertical_rate: 'INTEGER', 
        aircraft_category: 'VARCHAR', 
        latitude: 'FLOAT', 
        longitude: 'FLOAT'})
),
correct_timezone as (
    select
        timestamp_gmt - INTERVAL 5 HOUR as timestamp_cst, 
        timestamp_gmt,
        ts_epoch_seconds,
        hex,
        flight_index,
        flight,
        speed,
        altitude,
        track,
        vertical_rate,
        aircraft_category,
        latitude,
        longitude
    from
        fix_ts
)
INSERT INTO land_dump_1090 (
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
)
FROM correct_timezone  
;

-- CREATE TABLE land_dump_1090 (
--     timestamp_cst timestamp,
--     timestamp_gmt timestamp,
--     ts_epoch_seconds bigint,
--     hex varchar(6),
--     flight_index varchar(20),
--     flight varchar(8),
--     speed int,
--     altitude int,
--     track int,
--     vertical_rate int,
--     aircraft_category varchar(8),
--     latitude float,
--     longitude float
-- );