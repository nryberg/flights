import json
# Read JSON file into dictionary
#
with open('aero_api.json') as f:
    aero = json.load(f)
    flights = aero['flights']
    a_flight = flights[0]



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

#    ":334,"filed_airspeed":445,"filed_altitude":320
    #
    # print(route_distance)
