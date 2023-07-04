with fix_ts as (
    select
        epoch_ms(cast(ts_epoch_seconds * 1000 as bigint)) as timestamp_gmt,
        hex,
        flight,
        speed,
        altitude,
        track,
        vertical_rate,
        aircraft_category,
        latitude,
        longitude
    from
        'dump_1090_history_processed.json'
),
correct_timezone as (
    select
        timestamp_gmt - INTERVAL 5 HOUR as timestamp_cst, 
        timestamp_gmt,
        hex,
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
CREATE TABLE IF NOT EXISTS dump_1090 (
    timestamp_cst timestamp,
    timestamp_gmt timestamp,
    hex varchar(6),
    flight varchar(8),
    speed int,
    altitude int,
    track int,
    vertical_rate int,
    aircraft_category varchar(8),
    latitude float,
    longitude float
)
FROM correct_timezone  