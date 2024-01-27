package com.taomee.seer2.app.cmdl {
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.notify.NoticeManager;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.core.net.MessageEvent;

import flash.utils.ByteArray;

import org.taomee.bean.BaseBean;

public class SystemNotifyListener extends BaseBean {


    public function SystemNotifyListener() {
        super();
    }

    private static function onData(param1:MessageEvent):void {
        var _loc2_:ByteArray = param1.message.getRawData();
        var _loc3_:Object = new Object();
        _loc3_.receiveID = _loc2_.readUnsignedInt();
        _loc3_.npcType = _loc2_.readUnsignedInt();
        _loc3_.msgTime = _loc2_.readUnsignedInt();
        var _loc4_:int = int(_loc2_.readUnsignedInt());
        _loc3_.msg = _loc2_.readUTFBytes(_loc4_);
        if (_loc3_.receiveID == 0) {
            ServerMessager.addMessage(_loc3_.msg);
        } else {
            NoticeManager.addSysMsgNotice(_loc3_);
        }
    }

    override public function start():void {
        Connection.addCommandListener(CommandSet.NOTIFY_SYS_MSG_1073, onData);
        finish();
    }
}
}
