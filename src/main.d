module saver.main;

import std;
import saver.crawl;
import saver.store;

struct Ctx {
  string[] rec;
  bool tree;
}

auto main(string[] args) {
  enum help = "[saver --help] to get more information about usage.";

  Ctx ctx = {
    tree: true,
  };

  try {
    auto res = getopt(args,
      std.getopt.config.caseSensitive,
      std.getopt.config.bundling,
      "rec|r",      "url patterns for recursive fetching (defaults to targets' FQDN)", &ctx.rec,
      "tree|t",     "show tree stylel log",     &ctx.tree,
    );
    if(res.helpWanted)
      defaultGetoptPrinter(
        "USAGE: saver [opts] <urls>\n" ~
        "OPTS:",
        res.options);
  } catch(GetOptException e) {
    stderr.writeln(e.message);
    stderr.writeln(help);
    return 1;
  }

  if(args.length < 2) {
    stderr.writeln("no url passed. what's wrong?");
    stderr.writeln(help);
    return 0;
  }

  foreach(url; args[1..$]) {
    auto th = spawn(&save, thisTid, );
    writeln(url);
  }

  return 0;
}
