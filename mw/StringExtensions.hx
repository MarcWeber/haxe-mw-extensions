package mw;
using StringTools;

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
}
