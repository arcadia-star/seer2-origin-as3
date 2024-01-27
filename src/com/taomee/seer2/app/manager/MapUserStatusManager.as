package com.taomee.seer2.app.manager {
import com.taomee.seer2.app.actor.data.UserInfo;
import com.taomee.seer2.app.gameRule.data.MapUser;
import com.taomee.seer2.app.gameRule.data.MapUserStatusEvent;
import com.taomee.seer2.app.gameRule.util.MapUserStatusType;

import flash.events.Event;
import flash.events.EventDispatcher;

public class MapUserStatusManager {

    private static var _mapUsers:Vector.<MapUser> = new Vector.<MapUser>();

    private static var _dispatcher:EventDispatcher = new EventDispatcher();


    public function MapUserStatusManager() {
        super();
    }

    public static function chcekUserIsInFight(param1:uint):Boolean {
        return MapUserStatusManager.getMapUserStatus(param1) == MapUserStatusType.FIGHT;
    }

    public static function getMapUserStatus(param1:uint):int {
        var _loc2_:MapUser = getMapUser(param1);
        if (_loc2_ != null) {
            return _loc2_.status;
        }
        return MapUserStatusType.NORMAL;
    }

    public static function getAllUsersInType(param1:uint = 0):Vector.<UserInfo> {
        var _loc3_:MapUser = null;
        var _loc2_:Vector.<UserInfo> = new Vector.<UserInfo>();
        for each(_loc3_ in _mapUsers) {
            if (_loc3_.status == param1) {
                _loc2_.push(_loc3_.userInfo);
            }
        }
        return _loc2_;
    }

    public static function updateMapUser(param1:uint, param2:uint = 0):void {
        var _loc3_:MapUser = getMapUser(param1);
        if (_loc3_ != null) {
            _loc3_.status = param2;
            dispatchEvent(new MapUserStatusEvent(_loc3_, MapUserStatusEvent.UPDATE));
        }
    }

    public static function addMapUser(param1:UserInfo):void {
        var _loc2_:MapUser = getMapUser(param1.id);
        if (_loc2_ == null) {
            _mapUsers.push(new MapUser(param1));
        } else {
            _loc2_.status = MapUserStatusType.NORMAL;
            dispatchEvent(new MapUserStatusEvent(_loc2_, MapUserStatusEvent.UPDATE));
        }
    }

    public static function removeMapUser(param1:uint):void {
        var _loc3_:uint = 0;
        var _loc2_:MapUser = getMapUser(param1);
        if (_loc2_ != null) {
            _loc3_ = _mapUsers.indexOf(_loc2_);
            _mapUsers.splice(_loc3_, 1);
        }
    }

    public static function clearMapUsers():void {
        _mapUsers.splice(0, _mapUsers.length);
    }

    private static function getMapUser(param1:uint):MapUser {
        var _loc2_:MapUser = null;
        var _loc3_:uint = _mapUsers.length;
        var _loc4_:uint = 0;
        while (_loc4_ < _loc3_) {
            if (_mapUsers[_loc4_].userInfo.id == param1) {
                _loc2_ = _mapUsers[_loc4_];
                break;
            }
            _loc4_++;
        }
        return _loc2_;
    }

    public static function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false):void {
        _dispatcher.addEventListener(param1, param2, param3, param4, param5);
    }

    public static function removeEventListener(param1:String, param2:Function, param3:Boolean = false):void {
        _dispatcher.removeEventListener(param1, param2, param3);
    }

    public static function dispatchEvent(param1:Event):void {
        if (_dispatcher.hasEventListener(param1.type)) {
            _dispatcher.dispatchEvent(param1);
        }
    }

    public static function hasEventListener(param1:String):Boolean {
        return _dispatcher.hasEventListener(param1);
    }
}
}
