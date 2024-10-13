package com.taomee.seer2.app.arena.util {
import com.taomee.seer2.app.arena.data.AnimiationHitInfo;
import com.taomee.seer2.app.config.PetConfig;

import org.taomee.ds.HashMap;

import seer2.next.entry.DynConfig;

public class HitInfoConfig {

    private static var _hitData:Class = HitInfoConfig__hitData;

    private static var _hitDatas:HashMap;


    public function HitInfoConfig() {
        super();
    }

    public static function getHitData(param1:uint):AnimiationHitInfo {
        param1 = PetConfig.getPetDefinition(param1).realId;
        if (_hitDatas == null) {
            _hitDatas = new HashMap();
            setup();
        }
        var _loc2_:AnimiationHitInfo = _hitDatas.getValue(param1);
        if (_loc2_ == null) {
            throw new Error("精灵" + param1 + "没有配置fighters.xml表!");
        }
        return _loc2_;
    }

    public static function initialize():void {
        _hitDatas = new HashMap();
        setup();
    }

    private static function setup():void {
        var _loc5_:XML = null;
        var _loc6_:AnimiationHitInfo = null;
        var _loc1_:XML = DynConfig.hitInfoConfigXML || XML(new _hitData());
        var _loc2_:XMLList = _loc1_.child("fighter");
        var _loc3_:uint = uint(_loc2_.length());
        var _loc4_:uint = 0;
        while (_loc4_ < _loc3_) {
            _loc5_ = _loc2_[_loc4_];
            (_loc6_ = new AnimiationHitInfo()).id = _loc5_.@id;
            _loc6_.attribute = _loc5_.@attribute;
            _loc6_.critical = _loc5_.@critical;
            _loc6_.fit = _loc5_.@fit;
            _loc6_.physics = _loc5_.@physics;
            _loc6_.special = _loc5_.@special;
            _hitDatas.add(_loc6_.id, _loc6_);
            _loc4_++;
        }
    }
}
}
