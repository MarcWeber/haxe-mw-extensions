package mw;
import haxe.macro.Expr;

class Macro {

  // taken from Parsex
  @:macro public static function cached<T>(exp : ExprOf<Void -> T>) : ExprOf<Void -> T> {
    return
      macro {
        var value = null;
        var computationRequested = false;
        function () {
          if (!computationRequested) {
            computationRequested = true; // not null to prevent live lock if it forms a cycle.
            value = $exp;
          }
          return value;
        };
      };
  }
}
