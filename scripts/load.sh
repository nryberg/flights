# All Load script

./rsync_current.sh
./process_json.sh


/home/nick/duckdb ./flights.db < 'duck_clear_dump_1090.sql'
/home/nick/duckdb ./flights.db < 'duck_load_dump_1090.sql'
/home/nick/duckdb ./flights.db < 'duck_store_flights.sql'
