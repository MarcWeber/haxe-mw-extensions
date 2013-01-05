package mw;
class HashExtensions {
  static public function eachKeyValue<T>(x:Hash<T>, f) {
    for( k in x.keys() )
      f(k, x.get(k));
  }

  static public function keysAsArray<T>(x:Hash<T>) {
    var r = [];
    for(y in x.keys()) r.push(y);
    return r;
  }
}
