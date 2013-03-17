package mw.macro;
import haxe.macro.Expr;
import haxe.macro.Context;
using mw.MapExtensions;

class StructureHelpers {

  /*
     var a = { a: "aa", b: "ab", c: "ac"};
     var b = { a: "ba", b: "bb", c: "cc"};
     var c = { a: "ca", b: "cb", c: "cc"};
     c = a.merge(b, c /*, 'override' * /); // same as c = {a: a.a, b: b.b, c:c.c}

    usage: each argument should be a structure. 
    Each structure may be followed by a list of names to be dropped/added like this:
    "-a,b": drop a and b
     "a,b": select and b
    Example:

    a.merge("-b,c", b, "-a,c", c, "c")
    {a: a.a, b: b.b, c:c.c)
  */
  macro static public function sh_merge(args:Array<Expr>):Expr {
    var final_fields = new Map<String, Expr>();

    var l = args.length;
    var i = 0;
    while (i < l){
      var arg = args[i];
      // must be a structure
      var type = Context.typeof(arg);

      // get fields
      var fields = switch (type) {
        case TAnonymous(a): a.get().fields;
        case _: throw 'argument $i: TAnonymous (structure) expected';
      }
      i++;

      // prepare fields
      var fields_of_arg = new Map<String, Expr>();
      for(field in fields){
        var name = field.name;
        fields_of_arg.set(name, macro $arg.$name);
      }

      var expr_arg_pos = i;
      if (i < l){
        // is next arg a string?
        var s = ExprExtensions.as_string(args[i]);
        if (s == null){
          // take all fields
        } else {
          if (s.charAt(0) == "-"){
            // drop fields
            for (name in s.substr(1).split(",")){
              if (fields_of_arg.exists(name)) fields_of_arg.remove(name)
              else 
                throw 'name $name not found in argument $i, can\' drop';
            }
          } else {
            // take some fields only
            var fs = new Map();
            for (name in s.split(",")){
              if (fields_of_arg.exists(name)) fs.set(name, fields_of_arg.get(name));
              else throw 'field $name not found in arg $i';
            }
            fields_of_arg = fs;
          }
          i++;
        }
      }

      for (name in fields_of_arg.keys()){
        if (final_fields.exists(name))
          Context.error('$name get\'s overridden', args[expr_arg_pos].pos);
        else
          final_fields.set(name, fields_of_arg.get(name));
      }
    }
    return { pos: args[0].pos, expr: EObjectDecl( final_fields.mapKVA(function(name,v){
        return { field: name, expr: final_fields.get(name) };
    }))};
  }

  /*
     var a = {a: 1, b:2, c:3};
     var b = a.sh_drop("b,c"); // same as b = {a: a.a}
  */
  macro static public function sh_drop(arg:Expr, s:String):Expr {
    return null;
  }
}
