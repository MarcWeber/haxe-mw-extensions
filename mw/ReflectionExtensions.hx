package mw;
import Type;
class ReflectionExtensions {

  // sample usage:
  // value_at_path([1], ['array-length:2']) => null
  // value_at_path([1], ['array-length:1', 0]) => 1
  // value_at_path(EnumConstructor("first","second"), ["EnumConstructor", 1]) => "second"
  // value_at_path(EnumConstructor("first","second"), [~/EnumConstructor/, 1]) => "second"

  // TODO: check that Enum constructors exist! - thus turn this into a macro

  static public function value_at_path(e:Dynamic, selector:Array<Dynamic>): Null<Dynamic>{
    var enum_name_matched = false;

    var i = 0;
    while (i < selector.length) {
      var x:Dynamic = selector[i++];
      switch (Type.typeof(x)) {
        case TFunction:
          e = x(e);
        case _: 
          switch (Type.typeof(e)) {
            case (TEnum(ee)):
              if (enum_name_matched){
                // match constructor param
                enum_name_matched = false;

                // assume x is Int
                var tenum_name = Type.getEnumName(ee);
                var ep = Type.enumParameters(e);
                var name = Type.getEnumConstructs(ee);
                e = Type.enumParameters(e)[x];

              } else {
                // match constructor
                var name = Type.getEnumConstructs(ee)[Type.enumIndex(e)];
                if (Std.is(x, String))
                  if (name != x) e = null;
                else if (Std.is(x, EReg))
                  if (!x.match(name)) e = null;
                enum_name_matched = true;
              }
            case _:
              if (Std.is(e, Array)){
                var e_as_arr = cast(e, Array<Dynamic>);
                if (Std.is(x, Int)){
                  e = e[x];
                } else if (x == "array-length"){
                  if (e_as_arr.length != selector[i++]) { e = null; }
                } else if (x == "array-length-gt"){
                  if (e_as_arr.length <= selector[i++]) { e = null; }
                }
              } else throw "no implementation";
          }
      }
      if (e == null) break;
    }
    return e;
  }
}
