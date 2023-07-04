# Process a series of json files using jq
# First gather all of the current files into one
jq -s . ~/dump1090-fa/history*.json > dump_1090_history.json

# Then process the file to extract the data we want
jq '.[] | {now: .now, aircraft: .aircraft[]} | {ts_ms: .now, hex: .aircraft.hex, flight: .aircraft.flight, speed: .aircraft.gs, altitude: .aircraft.alt_baro, track: .aircraft.track, vertical_rate: .aircraft.baro_rate, aircraft_category: .aircraft.category, latitude: .aircraft.lat, longitude: .aircraft.lon } ' dump_1090_history.json > dump_1090_history_processed.json
