package mw;
import Type;
class ReflectionExtensions {

  // sample usage:
  // ReflectionsExtensions.value_at_path(h, ["EConst",0,"CIdent",0]);
  // EConst 0 means get the first value specified of the EConst enum value.
  static public function value_at_path(e:Dynamic, selector:Array<Dynamic>): Null<Dynamic>{
    for (x in selector){
      if (Std.is(x,String)) {

        // make e null if its not an enum of expected name constructor
        switch (Type.typeof(e)){
          case TEnum(ee):
            var name = Type.getEnumConstructs(ee)[Type.enumIndex(e)];
          default:
            return null;
        }

      } else if (Std.is(x, Int)) {


        // follow n'th constructor field
        switch (Type.typeof(e)){
          case TEnum(ee):
            var tenum_name = Type.getEnumName(ee);
            var ep = Type.enumParameters(e);
            var name = Type.getEnumConstructs(ee);
            e = Type.enumParameters(e)[x];
          default:
            return null;
        }

      } else throw "unexpected "+x;
    }
    return e;
  }
}
