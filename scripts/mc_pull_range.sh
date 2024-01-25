#!/bin/bash
#
pattern="16951*.json"
outdir="/home/nick/develop/GitHub/nryberg/flights/data"  # littlebox
outdir="/Users/nick/Documents/GitHub/nryberg/flights/data"  # Mac

mc find littlebox/flights --name $pattern --exec "mc cp {} $outdir"
