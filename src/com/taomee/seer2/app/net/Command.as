package com.taomee.seer2.app.net {
import org.taomee.ds.HashMap;

public class Command {

    private static var _map:HashMap = new HashMap();


    public var id:uint;

    public var description:String;

    public function Command(param1:uint, param2:String) {
        super();
        this.id = param1;
        this.description = param2;
        _map.add(this.id, this);
    }

    public static function findDescriptionById(param1:uint):String {
        if (getCommand(param1) != null) {
            return getCommand(param1).toString();
        }
        return param1 + "！！该条命令定义不存在！！";
    }

    public static function getCommand(param1:uint):Command {
        if (_map.containsKey(param1)) {
            return _map.getValue(param1);
        }
        return null;
    }

    public function toString():String {
        return "[" + this.id + "-" + this.description + "]";
    }
}
}
