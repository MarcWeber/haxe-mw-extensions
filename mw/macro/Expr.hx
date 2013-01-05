package mw;
class Expr {
  @:macro static public function trace(e:Expr) {
    trace(e);
    return e;
  }
}
