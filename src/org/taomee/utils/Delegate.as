package org.taomee.utils {
public class Delegate {


    public function Delegate() {
        super();
    }

    public static function create(param1:Function, ...rest):Function {
        var func:Function = param1;
        var args:Array = rest;
        var f:Function = function ():* {
            var _loc2_:Function = arguments.callee.func;
            var _loc3_:Array = arguments.concat(args);
            return _loc2_.apply(null, _loc3_);
        };
        f["func"] = func;
        return f;
    }
}
}
