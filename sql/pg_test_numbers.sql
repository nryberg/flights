SELECT *
from flights
LIMIT 10;

SELECT min(ts_epoch) as min_ts, max(ts_epoch) as max_ts
FROM flights;