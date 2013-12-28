package mw.php;

typedef CatchAllError = {
  msg:Dynamic
  #if php
    , ?trace:Array<{file: String, line:Int, ?args:String}>
  #end
  };

class CatchAll {
  #if php

  static public function php_error_handler(error_type, error_msg, error_file, error_line, error_context) {
    // make everything unexpected be an error and cause a trace by throwing an 
    // exception which is catched by either the exception implementation or by the 
    // shutdown handler finally
    if (error_msg == 'Call-time pass-by-reference has been deprecated') 
      return;
    throw (error_type+' '+error_msg);
  }


  static public function catchAllErrorToString(c:CatchAllError):String {
#if php
	var lines = [];
	lines.push(c.msg);
	for (l in c.trace)
	  lines.push('${l.file}:${l.line}');
	return lines.join("\n");
#else
#end
  }


  static public var php_handle_error: CatchAllError -> Void;

  static public function shutdown_function() {
    var error: Dynamic = untyped __php__("error_get_last()");
    if (error != null){
      error = php.Lib.objectOfAssociativeArray(error);
      php_handle_error({
        msg: error.message,
        trace: [{
          file: error.file,
          line: error.line,
          args: "type: error.type",
        }]
      });
    }
  }
  #end


  static public function use(handle_error: CatchAllError -> Void, action:Void -> Void){

    #if php

      // using native try catch to get the stack trace which is important
      untyped __php__("try {");

      CatchAll.php_handle_error = handle_error;

      /* what is the problem with PHP?
        there are many warnings which you may want to care about.
        However on most server systems they are hidden (for good reason)

        You want to know about *all* of those notices, because they may be
        important. Unlike ruby, python its not possible to catch all trouble.
        But setting a custom shutdown handler & setting the error handler makes it
        very likely that you get to know about most issues (hopefully before the
        customer does notice it)

        If you have low traffic sites you can send errors by mail.
        For high traffic sites you should try to do something else
      */
#if PHP_SET_ERROR_HANDLER
      untyped __call__("set_error_handler", CatchAll.php_error_handler);
#end

      untyped __call__("register_shutdown_function", CatchAll.shutdown_function);

      action();
      untyped __php__("
        } catch (Exception $exception) {
        }
      ");
      var e:php.Exception = untyped __php__("isset($exception) ? $exception : null");
      if (e != null){
        // tell dead code elimination that this is used!
        var b = false; if (b) php.Lib.objectOfAssociativeArray(null);
        handle_error({
          msg: e.getMessage(),
          trace:
          [{
            file: e.getFile(),
            line: e.getLine(),
            args: null
          }].concat(
          untyped php.Lib.toHaxeArray(
                untyped __call__("array_merge",
                  untyped __call__("array_map", 'php_Lib::objectOfAssociativeArray', e.getTrace())
                )
            )
          )});
      }

    #else

      try{
        action();
      }catch(e:Dynamic){ 
        handle_error(e);
      }

    #end
  }

}
