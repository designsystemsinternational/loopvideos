#!/usr/bin/env bash

sierra=scale=480:-1,crop=480:160,pad=1280:768:0:0:black,paletteuse=dither=sierra2
sierra2=scale=480:-1,crop=480:160,pad=1280:768:0:0:black,paletteuse=dither=sierra2_4a

bayer=scale=480:-1,crop=480:160,hue=s=-10:b=2,pad=1280:768:0:0:black,paletteuse=dither=bayer:bayer_scale=0
bayer2=scale=480:-1,crop=480:160,hue=s=-10:b=2,paletteuse=dither=bayer:bayer_scale=2
bayerstack=hstack=inputs=3,scale=-1:160,crop=480:160,hue=b=-1,paletteuse=dither=bayer:bayer_scale=0




for file in $1/*.mp4
  do
  ffmpeg -i "$file" -i "$file" -i "$file" -i palette.png -filter_complex $bayerstack -an "$file.led.mp4"
done
