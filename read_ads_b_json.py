# Read the ads-b.json file and convert to csv

import json
import csv
import os
import sys
import duckdb

input_file_folder = sys.argv[1]

# Check argv for input file and run single or directory mode
def process_path():
     
    # Check if input_file_folder is a directory or a file
    if os.path.isdir(input_file_folder):
        print("is folder")
        for file_name in os.scandir(input_file_folder):
            # print(file_name.path)
            file_path = os.path.join(input_file_folder, file_name)
            if os.path.isfile(file_path):
                print(file_name.name)
                if file_name.name != '.DS_Store':
                    process_file(file_path)

    else:
        print("is not a folder")
        full_file_name = os.path.basename(input_file_folder)
        file_name = full_file_name.split('.')[0]
        if len(sys.argv) > 2:
            output_file_folder = sys.argv[2]
            output_csv_file = output_file_folder + '/' + file_name + '.csv'
        else:
            output_csv_file = file_name + '.csv'

def process_file(input_file_name):
    records = read_ads_b_json(input_file_name)
    write_to_duckdb(records)

# Read the ads-b.json file and return an array of records
def read_ads_b_json(input_json_file):
    records = []
    # Read the ads-b.json file
    with open(input_json_file) as f:
        data = json.load(f)
        # Loop through aircraft array

        # Check if this is the right type of file

        if "now" in data:
            timestamp = data['now']
            record   = []

            for aircraft in data['aircraft']:
                hex = aircraft['hex']
                if 'flight' in aircraft:
                    flight = aircraft['flight'].strip()
                else:
                    flight = ''

                if 'lat' in aircraft:
                    lat = aircraft['lat']
                else:
                    lat = 0
                if 'lon' in aircraft:
                    lon = aircraft['lon']
                else:
                    lon = 0
                if 'alt_baro' in aircraft:
                    alt_baro = aircraft['alt_baro']

                    # Trap Ground readings 
                    if alt_baro == 'ground':
                        alt_baro = 0
                else:
                    alt_baro = 0
                if 'alt_geom' in aircraft:
                    alt_geom = aircraft['alt_geom']
                else:
                    alt_geom = 0

                if 'baro_rate' in aircraft:   
                    baro_rate = aircraft['baro_rate']
                else:
                    baro_rate = 0

                if 'category' in aircraft:
                    category = aircraft['category']
                else:
                    category = 'n/a'

                if 'track' in aircraft:
                    track = aircraft['track']
                else:
                    track = 0
                
                if 'gs' in aircraft:
                    gs  = aircraft['gs']
                else:
                    gs = 0

                record = [timestamp, hex, flight, lat, lon, alt_baro, alt_geom, baro_rate, category, track, gs]
                
                records.append(record)
        return records
    
# Write results to CSV file
def write_to_csv_file(output_csv_file, record):
    # Write to csv file
    output_csv_file = create_csv_file()
    csv_writer = csv.writer(output_csv_file)
    for record in records:
        csv_writer.writerow(record)

# Create DuckDB database and ads table
def create_duckdb_database():
    # Create DuckDB database
    con = duckdb.connect('ads.db')

    # Create DuckDB table
    con.execute('DROP TABLE IF EXISTS ads')

    con.execute('CREATE TABLE ads (epoch DOUBLE, hex VARCHAR, flight VARCHAR, lat DOUBLE, lon DOUBLE, alt_baro int64, alt_geom int64, baro_rate int64, category VARCHAR, track DOUBLE, gs DOUBLE)')

    # Close DuckDB connection
    con.close()    

# Write results to DuckDB
def write_to_duckdb(records):
    # Create DuckDB database
    con = duckdb.connect('ads.db')

    # Insert records into DuckDB table
    for record in records:
        con.execute('INSERT INTO ads VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)', record)

    # Query DuckDB table
    con.execute('SELECT * FROM ads')

    # Close DuckDB connection
    con.close()

# Print Records 
def print_records(records):
    for record in records:
        print(record)


# Create output csv file
def create_csv_file():
    f = open('ads.csv', 'w')

    # Write header
    header = ['timestamp', 'hex', 'flight', 'lat', 'lon', 'alt_baro', 'alt_geom', 'baro_rate', 'category', 'track', 'gs']
    csv_writer = csv.writer(f)
    csv_writer.writerow(header)

    return f 

# Main
#create_duckdb_database()

# Look at the args and process path
process_path()

#records = read_ads_b_json('ads.json')

#write_to_csv_file(output_csv_file, records)
#print_records(records)
#write_to_duckdb(records)


# output_csv_file.close()


