using ArrayExtensions;
using macro.Lambda;

class Test {

  static function main() {
    // ArrayExtensions.show(bar);
    var expect: String -> Array<Dynamic> -> Array<Dynamic> -> Void = 
      function(msg, a, b){ if (a != b) trace(msg + " failed expected: "+a+" got : "+b); }

    var l:Array<Int> = [2, 3];
    expect("array map", [2, 3],  [1, 2].l1(map,  _+1) );
    expect("array filter", [2], [1, 2].l1(filter, _ > 1) );
    expect("array map", [2, 3],  [1, 2].l1(map, _+1) );

    trace("done");
    trace(l == l);
    trace(Lambda.eval()());
  }
}
