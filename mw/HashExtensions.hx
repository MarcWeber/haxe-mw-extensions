package mw;
class HashExtensions {
  static public function eachKeyValue<T>(x:Map<String, T>, f) {
    for( k in x.keys() )
      f(k, x.get(k));
  }

  static public function keysAsArray<T>(x:Map<String, T>) {
    var r = [];
    for(y in x.keys()) r.push(y);
    return r;
  }
}
