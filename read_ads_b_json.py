# Read the ads-b.json file and convert to csv

import json
import csv
import os
import sys

input_json_file = sys.argv[1]

full_file_name = os.path.basename(input_json_file)
file_name = full_file_name.split('.')[0]
print(os.path.basename(file_name))

output_csv_file = file_name + '.csv'


# Read the ads-b.json file
def read_ads_b_json(input_json_file, output_csv_file):
    # Read the ads-b.json file
    with open(input_json_file) as f:
        data = json.load(f)
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
                alt_baro = ''
            if 'alt_geom' in aircraft:
                alt_geom = aircraft['alt_geom']
            else:
                alt_geom = ''

            if 'baro_rate' in aircraft:   
                baro_rate = aircraft['baro_rate']
            else:
                baro_rate = ''

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

            record = [timestamp, hex, flight, lat, lon, alt_baro, alt_geom, baro_rate, category, track, gs]
            
            # Write to csv file
            csv_writer = csv.writer(output_csv_file)
            csv_writer.writerow(record)

                
        # print(aircraft['hex'])
      
# Create output csv file
def create_csv_file():
    f = open('ads.csv', 'w')

    # Write header
    header = ['timestamp', 'hex', 'flight', 'lat', 'lon', 'alt_baro', 'alt_geom', 'baro_rate', 'category', 'track', 'gs']
    csv_writer = csv.writer(f)
    csv_writer.writerow(header)

    return f 


output_csv_file = create_csv_file()
read_ads_b_json('ads.json', output_csv_file)

output_csv_file.close()


