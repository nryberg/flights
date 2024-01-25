#!/bin/bash
#
pattern="1693*.json"
outdir="/Users/nick/Documents/GitHub/nryberg/flights/data"

mc find littlebox/flights --name $pattern --exec "mc cp {} $outdir"