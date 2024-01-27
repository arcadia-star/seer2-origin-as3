package com.taomee.seer2.app.processor.activity.deliciousFood {
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.serverBuffer.ServerBuffer;
import com.taomee.seer2.app.serverBuffer.ServerBufferData;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferType;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.utils.DateUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class DeliciousFoodOnePickup {

    private static const pickupMapList:Vector.<uint> = Vector.<uint>([100, 180, 291, 330, 390]);

    private static var _mc:MovieClip;

    private static var _currMapIndex:int;


    public function DeliciousFoodOnePickup() {
        super();
    }

    public static function setup():void {
        SceneManager.addEventListener(SceneEvent.SWITCH_START, onMapSwitchStart);
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, onMapSwitchComplete);
        DeliciousFoodTwo.setup();
    }

    private static function onMapSwitchComplete(param1:SceneEvent):void {
        if (pickupMapList.indexOf(SceneManager.active.mapID) != -1 && DeliciousFoodLoad.instance.checkTime) {
            _currMapIndex = pickupMapList.indexOf(SceneManager.active.mapID);
            ServerBufferManager.getServerBuffer(getServerBuf(), onGetServer, false);
        }
        if (isTimerLater()) {
            SceneManager.removeEventListener(SceneEvent.SWITCH_START, onMapSwitchStart);
            SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, onMapSwitchComplete);
        }
    }

    private static function onMapSwitchStart(param1:SceneEvent):void {
        DisplayUtil.removeForParent(_mc);
    }

    private static function isTimerLater():Boolean {
        if (DateUtil.isInHourScope(13, 14, 30, 30)) {
            return false;
        }
        return true;
    }

    private static function onGetServer(param1:ServerBuffer):void {
        var dataVec:Vector.<ServerBufferData> = null;
        var i:int = 0;
        var server:ServerBuffer = param1;
        var bufIndex:int = server.readDataAtPostion(0);
        var currIndex:int = server.readDataAtPostion(_currMapIndex + 1);
        var loginIndex:int = server.readDataAtPostion(40);
        var date:Date = new Date(TimeManager.getServerTime() * 1000);
        if (loginIndex != 1) {
            dataVec = new Vector.<ServerBufferData>();
            i = 0;
            while (i < 38) {
                dataVec.push(new ServerBufferData(i, 0));
                i++;
            }
            dataVec.push(new ServerBufferData(40, 1));
            ServerBufferManager.updateServerBufferGroup(getServerBuf(), dataVec);
            ServerBufferManager.getServerBuffer(getServerBuf(), onGetServer, false);
            return;
        }
        if (bufIndex == 1 && currIndex != 1) {
            DeliciousFoodLoad.instance.playLoad(function ():void {
                _mc = DeliciousFoodLoad.instance.getMC("pickup" + _currMapIndex);
                LayerManager.topLayer.addChild(_mc);
                _mc.buttonMode = true;
                _mc.addEventListener(MouseEvent.CLICK, onClick);
            });
        }
    }

    private static function onClick(param1:MouseEvent):void {
        DisplayUtil.removeForParent(_mc);
        ServerBufferManager.updateServerBuffer(getServerBuf(), _currMapIndex + 1, 1);
        ServerBufferManager.getServerBuffer(getServerBuf(), onGetServerList, false);
    }

    private static function onGetServerList(param1:ServerBuffer):void {
        var _loc2_:Boolean = true;
        var _loc3_:int = 0;
        while (_loc3_ < 6) {
            if (param1.readDataAtPostion(_loc3_) != 1) {
                _loc2_ = false;
            }
            _loc3_++;
        }
        if (_loc2_) {
            SceneManager.removeEventListener(SceneEvent.SWITCH_START, onMapSwitchStart);
            SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, onMapSwitchComplete);
            ServerMessager.addMessage("你已经找齐5份美食啦，快回去草系主城找美食神猪吧！");
            SceneManager.changeScene(SceneType.LOBBY, 90);
        } else {
            ServerMessager.addMessage("获得美食");
            ModuleManager.toggleModule(URLUtil.getAppModule("DeliciousFoodPanel"), "美食神猪");
        }
    }

    public static function getServerBuf():uint {
        var _loc1_:Date = new Date(TimeManager.getServerTime() * 1000);
        switch (_loc1_.date) {
            case 8:
                return ServerBufferType.DELICIOUS_FOOD8;
            case 9:
                return ServerBufferType.DELICIOUS_FOOD9;
            case 10:
                return ServerBufferType.DELICIOUS_FOOD10;
            default:
                return 0;
        }
    }
}
}
