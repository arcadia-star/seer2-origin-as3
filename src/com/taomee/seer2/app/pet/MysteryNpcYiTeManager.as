package com.taomee.seer2.app.pet {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.entity.events.MoveEvent;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.scene.SceneManager;

import flash.events.Event;
import flash.geom.Point;
import flash.utils.IDataInput;
import flash.utils.getTimer;

public class MysteryNpcYiTeManager {

    public static var mapIdList:Array = [];

    private static const npcId:int = 556;

    public static var isActivityON:int = 1;

    private static var date:Date;

    public static var currentYiTeMapId:int;

    private static var preTime:Number;

    private static const possibleMapID:Vector.<int> = new <int>[133, 132, 142, 124, 203, 202, 211, 212, 262, 291, 304, 480, 320, 620, 570];

    private static const posList:Array = [new Point(250, 425), new Point(450, 415), new Point(475, 400), new Point(415, 390), new Point(320, 300), new Point(450, 340), new Point(530, 400), new Point(530, 430), new Point(610, 360), new Point(330, 230), new Point(440, 340), new Point(460, 350), new Point(550, 330), new Point(550, 380), new Point(410, 375)];

    private static var hasGetAry:Array = [0, 0];


    public function MysteryNpcYiTeManager() {
        super();
    }

    public static function setup():void {
        ActorManager.getActor().addEventListener(MoveEvent.FINISHED, onUpdate);
        onUpdate();
    }

    private static function onGetMap(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.MYSTERY_YITE_MAP, onGetMap);
        var _loc2_:IDataInput = param1.message.getRawDataCopy();
        var _loc3_:uint = uint(_loc2_.readUnsignedInt());
        mapIdList = [];
        var _loc4_:int = 0;
        while (_loc4_ < _loc3_) {
            mapIdList.push(_loc2_.readUnsignedInt());
            _loc4_++;
        }
        checkStatus();
    }

    private static function onUpdate(param1:Event = null):void {
        if ((getTimer() - preTime) / 1000 < 10) {
            return;
        }
        preTime = getTimer();
        date = new Date(TimeManager.getServerTime() * 1000);
        if (date.hours == 13) {
            isActivityON = 1;
            if (hasGetAry[0] == 0) {
                Connection.addCommandListener(CommandSet.MYSTERY_YITE_MAP, onGetMap);
                Connection.send(CommandSet.MYSTERY_YITE_MAP);
                hasGetAry[0] = 1;
            }
        } else if (date.hours == 20) {
            isActivityON = 1;
            if (hasGetAry[1] == 0) {
                Connection.addCommandListener(CommandSet.MYSTERY_YITE_MAP, onGetMap);
                Connection.send(CommandSet.MYSTERY_YITE_MAP);
                hasGetAry[1] = 1;
            }
        } else {
            isActivityON = 0;
            mapIdList = [];
        }
        checkStatus();
    }

    private static function checkStatus():void {
        if (isActivityON == 0) {
            return;
        }
        getCurrentYiTeMapId();
        handleYiTe();
    }

    public static function getCurrentYiTeMapId():void {
        var _loc2_:int = 0;
        var _loc1_:Date = new Date(TimeManager.getServerTime() * 1000);
        _loc2_ = int(_loc1_.minutes / 15);
        currentYiTeMapId = mapIdList[_loc2_];
    }

    private static function handleYiTe():void {
        var _loc1_:Mobile = null;
        var _loc2_:MysteryYiTe = null;
        var _loc3_:int = 0;
        var _loc4_:Point = null;
        if (SceneManager.active) {
            if (currentYiTeMapId == SceneManager.active.mapID) {
                _loc1_ = MobileManager.getMobile(npcId, MobileType.NPC);
                if (!_loc1_) {
                    _loc2_ = new MysteryYiTe();
                    MobileManager.addMobile(_loc2_.npc, MobileType.NPC);
                    _loc3_ = possibleMapID.indexOf(currentYiTeMapId);
                    _loc4_ = posList[_loc3_];
                    _loc2_.npc.x = _loc4_.x;
                    _loc2_.npc.y = _loc4_.y;
                }
            } else {
                _loc1_ = MobileManager.getMobile(npcId, MobileType.NPC);
                if (_loc1_) {
                    MobileManager.removeMobile(_loc1_, MobileType.NPC);
                    _loc1_.dispose();
                }
            }
        }
    }
}
}
