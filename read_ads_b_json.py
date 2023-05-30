# Read the ads-b.json file and convert to csv

import json
import csv
import os
import sys
# import time
# import datetime
# import pandas as pd
# import numpy as np
# import matplotlib.pyplot as plt
# import matplotlib.dates as mdates
# import matplotlib.ticker as ticker

# Read the ads-b.json file
def read_ads_b_json(output_csv_file):
    # Read the ads-b.json file
    with open('ads.json') as f:
        data = json.load(f)

        print(data['now'])
        print(data['aircraft'][0]['hex'])

        # Loop through aircraft array
        timestamp = data['now']
        record   = []

        for aircraft in data['aircraft']:
            hex = aircraft['hex']
            if 'flight' in aircraft:
                flight = aircraft['flight']
            else:
                flight = ''

            if 'lat' in aircraft:
                lat = aircraft['lat']
            else:
                lat = ''
            if 'lon' in aircraft:
                lon = aircraft['lon']
            else:
                lon = ''
            if 'alt_baro' in aircraft:
                alt_baro = aircraft['alt_baro']
            else:
                alt_baro = 'None'
            if 'alt_geom' in aircraft:
                alt_geom = aircraft['alt_geom']
            else:
                alt_geom = ''

            if 'baro_rate' in aircraft:   
                baro_rate = aircraft['baro_rate']
            else:
                baro_rate = ''

            if 'callsign' in aircraft:
                callsign = aircraft['callsign']
            else:
                callsign = ''
            
            if 'category' in aircraft:
                category = aircraft['category']
            else:
                category = ''

            if 'track' in aircraft:
                track = aircraft['track']
            else:
                track = ''
            
            if 'gs' in aircraft:
                gs  = aircraft['gs']
            else:
                gs = ''

            record = [timestamp, hex, flight, lat, lon, alt_baro, alt_geom, baro_rate, callsign, category, track, gs]
            print(record)
            # Write to csv file
            csv_writer = csv.writer(output_csv_file)
            csv_writer.writerow(record)

                
        # print(aircraft['hex'])

        
# Create output csv file
def create_csv_file():
    f = open('ads.csv', 'w')

    # Write header
    header = ['timestamp', 'hex', 'flight', 'lat', 'lon', 'alt_baro', 'alt_geom', 'baro_rate', 'callsign', 'category', 'track', 'gs']
    csv_writer = csv.writer(f)
    csv_writer.writerow(header)
    
    return f 


output_csv_file = create_csv_file()
read_ads_b_json(output_csv_file)

output_csv_file.close()


print('Done!')

