with basis as (
SELECT
	date_trunc('day',
	timestamp_cst) as ts_date,
	hex
from
	flights)
select
	ts_date,
	count(*) as rowcount,
	count(DISTINCT(hex)) as plane_count
from
	basis
group by
	ts_date
order by
	ts_date asc;