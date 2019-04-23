#!/usr/bin/env bash

sierra=scale=480:-1,crop=480:160,pad=1280:768:0:0:black,paletteuse=dither=sierra2
sierra2=scale=480:-1,crop=480:160,pad=1280:768:0:0:black,paletteuse=dither=sierra2_4a

bayer=crop=550:360,scale=480:-1,crop=480:160,paletteuse=dither=bayer:bayer_scale=0
bayer2=scale=480:-1,crop=480:160,hue=s=-10:b=2,paletteuse=dither=bayer:bayer_scale=2
bayerstack=hstack=inputs=3,scale=-1:160,crop=480:160,hue=b=-1,paletteuse=dither=bayer:bayer_scale=0





ffmpeg -ss 00:01:10 -i "$1" -i palette.png -t 01:43:10 -filter_complex $bayer -an "$1.led.mp4"
