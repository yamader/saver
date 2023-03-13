module saver.store;

import std;

struct Item {
  string url;
  time_t time;
  string hash;
}

synchronized class Store {
  private Item[][string] items;

  this(string path = "~/.saver".expandTilde) {
    if(!path.exists)
      path.mkdir;
    else if(!path.isDir)
      fatal(path ~ " is not a directory");

    foreach(string name; path.dirEntries(SpanMode.depth)) {
      auto a = name.split("-");
      auto url = Base64URLNoPadding.decode(a[0..$-2].join('-')).to!string;
      items[url] ~= Item(url, a[$-2].to!time_t, a[$-1]);
    }
  }

  void register(Item item, string path) {
    auto encoded = Base64URLNoPadding.encode(cast(ubyte[])item.url);
    path.rename([encoded.to!string, item.time.to!string, item.hash].join('-'));
    items[item.url] ~= item;
  }
}
