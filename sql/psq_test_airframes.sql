select 
*
from airframes
limit 10


delete from airframes
where icao24 = 'ica024';

SELECT count(distinct(hex)) as counter 
from flights fl 
left JOIN airframes af on af.icao24 = fl.hex
where af.icao24 is not null
LIMIT 10

SELECT distinct af.*
from airframes af
-- TABLESAMPLE BERNOULLI (10)
JOIN flights fl on fl.hex = af.icao24
-- LIMIT 100;

--- Airframes 
SELECT distinct icao24,
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
FROM airframes af
-- TABLESAMPLE BERNOULLI (10)
JOIN flights fl on fl.hex = af.icao24
WHERE operatorcallsign is not null
and operatorcallsign <> ''
and typecode <> ''
AND operator <> ''
oRDER by operatorcallsign

--- Flights 
with frames as (
SELECT distinct icao24
FROM airframes af
JOIN flights fl on fl.hex = af.icao24
WHERE operatorcallsign is not null
and operatorcallsign <> ''
and typecode <> ''
AND operator <> ''
)
SELECT *
FROM flights fl
join frames fr 
on fl.hex = fr.icao24

-- LIMIT 10;