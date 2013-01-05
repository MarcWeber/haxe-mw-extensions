package mw;
using haxe.macro.Expr;

class ExprExtensions {
  @:macro static public function trace(e:Expr) {
    trace(e);
    return e;
  }
}
