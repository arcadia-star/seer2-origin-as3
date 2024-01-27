package com.taomee.seer2.core.net.message {
import com.taomee.seer2.core.net.LittleEndianByteArray;

import org.taomee.ds.HashMap;

public class ResponseParser {

    private static var _ruleMap:HashMap = new HashMap();


    public function ResponseParser() {
        super();
    }

    public static function addRule(param1:uint, param2:Class):void {
        if (_ruleMap.containsKey(param1) == false) {
            _ruleMap.add(param1, param2);
        }
    }

    public static function removeRule(param1:uint):void {
        if (_ruleMap.containsKey(param1) == true) {
            _ruleMap.remove(param1);
        }
    }

    public static function parser(param1:uint, param2:LittleEndianByteArray):Object {
        var _loc3_:Class = null;
        if (_ruleMap.containsKey(param1)) {
            _loc3_ = _ruleMap.getValue(param1) as Class;
            return new _loc3_(param2);
        }
        return null;
    }
}
}

class Blocker {


    public function Blocker() {
        super();
    }
}
