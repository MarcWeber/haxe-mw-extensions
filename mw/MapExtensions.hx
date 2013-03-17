package mw;
class MapExtensions {
  static public function eachKeyValue<T>(x:Map<String, T>, f) {
    for( k in x.keys() )
      f(k, x.get(k));
  }


  static public function mapKVA<K,V,R>(x:Map<K, V>, f:K -> V -> R):Array<R> {
    var r = [];
    for(k in x.keys())
      r.push(f(k, x.get(k)));
    return r;
  }

  static public function keysAsArray<T>(x:Map<String, T>) {
    var r = [];
    for(y in x.keys()) r.push(y);
    return r;
  }
}
