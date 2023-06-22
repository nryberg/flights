#import requests
from opensky_api import OpenSkyApi
import config

username = config.opensky_username
password = config.opensky_password




api = OpenSkyApi(username=username, password=password)
#s = api.get_flights_by_aircraft('aa2bc5',1687230030, 1687249764 )
s = api.get_my_states()

#f  = api.get_my_states(,)
f = api.get_flights_by_aircraft('a04064', 1687229650, 1687233098)

print(s)
print(f)


#hex = 'A3FC58'



#url = 'https://opensky-network.org/api/flights/aircraft?icao24=' + hex 

