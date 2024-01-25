delete from
    flights;

with landing as (
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
        left join flights fl on lg.hex = fl.hex
        and lg.ts_epoch = fl.ts_epoch
    where
        fl.hex is null
)
insert into
    flights
select
    *
from
    newer;

delete from
    flight_landing;