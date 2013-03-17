package mw;
import haxe.macro.Expr;
import haxe.macro.Context;

using mw.ArrayExtensions;

class Assertions {

  static public function assert_nn<T>(x:Null<T>, ?msg:String):T {
    if (x == null) throw 'unexpected null $(msg)';
    return x;
  }

  // @:macro static public inline function assert_nn_m<T>(e:ExprOf<Null<T>>):ExprOf<T> {
  //   var s = tink.macro.tools.ExprTools.toString(e)+" was null";
  //   return macro Assertions.assert_nn($e, $v{s});

  //   //   switch (e.expr){
  //   //     case EArrayDecl(values):
  //   //       return { expr: EBlock(values.mapA(to_m)), pos: Context.currentPos()}
  //   //     case _: return to_m(e);
  //   //   }
  // }
}
