package com.taomee.seer2.app.actor.group {
import com.taomee.seer2.app.actor.data.UserInfo;

import flash.events.Event;

public class UserGroupEvent extends Event {

    public static const ADD:String = "add";

    public static const REMOVE:String = "remove";

    public static const UPDATE:String = "update";


    private var _userGroupType:String;

    private var _userInfo:UserInfo;

    public function UserGroupEvent(param1:String, param2:String, param3:UserInfo = null, param4:Boolean = false, param5:Boolean = false) {
        super(param1, param4, param5);
        this._userGroupType = param2;
        this._userInfo = param3;
    }

    public function get userGroupType():String {
        return this._userGroupType;
    }

    public function get userInfo():UserInfo {
        return this._userInfo;
    }

    override public function clone():Event {
        return new UserGroupEvent(type, this._userGroupType, this._userInfo, bubbles, cancelable);
    }
}
}
