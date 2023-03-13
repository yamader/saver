module saver.utils;

import std;

auto tempf() {
  string path;
  do path = tempDir ~ "saver-" ~
    byCodeUnit(digits ~ uppercase).randomSample(16).to!string;
  while (path.exists);
  return File(path, "wb");
}
