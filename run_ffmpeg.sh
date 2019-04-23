#!/bin/bash

# To test:
# 1. Watch the ffmpeg output and tweak -preset to be the right-most preset below
#    where the encoder is keeping up with our desired output frame rate.
#    Presets: ultrafast, superfast, veryfast, faster, fast, medium
# 2. Tweak -maxrate if the video quality looks bad. The same with -bufsize

# More info can be found here:
# https://trac.ffmpeg.org/wiki/EncodingForStreamingSites
# https://trac.ffmpeg.org/wiki/StreamingGuide

filter=scale=480:-1,crop=480:160,paletteuse=dither=bayer:bayer_scale=0

while :
do
  for file in org/*.mp4
    do
    ffmpeg -re -i "$file" -i palette.png -an -vcodec libx264 -preset ultrafast -tune zerolatency -framerate 30 -crf 18 -g 60 -maxrate 1984k -bufsize 3968k -filter_complex $filter -f mpegts udp://127.0.0.1:1234
  done
done
