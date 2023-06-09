import requests
import config
import json

flight = 'SKW3871'

aero_api_key = config.AeroAPI

url = 'https://aeroapi.flightaware.com/aeroapi/flights/SCX262'
#payload = {'some': 'data'}
headers = {'x-apikey': aero_api_key}

r = requests.get(url, headers=headers)
aero_json = r.text


def extract_json_fields(aero):
    # with open('aero_api.json') as f:
    #     aero = json.load(f)

    #     a_flight = flights[0]


    flights = aero['flights']
    for flight in flights:
        if flight['status'][0:8] == 'En Route':
            origin = flight['origin']['code']
            destination = flight['destination']['code']
            route_distance = flight['route_distance']
            filed_airspeed = flight['filed_airspeed']
            filed_altitude = flight['filed_altitude']
            route = flight['route']
            ident  = flight['ident']
            print(flight['flight_number'])
            print(origin, destination)
            print(route_distance)
            print(filed_airspeed)
            print(ident)
