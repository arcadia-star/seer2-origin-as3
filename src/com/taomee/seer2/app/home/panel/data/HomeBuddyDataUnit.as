package com.taomee.seer2.app.home.panel.data {
import com.taomee.seer2.app.actor.data.UserInfo;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.net.helper.UserInfoParseHelper;
import com.taomee.seer2.core.net.MessageEvent;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.utils.ByteArray;

public class HomeBuddyDataUnit extends EventDispatcher {

    public static const UPDATE:String = "update";

    public static const EMPEY:String = "empty";

    public static const BUSY:String = "busy";

    public static const READY:String = "ready";


    public var id:uint;

    public var status:String;

    public var order:int;

    public var userInfo:UserInfo;

    public function HomeBuddyDataUnit() {
        super();
    }

    public function update():void {
        if (this.status == HomeBuddyDataUnit.BUSY) {
            Connection.addCommandListener(CommandSet.USER_GET_SIMPLE_INFO_1028, this.onGetUserSimpleInfo);
            Connection.send(CommandSet.USER_GET_SIMPLE_INFO_1028, this.id);
        }
    }

    private function onGetUserSimpleInfo(param1:MessageEvent):void {
        var _loc2_:ByteArray = param1.message.getRawData();
        _loc2_.position = 0;
        var _loc3_:uint = _loc2_.readUnsignedInt();
        if (_loc3_ == this.id) {
            Connection.removeCommandListener(CommandSet.USER_GET_SIMPLE_INFO_1028, this.onGetUserSimpleInfo);
            this.status = READY;
            _loc2_.position = 0;
            this.userInfo = new UserInfo();
            UserInfoParseHelper.parseUserSimpleInfo(this.userInfo, _loc2_);
            dispatchEvent(new Event(UPDATE));
        }
    }
}
}
