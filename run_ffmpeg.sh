#!/bin/bash

filter=scale=480:-1,crop=480:160:0:0,paletteuse=dither=bayer:bayer_scale=0

while :
do
  for file in org/*.mp4
    do
    ffmpeg -re -i "$file" -i palette.png -an -vcodec libx264 -preset ultrafast -tune zerolatency -crf 18 -filter_complex $filter -f mpegts udp://127.0.0.1:1234
  done
done
