package mw.util;
import haxe.macro.Expr;
import haxe.macro.Context;

/*
   concatenate expressions evaluating to a string.
   If two adjecent strs are added they'll be concatenated
*/
class StrExprBuilder {
  public var items:Array<Expr>;
  public function new() {
    items = [];
  }

  public function add_str(s:String) {
    // optimize, if last item is string, concatenate. The compiler should be
    // doing it, but is not
    var e:Expr;
    if (items.length > 0){
      var last_s = ReflectionExtensions.value_at_path(ArrayExtensions.last(items).expr, ["EConst",0,"CString",0]);
      if (last_s != null){
        items[items.length-1] = macro $v{last_s + s};
        return;
      }
    }
    items.push(macro $v{s});
  }

  public function expr() {
    return switch(items.length) {
      case 0: macro $v{""};
      case 1: items[0];
      case _:
        var c = items.shift();
        while (items.length > 0){
          var next = items.shift();
          c = macro $c + $next;
        }
        c;
    }
  }
}
