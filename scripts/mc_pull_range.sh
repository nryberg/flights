#!/bin/bash
#
pattern="16952*.json"
outdir="/Users/nick/Documents/GitHub/nryberg/flights/data"  # Mac
outdir="/home/nick/develop/GitHub/nryberg/flights/data"  # littlebox

mc find littlebox/flights --name $pattern --exec "mc cp {} $outdir"
