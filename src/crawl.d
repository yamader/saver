module saver.crawl;

import std;
import std.digest.md;
import saver.store;
import saver.utils;

auto dl(string url) {
  auto file = tempf;
  auto hash = new MD5Digest;
  foreach(chunk; url.byChunkAsync) {
    file.write(cast(char[])chunk);
    hash.put(chunk);
  }
  file.flush;
  return tuple!("url", "file", "hash")
    (url, file, hash.finish.to!string);
}

auto crawl(string url) {
  auto res = dl(url);
  res.writeln;
  //Clock.currTime.toUTC,
}
