package com.taomee.seer2.app.config {
import com.taomee.seer2.app.config.info.AnimationBaseInfo;
import com.taomee.seer2.app.config.info.AnimationInfo;

import org.taomee.ds.HashMap;

public class AnimationDialog {

    private static var _xmlClass:Class = AnimationDialog__xmlClass;

    private static var _list:HashMap = new HashMap();

    {
        initlize();
    }

    public function AnimationDialog() {
        super();
    }

    private static function initlize():void {
        var _loc3_:AnimationInfo = null;
        var _loc4_:XML = null;
        var _loc5_:XMLList = null;
        var _loc6_:AnimationBaseInfo = null;
        var _loc7_:XML = null;
        var _loc1_:XML = XML(new _xmlClass());
        var _loc2_:XMLList = _loc1_.child("dialog");
        for each(_loc4_ in _loc2_) {
            _loc3_ = new AnimationInfo();
            _loc3_.id = uint(_loc4_.@id);
            _loc3_.list = Vector.<AnimationBaseInfo>([]);
            _loc5_ = _loc4_.descendants("item");
            for each(_loc7_ in _loc5_) {
                (_loc6_ = new AnimationBaseInfo()).content = String(_loc7_.@content);
                _loc6_.select1 = String(_loc7_.@select1);
                _loc6_.select2 = String(_loc7_.@select2);
                _loc6_.yesIndex = int(_loc7_.@yesIndex);
                _loc3_.list.push(_loc6_);
            }
            _list.add(_loc3_.id, _loc3_);
        }
    }

    public static function getInfo(param1:uint):AnimationInfo {
        if (_list.containsKey(param1)) {
            return _list.getValue(param1);
        }
        return null;
    }

    public static function getList():Vector.<AnimationInfo> {
        return Vector.<AnimationInfo>(_list.getValues());
    }
}
}
