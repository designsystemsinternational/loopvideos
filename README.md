# Loop videos

This repo uses `ffmpeg` and `mplayer`, which can be installed via Homebrew on mac, or manually on windows.

To test this repo, first run `bash run_ffmpeg.sh`, then in another window run `bash run_mplayer.sh`.

Read the `run_ffmpeg.sh` comments for how to tweak the quality of the video.


# Pipe stream 


Just run `bash run_ffmpeg_pipe.sh | mplayer -cache 8192 -`

****this works like a charm on a mac, but fails on windows. Help Wanted****
