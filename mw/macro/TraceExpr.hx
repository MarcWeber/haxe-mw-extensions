package macro;
class TraceExpr {
  @:macro static public function name(e:Expr) {
    trace(e);
    return e;
  }
}
