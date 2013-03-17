package mw;
using Lambda;
using mw.HashExtensions;

class IteratorExtensions {
  static public function dups(a:Iterable<String>):Array<String> {
    var r = [];
    var seen = new Map<String, String>();
    var dups = new Map<String, String>();
    for( x in a ){
      if (seen.exists(x))
        dups.set(x, null);
      seen.set(x, null);
    }
    return dups.keysAsArray();
  }

}
