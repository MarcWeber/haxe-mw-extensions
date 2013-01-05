package mw;
using StringTools;

class StringExtensions {
  static public function escapeChars(s:String, chars:String){
    return new EReg("(["+chars.replace("]", "\\]")+"])", "").replace(s, "\\$1");
  }
}
