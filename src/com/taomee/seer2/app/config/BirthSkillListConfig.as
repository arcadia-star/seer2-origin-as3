package com.taomee.seer2.app.config {
import com.taomee.seer2.app.config.info.BirthSkillInfo;

import org.taomee.ds.HashMap;

public class BirthSkillListConfig {

    private static var _xmlClass:Class = BirthSkillListConfig__xmlClass;

    private static var _birthSkillList:HashMap = new HashMap();

    {
        initlize();
    }

    public function BirthSkillListConfig() {
        super();
    }

    private static function initlize():void {
        var _loc3_:BirthSkillInfo = null;
        var _loc4_:XML = null;
        var _loc5_:XMLList = null;
        var _loc6_:XML = null;
        var _loc1_:XML = XML(new _xmlClass());
        var _loc2_:XMLList = _loc1_.child("Monster");
        for each(_loc4_ in _loc2_) {
            _loc3_ = new BirthSkillInfo();
            _loc3_.id = uint(_loc4_.@ID);
            _loc5_ = _loc4_.descendants("Item");
            for each(_loc6_ in _loc5_) {
                _loc3_.skillList.push(uint(_loc6_.@skillid));
                if (_loc3_.id == 15) {
                    _loc3_.skillList[0] = 10068;
                }
            }
            _birthSkillList.add(_loc3_.id, _loc3_);
        }
    }

    public static function getInfo(param1:uint):BirthSkillInfo {
        if (_birthSkillList.containsKey(param1)) {
            return _birthSkillList.getValue(param1);
        }
        return null;
    }

    public static function getList():Vector.<BirthSkillInfo> {
        return Vector.<BirthSkillInfo>(_birthSkillList.getValues());
    }
}
}
