package com.taomee.seer2.app.lobby.messageHandler {
import com.taomee.seer2.app.activity.ActivityManager;
import com.taomee.seer2.app.announcement.AnnouncementTime;
import com.taomee.seer2.app.announcement.horn.HornControl;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.rightToolbar.RightToolbarConter;
import com.taomee.seer2.app.rightToolbar.RightToolbarTimeCheck;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.net.message.IMessageHandler;
import com.taomee.seer2.core.utils.DateUtil;

public class MessageHandlerSyncServerTime implements IMessageHandler {


    public function MessageHandlerSyncServerTime() {
        super();
    }

    public function setup():void {
        Connection.addCommandListener(CommandSet.SYNC_SERVER_TIME_1100, this.onMessage);
    }

    public function onMessage(param1:MessageEvent):void {
        TimeManager.updateServerTime(param1.message.getRawData().readUnsignedInt());
        ActivityManager.refreshActivity();
        this.announcement();
        this.horn();
        this.rightRefreshTime();
    }

    private function rightRefreshTime():void {
        RightToolbarConter.instance.refreshTime();
        RightToolbarTimeCheck.updateRightToolbar();
    }

    private function horn():void {
        HornControl.checkTime();
    }

    private function announcement():void {
        var _loc1_:uint = uint(TimeManager.getServerTime());
        var _loc2_:String = String(DateUtil.formatCalendarWithWeekHourMinuteSecond(_loc1_));
        AnnouncementTime.checkTime(_loc2_);
    }

    public function dispose():void {
        Connection.removeCommandListener(CommandSet.SYNC_SERVER_TIME_1100, this.onMessage);
    }
}
}
