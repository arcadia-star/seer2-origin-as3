package com.taomee.seer2.app.config {
import org.taomee.ds.HashMap;

public class StarTaskConfig {

    private static var _xmlClass:Class = StarTaskConfig__xmlClass;

    private static var stepMap:HashMap = new HashMap();

    {
        initlize();
    }

    public function StarTaskConfig() {
        super();
    }

    private static function initlize():void {
        var _loc3_:XML = null;
        var _loc4_:StarTaskInfo = null;
        var _loc1_:XML = XML(new _xmlClass());
        var _loc2_:XMLList = _loc1_.descendants("step");
        for each(_loc3_ in _loc2_) {
            if (uint(_loc3_.@id) >= 9) {
                (_loc4_ = new StarTaskInfo()).module = String(_loc3_.@module);
                _loc4_.tip = String(_loc3_.@tip);
                stepMap.add(uint(_loc3_.@id), _loc4_);
            }
        }
    }

    public static function getStarTaskInfo(param1:uint):StarTaskInfo {
        if (stepMap.containsKey(param1)) {
            return stepMap.getValue(param1);
        }
        return null;
    }
}
}
