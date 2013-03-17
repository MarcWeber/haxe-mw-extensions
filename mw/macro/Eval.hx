package mw.macro;
import haxe.macro.Expr;

class Eval {

  /* usage:
    Eval.expr = Context.parse("2 + 3", Context.currentPos());
    var i:Int = Eval.eval();
  */
  public static var expr:Expr = null; /* its a luck that expr is shared while calling @:macro functions */
  macro static public function eval() {
    return expr;
  }

}
