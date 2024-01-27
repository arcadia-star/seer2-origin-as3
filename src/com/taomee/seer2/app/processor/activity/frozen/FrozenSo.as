package com.taomee.seer2.app.processor.activity.frozen {
import com.taomee.seer2.core.cookie.SharedObjectManager;

import flash.net.SharedObject;

public class FrozenSo {


    public function FrozenSo() {
        super();
    }

    public static function setRewardNum(param1:uint):void {
        var _loc2_:SharedObject = SharedObjectManager.getUserSharedObject(SharedObjectManager.ACTIVITY);
        var _loc3_:String = generateDateKey();
        var _loc4_:Array;
        if ((_loc4_ = _loc2_.data[_loc3_]) == null) {
            resetSharedObject(_loc2_, _loc3_);
            _loc4_ = _loc2_.data[_loc3_];
        }
        _loc4_.push(param1);
        _loc2_.flush();
    }

    public static function getRewardNum():Array {
        var _loc1_:SharedObject = SharedObjectManager.getUserSharedObject(SharedObjectManager.ACTIVITY);
        var _loc2_:String = generateDateKey();
        var _loc3_:Array = _loc1_.data[_loc2_];
        if (_loc3_ == null) {
            resetSharedObject(_loc1_, _loc2_);
            _loc3_ = _loc1_.data[_loc2_];
        }
        return _loc3_;
    }

    public static function clearSo():void {
        var _loc1_:SharedObject = SharedObjectManager.getUserSharedObject(SharedObjectManager.ACTIVITY);
        var _loc2_:String = generateDateKey();
        resetSharedObject(_loc1_, _loc2_);
    }

    private static function generateDateKey():String {
        var _loc1_:Date = new Date();
        return _loc1_.fullYear + "_" + (_loc1_.month + 1) + "_" + _loc1_.date;
    }

    private static function resetSharedObject(param1:SharedObject, param2:String):void {
        param1.clear();
        var _loc3_:Array = new Array();
        param1.data[param2] = _loc3_;
        param1.flush();
    }
}
}
