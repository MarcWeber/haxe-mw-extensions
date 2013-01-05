package mw;
using Lambda;
using HashExtensions;

class IteratorExtensions {
  static public function dups(a:Iterable<String>):Array<String> {
    var r = [];
    var seen = new Hash<String>();
    var dups = new Hash<String>();
    for( x in a ){
      if (seen.exists(x))
        dups.set(x, null);
      seen.set(x, null);
    }
    return dups.keysAsArray();
  }

}
