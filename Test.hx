using mw.ArrayExtensions;
using haxe.macro.Expr;
using mw.macro.Lambda;

enum StringOrExpr {
  string(s:String);
  expr(e : Expr); // expression creating string
}

enum Attribute {
  // eg <a href="foo"> <a (..)="foo"> or <a href=(..)>
  name_value(name:StringOrExpr, value:StringOrExpr);

  // eg <html ${}>
  attribute_list(expr: Expr);
}

enum TemplatePiece {
  tag(name:String, attributes: Array<Attribute>, content:Array<TemplatePiece>);
  expr(e:Expr, quoted:Bool);
  text(s:String);

}

class Test {

  // TODO: create a real test suite
  static public function test_l() {
    var expect: String -> Array<Dynamic> -> Array<Dynamic> -> Void = 
      function(msg, a, b){ if (a != b) trace(msg + " failed expected: "+a+" got : "+b); }

    var l:Array<Int> = [2, 3];
    expect("array map", [2, 3],  [1, 2].l1(mapA,  _+1) );
    expect("array filter", [2], [1, 2].l1(filterA, _ > 1) );
    expect("array map", [2, 3],  [1, 2].l1(mapA, _+1) );

    trace("done");
    trace(l == l);
    trace(Lambda.eval()());
  }

  static function main() {
    test_l();
  }
}
