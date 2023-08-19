cd /run/dump1090-fa/

for file in *
do
  NEW_FILENAME=$(stat "$file" --format %Y)
  cp "$file" "/home/nick/Documents/Develop/GitHub/nryberg/flights/archive/$NEW_FILENAME.json"
done

s3cmd put "/home/nick/Documents/Develop/GitHub/nryberg/flights/archive/*" s3://flights
