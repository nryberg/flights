# flights
Process Flight ADS-B Info

## Cleanup Old Archive Files

[Script](./clean_archive_over_30.sh)

Reference [How to Delete Files Older than 30 days in Linux](https://tecadmin.net/delete-files-older-x-days/)

## Sample Data 

Let's get a collection of data and push it into CSV file for processing.

### Contrails in the dark

Can I build a database of high flying planes that commonly shoot over the house?

All I need is the beginning and ending altitudes to mostly match.  A plane that's flying over the house will vary very little up and down, and will typically never vary speed. 

Doing the math - if I'm watching the plane, they'll be on the screen for a max of 10 minutes at most. 

Say my typical range is about 25 miles.  That's optimistic.

They're going to show up on a range of about 10 minutes at most.  They're high flying after all.

Plane ID
Flight
Altitude
Speed
Timestamps
Track

I don't even need their LAT/LON actually.  Though for data purposes I do. 

The short version of this is that it's got to be done simply, fast and with enough detail to make something interesting. 

It'll be cool to build in the API calls to get flight information, but I'm not holding my breath. 

Maybe the more common Flights I'll look up using the API, which is good for 1,000 calls a month. 

For now though, I just need to get it in gear. 

### Process

- Pull Series of flights
- Extract the flight data - everything, don't worry about the details
- Upload the data into databases
  - DuckDB
  - PostGres on Neon?
  - Parquet
- Compress the data series
- Multiple store the series
- Delete them from Minio
- Go back and fetch the next series



## TODO

### Data Storage Problem

The volume of data is just off the hook - I haven't implemented any sort of archival process because I really don't have a 321 storage solution for the raw data.  

If I _knew_ that the data was being stored carefully, I could get on with my life, but now I've got a huge wodge of data that's just sitting there.  I should just delete and start over.  That way I can build something more streamlined. 

And accept the fact that I'm not really doing anything with this.

### Flight Lookup 

Implement some sort of Python flight data capture up to a limit
