// Let's try this shit in Node
// ffmpeg -re -i org/video_1.mp4 -an -f matroska - | mplayer -

const { spawn } = require("child_process");
const { readdirSync } = require("fs");
const { extname, join } = require("path");
const { Transform } = require("stream");

const middleMan = new Transform({
  transform(chunk, encoding, callback) {
    this.push(chunk);
    callback();
  }
});

// List videos in folder
const folder = join(".", "org");
const files = readdirSync(folder).filter(f => extname(f) === ".mp4");
let curFile = 0;

// Start mplayer
const mplayer = spawn("mplayer", ["-"]);
middleMan.pipe(mplayer.stdin);

// Play a single video
const playNext = () => {
  console.log("playing", files[curFile]);
  const ffmpeg = spawn("ffmpeg", [
    "-re",
    "-i",
    join(folder, files[curFile]),
    "-an",
    "-filter_complex",
    "scale=480:-1,crop=480:160:0:0",
    "-f",
    "matroska",
    "-"
  ]);
  ffmpeg.stdout.pipe(
    middleMan,
    { end: false }
  );
  ffmpeg.on("close", () => {
    playNext();
  });
  ffmpeg.on("error", e => console.log(e));
  curFile++;
  if (curFile >= files.length) {
    curFile = 0;
  }
};

playNext();
