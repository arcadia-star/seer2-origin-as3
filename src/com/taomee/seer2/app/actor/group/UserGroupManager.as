package com.taomee.seer2.app.actor.group {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.actor.RemoteActor;
import com.taomee.seer2.app.actor.data.UserInfo;

import flash.events.EventDispatcher;
import flash.utils.IDataInput;

import org.taomee.ds.HashMap;

public class UserGroupManager {

    private static var _groupMap:HashMap;

    private static var _buddyGroup:UserGroup;

    private static var _blackGroup:UserGroup;

    private static var _teamGroup:UserGroup;

    private static var _eventDispatcher:EventDispatcher;

    {
        initialize();
    }

    public function UserGroupManager() {
        super();
    }

    private static function initialize():void {
        _buddyGroup = new UserGroup(UserGroupType.BUDDY);
        _blackGroup = new UserGroup(UserGroupType.BLACK);
        _teamGroup = new UserGroup(UserGroupType.TEAM);
        _groupMap = new HashMap();
        _groupMap.add(UserGroupType.BUDDY, _buddyGroup);
        _groupMap.add(UserGroupType.BLACK, _blackGroup);
        _groupMap.add(UserGroupType.TEAM, _teamGroup);
        _eventDispatcher = new EventDispatcher();
    }

    public static function setup(param1:IDataInput):void {
        var _loc2_:UserInfo = null;
        var _loc3_:uint = uint(param1.readUnsignedInt());
        var _loc4_:int = 0;
        while (_loc4_ < _loc3_) {
            _loc2_ = new UserInfo();
            _loc2_.id = param1.readUnsignedInt();
            addUser(UserGroupType.BUDDY, _loc2_);
            _loc4_++;
        }
        var _loc5_:uint = uint(param1.readUnsignedInt());
        var _loc6_:int = 0;
        while (_loc6_ < _loc5_) {
            _loc2_ = new UserInfo();
            _loc2_.id = param1.readUnsignedInt();
            addUser(UserGroupType.BLACK, _loc2_);
            _loc6_++;
        }
    }

    public static function addUser(param1:String, param2:UserInfo):void {
        var _loc3_:UserGroup = getUserGroup(param1);
        if (_loc3_) {
            _loc3_.addUser(param2);
            dispatchUserGroupEvent(UserGroupEvent.ADD, param1, param2);
        }
    }

    public static function removeUser(param1:String, param2:UserInfo):void {
        var _loc3_:UserGroup = getUserGroup(param1);
        if (_loc3_) {
            _loc3_.removeUser(param2);
            dispatchUserGroupEvent(UserGroupEvent.REMOVE, param1, param2);
        }
    }

    public static function removeAllUserByType(param1:String):void {
        var _loc2_:UserGroup = getUserGroup(param1);
        if (_loc2_) {
            _loc2_.clear();
        }
    }

    public static function updateUser(param1:String, param2:UserInfo):void {
        var _loc3_:UserGroup = getUserGroup(param1);
        if (_loc3_) {
            _loc3_.updateUser(param2);
            dispatchUserGroupEvent(UserGroupEvent.UPDATE, param1, param2);
        }
    }

    public static function updateUserNew(param1:UserInfo):void {
        if (containsUser(UserGroupType.TEAM, param1.id)) {
            updateUser(UserGroupType.TEAM, param1);
        }
        if (containsUser(UserGroupType.BUDDY, param1.id)) {
            updateUser(UserGroupType.BUDDY, param1);
        } else if (containsUser(UserGroupType.PASSERBY, param1.id)) {
            updateUser(UserGroupType.PASSERBY, param1);
        } else if (containsUser(UserGroupType.BLACK, param1.id)) {
            updateUser(UserGroupType.BLACK, param1);
        }
    }

    public static function getUser(param1:String, param2:uint):UserInfo {
        var _loc3_:UserGroup = getUserGroup(param1);
        if (_loc3_) {
            return _loc3_.getUser(param2);
        }
        return null;
    }

    public static function containsUser(param1:String, param2:uint):Boolean {
        var _loc3_:Boolean = false;
        var _loc4_:UserGroup;
        if (_loc4_ = getUserGroup(param1)) {
            _loc3_ = _loc4_.containsUser(param2);
        }
        return _loc3_;
    }

    public static function getAllPasserByUser():Vector.<UserInfo> {
        var _loc3_:RemoteActor = null;
        var _loc1_:Vector.<RemoteActor> = ActorManager.getAllRemoteActors();
        var _loc2_:Vector.<UserInfo> = new Vector.<UserInfo>();
        for each(_loc3_ in _loc1_) {
            _loc2_.push(_loc3_.getInfo());
        }
        return _loc2_;
    }

    public static function getGroupAllUser(param1:String):Vector.<UserInfo> {
        var _loc2_:UserGroup = getUserGroup(param1);
        if (_loc2_) {
            return _loc2_.getAllUser();
        }
        return new Vector.<UserInfo>();
    }

    private static function getUserGroup(param1:String):UserGroup {
        if (_groupMap.containsKey(param1)) {
            return _groupMap.getValue(param1);
        }
        return null;
    }

    public static function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false):void {
        _eventDispatcher.addEventListener(param1, param2, param3, param4, param5);
    }

    public static function removeEventListener(param1:String, param2:Function, param3:Boolean = false):void {
        _eventDispatcher.removeEventListener(param1, param2, param3);
    }

    private static function dispatchUserGroupEvent(param1:String, param2:String, param3:UserInfo = null):void {
        if (_eventDispatcher.hasEventListener(param1)) {
            _eventDispatcher.dispatchEvent(new UserGroupEvent(param1, param2, param3));
        }
    }
}
}
