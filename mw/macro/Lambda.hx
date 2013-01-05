package mw.macro;
import haxe.macro.Expr;
import haxe.macro.Context;

class Lambda {

#if macro
  public static function helper<T,T2>(a:Expr, field:Expr, params:Array<Expr>, to_lambda:String):ExprOf<Array<T2>> {
    var field_name = switch(field.expr) {
      case EConst(c): 
        switch(c) {
          case CIdent(s): s;
          case _: "bad";
        }
      case _: "bad";
    };
    var pos = field.pos; // Context.currentPos();
    var fun : String -> Expr -> Expr = function(s, param){
      return switch(s) {
        case "_": param;
        case "1": macro function(_){ return $param; };
        case "2": macro function(_1, _2){ return $param; };
      }
    };
    var params_ = [];
    for (i in 0...(params.length))
      params_.push(fun(to_lambda.charAt(i), params[i]));
    var cpos = Context.currentPos();
    return { expr : ECall({ expr : EField(a, field_name), pos: pos}, params_), pos: cpos};
  }
#end

  // one arguments, second lambda
  @:macro public static function l1<T,T2>(a:Expr, b:Expr, f:Expr):ExprOf<Array<T2>> {
    return Lambda.helper(a, b, [f], "1");
  }


  @:macro public static function l2<T,T2>(a:Expr, b:Expr, f:Expr):ExprOf<Array<T2>> {
    return Lambda.helper(a, b, [f], "2");
  }

  // skip first argument represented by _, replace second by lambda expression
  @:macro public static function l_1<T,T2>(a:Expr, b:Expr, f:Expr):ExprOf<Array<T2>> {
    return Lambda.helper(a, b, [f], "_1");
  }

  @:macro public static function l_2<T,T2>(a:Expr, b:Expr, f:Expr):ExprOf<Array<T2>> {
    return Lambda.helper(a, b, [f], "_2");
  }

  @:macro public static function eval():Expr {
    return Context.parse('function(){ return "abc"; }', Context.currentPos());
  }

}
