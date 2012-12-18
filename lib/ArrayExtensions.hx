import haxe.macro.Expr;

class ArrayExtensions {

//   static public function map<T,R>(arg:Array<T>, f:T -> R):Array<R> {
//     var r = [];
//     for (x in arg)
//       r.push(f(x));
//     return r;
//   }

//   static public function filter<T>(arg:Array<T>, f:T -> Bool):Array<T> {
//     var r = [];
//     for (x in arg)
//       if (f(x))
//       r.push(x);
//     return r;
//   }

  static public function both_left_right<T>(a:Array<T>, b:Array<T>) {
    var b_ = b.copy();
    var left = [];
    var both = [];
    for (x in a)
      if (b_.remove(x))
        both.push(x)
      else left.push(x);
    return { left: left, both: both, right: b_};
  }

  static public function find<T>(a:Array<T>, f: T -> Bool):Null<T> {
    for(x in a)
      if (f(x)) return x;
    return null;
  }

  static public function concatenateArrays<T>(a:Array<Array<T>>): Array<T> {
    var r = [];
    for (x in a) r.concat(x);
    return r;
  }

}
