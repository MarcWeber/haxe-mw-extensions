package mw.macro;

import haxe.macro.Expr;
import haxe.macro.Context;

class ExprExtensions {

  static public function as_string(e:ExprOf<String>):Null<String> {
    return switch (e.expr) {
      case (EConst(y)):
        switch (y) {
          case CIdent(s): s;
          case CString(s): s;
          case _: null;
        }
      case _: null;
    }
      mw.ReflectionExtensions.value_at_path(e.expr, ["EConst",0,"CString",0]);
  }
  static public function as_cident(e:ExprOf<Bool>):Null<String> {
    return mw.ReflectionExtensions.value_at_path(e.expr, ["EConst",0,"CIdent",0]);
  }

  // useful for debugging an expression
  macro static public function trace(e:haxe.macro.Expr):haxe.macro.Expr {
    trace(e);
    return e;
  }

}
