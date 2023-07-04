with fix_ts as (
    select epoch_ms(cast(ts_epoch_seconds * 1000 as bigint)) as timestamp_gmt
    from 'dump_1090_history_processed.json'
),
correct_timezone as (
    select timestamp_gmt - INTERVAL 5 HOUR as timestamp_cst
    from fix_ts
)
SELECT timestamp_cst,
    count(*) as count
from correct_timezone
group by timestamp_cst
order by timestamp_cst desc
limit 5;