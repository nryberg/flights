#!/bin/bash

root='/Users/nick/Documents/GitHub/nryberg/flights'  # Mac
root='/home/nick/develop/GitHub/nryberg/flights'  # Littlebox

7z a $root/flight_data.7z $root/data/*.json
