package mw;
using StringTools;
using Reflect;

class StringExtensions {
  static public function escapeChars(s:String, chars:String){
    var r = "";
    for (i in 0...s.length){
      var c = s.charAt(i);
      if (chars.indexOf(c) >= 0)
        r += '\\$(c)';
      else r += c;
    }
    return r;
    // return new EReg("(["+chars.replace("]", "\\]")+"])", "").replace(s, "\\$1");
  }

  static public function split_empty_list(s:String, sep:String) {
    if (s == "") return [];
    return s.split(sep);
  }

  static public inline function split_start_end(s:String, sep:String) {
    return s.split(sep).slice(1, -1);
  }

  static public function makeSingular(s:String):String {
    return (s.charAt(s.length-1) == "s")
      ? s.substr(0, s.length -1)
      : s;
  }

  static public function makePlural(s:String):String {
    return (s.charAt(s.length-1) != "s")
      ? '${s}s'
      : s;
  }

  static public function replaceAnon(s:String, o:{}) {
    for (x in o.fields()){
      s = s.replace(x, o.field(x));
    }
    return s;
  }
}
