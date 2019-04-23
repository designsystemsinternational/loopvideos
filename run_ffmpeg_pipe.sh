#!/bin/bash

# To test:
# 1. Watch the ffmpeg output and tweak -preset to be the right-most preset below
#    where the encoder is keeping up with our desired output frame rate.
#    Presets: ultrafast, superfast, veryfast, faster, fast, medium
# 2. Tweak -maxrate if the video quality looks bad. The same with -bufsize

# More info can be found here:
# https://trac.ffmpeg.org/wiki/EncodingForStreamingSites
# https://trac.ffmpeg.org/wiki/StreamingGuide

filter=scale=480:-1,crop=480:160:0:0,paletteuse=dither=bayer:bayer_scale=0

while :
do
  for file in org/*.mp4
    do
    ffmpeg -re -i "$file" -i palette.png -an -filter_complex $filter -f matroska -
  done
done
