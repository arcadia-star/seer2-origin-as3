package com.taomee.seer2.app.config {
import com.taomee.seer2.app.config.info.EvolveInfo;

import org.taomee.ds.HashMap;

public class EvolveConfig {

    private static var _xmlClass:Class = EvolveConfig__xmlClass;

    private static var _evolveMap:HashMap = new HashMap();

    {
        initlize();
    }

    public function EvolveConfig() {
        super();
    }

    private static function initlize():void {
        var _loc3_:XML = null;
        var _loc4_:EvolveInfo = null;
        var _loc5_:XML = null;
        var _loc1_:XML = XML(new _xmlClass());
        var _loc2_:XMLList = _loc1_.descendants("Evolve");
        for each(_loc3_ in _loc2_) {
            (_loc4_ = new EvolveInfo()).monId = int(_loc3_.attribute("monId"));
            _loc4_.needLevel = int(_loc3_.attribute("needLv"));
            for each(_loc5_ in _loc3_.descendants("Branch")) {
                _loc4_.itemVec.push(int(_loc5_.attribute("EvolvItem")));
            }
            _evolveMap.add(_loc4_.monId, _loc4_);
        }
    }

    public static function canEvolve(param1:int, param2:int, param3:int):Boolean {
        var _loc4_:EvolveInfo = null;
        if (_evolveMap.containsKey(param1)) {
            _loc4_ = _evolveMap.getValue(param1);
            if (param2 >= _loc4_.needLevel && _loc4_.itemVec.indexOf(param3) != -1) {
                return true;
            }
        }
        return false;
    }

    public static function getMonEvolveError(param1:int, param2:int, param3:int):int {
        var _loc5_:EvolveInfo = null;
        var _loc4_:int = 0;
        if (_evolveMap.containsKey(param1)) {
            if ((_loc5_ = _evolveMap.getValue(param1)).itemVec.indexOf(param3) == -1) {
                _loc4_ = 1;
            } else if (param2 < _loc5_.needLevel) {
                _loc4_ = 2;
            }
        }
        return _loc4_;
    }

    public static function getEvolveLevel(param1:int):int {
        var _loc2_:int = 0;
        var _loc3_:EvolveInfo = null;
        if (_evolveMap.containsKey(param1)) {
            _loc3_ = _evolveMap.getValue(param1);
            _loc2_ = _loc3_.needLevel;
        }
        return _loc2_;
    }
}
}
