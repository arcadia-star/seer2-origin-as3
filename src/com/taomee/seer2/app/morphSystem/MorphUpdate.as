package com.taomee.seer2.app.morphSystem {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.actor.data.UserInfo;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.net.helper.UserInfoParseHelper;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.net.MessageEvent;

import flash.events.TimerEvent;
import flash.utils.ByteArray;
import flash.utils.IDataInput;
import flash.utils.Timer;

public class MorphUpdate {

    private static var _timer:Timer = new Timer(1000);

    private static var _cookback:Function;


    public function MorphUpdate() {
        super();
    }

    public static function updateMorph(param1:Function = null):void {
        _cookback = param1;
        Connection.addCommandListener(CommandSet.USER_GET_DETAIL_INFO_1010, onGetDetailInfo);
        Connection.send(CommandSet.USER_GET_DETAIL_INFO_1010, ActorManager.actorInfo.id);
    }

    private static function onGetDetailInfo(param1:MessageEvent):void {
        var _loc2_:IDataInput = param1.message.getRawData();
        var _loc3_:uint = uint(_loc2_.readUnsignedInt());
        Connection.removeCommandListener(CommandSet.USER_GET_DETAIL_INFO_1010, onGetDetailInfo);
        ByteArray(_loc2_).position = 0;
        UserInfoParseHelper.parseUserDetailInfo(new UserInfo(), _loc2_);
        ActorManager.actorInfo.morphInfo.morphId = MorphSwitch.morphSwitch(_loc2_.readUnsignedInt());
        ActorManager.actorInfo.morphInfo.morphEndTime = _loc2_.readUnsignedInt();
        if (_cookback != null) {
            _cookback();
            _cookback = null;
        }
        if (ActorManager.actorInfo.morphInfo.morphId != 0) {
            MorphManager.startThisMorph(ActorManager.actorInfo.morphInfo.morphId);
        }
        if (TimeManager.getServerTime() < ActorManager.actorInfo.morphInfo.morphEndTime) {
            startTime();
        }
    }

    public static function startTime():void {
        if (_timer.hasEventListener(TimerEvent.TIMER) == false) {
            _timer.addEventListener(TimerEvent.TIMER, onTimer);
            _timer.start();
        }
    }

    public static function removeTime():void {
        _timer.stop();
        _timer.removeEventListener(TimerEvent.TIMER, onTimer);
    }

    private static function onTimer(param1:TimerEvent):void {
        if (TimeManager.getServerTime() >= ActorManager.actorInfo.morphInfo.morphEndTime) {
            MorphManager.removeMorph(ActorManager.getActor());
        }
    }
}
}
