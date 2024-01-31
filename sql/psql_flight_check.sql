--- Flights 
with frames as (
    SELECT
        distinct icao24
    FROM
        airframes af
        JOIN flights fl on fl.hex = af.icao24
    WHERE
        operatorcallsign is not null
        and operatorcallsign <> ''
        and typecode <> ''
        AND operator <> ''
),
flights as (
    SELECT
        fl.*,
        substring(ts_iso8601, 1, 10) as ts_date,
        SUBSTRING(ts_iso8601, 12, 8) as ts_time
    FROM
        flights fl
        join frames fr on fl.hex = fr.icao24
    where
        alt > 30000
        and groundspeed > 0
),
max_daily as (
    SELECT
        max(ts_epoch) as max_ts_epoch,
        hex,
        ts_date
    from
        flights
    GROUP BY
        hex,
        ts_date
    ORDER by
        ts_date
),
airframes as (
    SELECT
        distinct icao24,
        registration,
        -- manufacturericao,
        manufacturername,
        model,
        typecode,
        operator,
        operatorcallsign,
        operatoricao,
        owner_name,
        built
    FROM
        airframes
)
SELECT distinct 
    icao24,
    flight,
    fl.ts_date,
    ts_time,
    alt,
    round(track) as track,
    round(groundspeed) as groundspeed,
    af_category,
    registration,
    manufacturername,
    model,
    typecode,
    operator,
    operatorcallsign,
    operatoricao,
    owner_name,
    built
FROM
    flights fl
    JOIN max_daily md ON fl.hex = md.hex
    AND fl.ts_epoch = md.max_ts_epoch
    join airframes af ON fl.hex = af.icao24
    order by icao24,ts_date, ts_time