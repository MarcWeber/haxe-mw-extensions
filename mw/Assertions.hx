package mw;
import haxe.macro.Expr;
import haxe.macro.Context;

using mw.ArrayExtensions;

class Assertions {

  @:macro static public inline function assert_nn(e:Expr) {
    var to_m: Expr -> Expr = function(e){
      var s = tink.macro.tools.ExprTools.toString(e)+" was null";
      return macro if ($e == null) throw $v{s};
    }

    switch (e.expr){
      case EArrayDecl(values):
        return { expr: EBlock(values.mapA(to_m)), pos: Context.currentPos()}
      case _: return to_m(e);
    }
  }

}
