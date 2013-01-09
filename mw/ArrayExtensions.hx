package mw;
import haxe.macro.Expr;

class ArrayExtensions {

   static public function mapA<T,R>(arg:Array<T>, f:T -> R):Array<R> {
     var r = [];
     for (x in arg)
       r.push(f(x));
     return r;
   }

   static public function mapAI<T,R>(arg:Array<T>, f: Int -> T -> R):Array<R> {
     var i = 0;
     var r = [];
     for (x in arg)
       r.push(f(i++, x));
     return r;
   }

   static public function filterA<T>(arg:Array<T>, f:T -> Bool):Array<T> {
     var r = [];
     for (x in arg)
       if (f(x))
       r.push(x);
     return r;
   }

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

  static public function contains<T>(a:Array<T>, e:T) {
    for(x in a)
      if (x == e)
        return true;
    return false;
  }

  static public function concatenateArrays<T>(a:Array<Array<T>>): Array<T> {
    var r = [];
    for (x in a) r.concat(x);
    return r;
  }

  static public function append<T>(a:Array<T>, b:Array<T>) {
    for(x in b) a.push(x);
  }

  static public inline function last<T>(a:Array<T>):Null<T> {
    // TODO: what happens on empty array?
    return a[a.length -1];
  }

  static public function intersperse<T>(a:Array<T>, sep:T):Array<T> {
    var r = [];

    for(x in a){
      r.push(x);
      r.push(sep);
    }
    r.pop();
    return r;
  }

  static public function fold2<A>( it : Array<A>, f : A -> A -> A) : A {
    var r = it[0];
    if (it.length == 0) throw "at least one element expected";
    for (i in (1... it.length))
      r = f(r, it[i]);
    return  r;
  }

  static public function difference<T>(a:Array<T>, b:Array<T>, ?eq: T -> T -> Bool) {
    var r = [];
    for(x in a)
      if (!ArrayExtensions.contains(b, x))
        r.push(x);
    return r;
  }

  static public inline function empty<T>(a:Array<T>) {
    return a.length == 0;
  }

  static public function join<T>(a:Array<Array<T>>):Array<T> {
    var r = [];
    for(x in a) ArrayExtensions.append(r, x);
    return r;
  }

  @:macro static public function first_or_null<T>(in_:ExprOf<Array<T>>, cond:Expr):ExprOf<Null<T>> {
    return macro {
      for(_ in $in_){
        if ($cond)
          return _;
      }
      return null;
    }
  }

}
