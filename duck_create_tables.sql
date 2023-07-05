CREATE TABLE land_dump_1090 (
    timestamp_cst timestamp,
    timestamp_gmt timestamp,
    ts_epoch_seconds bigint,
    hex varchar(6),
    flight_index varchar(20),
    flight varchar(8),
    speed int,
    altitude int,
    track int,
    vertical_rate int,
    aircraft_category varchar(8),
    latitude float,
    longitude float
);

CREATE TABLE flights (
    timestamp_cst timestamp,
    timestamp_gmt timestamp,
    ts_epoch_seconds bigint,
    hex varchar(6),
    flight_index varchar(20),
    flight varchar(8),
    speed int,
    altitude int,
    track int,
    vertical_rate int,
    aircraft_category varchar(8),
    latitude float,
    longitude float
);