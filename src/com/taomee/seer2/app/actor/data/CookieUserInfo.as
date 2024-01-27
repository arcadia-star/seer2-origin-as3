package com.taomee.seer2.app.actor.data {
import com.taomee.seer2.app.inventory.item.EquipItem;
import com.taomee.seer2.core.cookie.SharedObjectManager;

import flash.net.SharedObject;

public class CookieUserInfo {

    private static const USERACCOUT:String = "userAccount";


    public var loginAccount:String;

    public var id:uint;

    public var nick:String;

    public var color:uint;

    public var equipReferenceIdArr:Array;

    public function CookieUserInfo(param1:String, param2:uint, param3:String, param4:uint, param5:Array) {
        super();
        this.loginAccount = param1;
        this.id = param2;
        this.nick = param3;
        this.color = param4;
        this.equipReferenceIdArr = param5;
    }

    public static function deserialize(param1:uint):CookieUserInfo {
        var _loc2_:Object = getCookieObj(param1, getCookieInfoVec());
        if (_loc2_ != null) {
            return new CookieUserInfo(_loc2_.loginAccount, _loc2_.account, _loc2_.nick, _loc2_.color, _loc2_.equipReferenceIdArr);
        }
        return null;
    }

    public static function serialize(param1:UserInfo):void {
        var _loc3_:EquipItem = null;
        var _loc4_:SharedObject = null;
        var _loc5_:Array = null;
        var _loc6_:Object = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1.equipVec) {
            _loc2_.push(_loc3_.referenceId);
        }
        _loc4_ = SharedObjectManager.getCommonSharedObject(SharedObjectManager.CLIENT_LOGIN);
        _loc5_ = getCookieInfoVec();
        if ((_loc6_ = getCookieObj(param1.id, _loc5_)) == null) {
            return;
        }
        _loc6_.account = param1.id;
        _loc6_.nick = param1.nick;
        _loc6_.color = param1.color;
        _loc6_.equipReferenceIdArr = _loc2_;
        _loc4_.data[USERACCOUT] = _loc5_;
        SharedObjectManager.flush(_loc4_);
    }

    private static function getCookieInfoVec():Array {
        var _loc1_:SharedObject = SharedObjectManager.getCommonSharedObject(SharedObjectManager.CLIENT_LOGIN);
        return _loc1_.data[USERACCOUT];
    }

    private static function getCookieObj(param1:uint, param2:Array):Object {
        var _loc3_:* = undefined;
        for each(_loc3_ in param2) {
            if (_loc3_.uid == param1) {
                return _loc3_;
            }
        }
        return null;
    }
}
}
