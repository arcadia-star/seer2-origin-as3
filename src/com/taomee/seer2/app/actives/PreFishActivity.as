package com.taomee.seer2.app.actives {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.common.MovieClipExtractor;
import com.taomee.seer2.app.common.MovieClipPlayer;
import com.taomee.seer2.app.common.ResourceLibraryLoader;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.ResourceLibrary;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.utils.DateUtil;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;

public class PreFishActivity {

    public static const INIT:String = "init";

    public static const PROCESS:String = "process";

    public static const DISPOSE:String = "dispose";

    private static const HOUR_MIN:int = 18;

    private static const HOUR_MAX:int = 20;

    private static const CAIDAN_ID_VEC:Vector.<int> = new <int>[200505, 200502];

    private static const REQUIRE_QUEST_ID:int = 10014;

    private static var _resourceLoader:ResourceLibraryLoader;

    {
        staticInit();
    }

    private var _mapModel:MapModel;

    private var _resLib:ResourceLibrary;

    private var _petMc:MovieClip;

    private var _iconMc:MovieClip;

    private var _mcPlayer:MovieClipPlayer;

    private var _mcExtractor:MovieClipExtractor;

    private var _caidanId:int;

    private var _feedCount:int;

    private var _status:String;

    public function PreFishActivity() {
        super();
    }

    private static function staticInit():void {
        _resourceLoader = new ResourceLibraryLoader(URLUtil.getRes("active/resource/activity_pre_fish" + URLUtil.POSTFIX_SWF));
    }

    public function init(param1:MapModel):void {
        this._mapModel = param1;
        this._status = INIT;
        _resourceLoader.getLib(this.onGetLib);
    }

    private function onGetLib(param1:ResourceLibrary):void {
        this._resLib = param1;
        if (QuestManager.isComplete(REQUIRE_QUEST_ID)) {
            this.startActivity();
        } else {
            QuestManager.addEventListener(QuestEvent.COMPLETE, this.onQuestComplete);
        }
    }

    private function onQuestComplete(param1:QuestEvent):void {
        if (param1.questId == REQUIRE_QUEST_ID) {
            QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onQuestComplete);
            this.startActivity();
        }
    }

    private function startActivity():void {
        TimeManager.addEventListener(TimeManager.TIME_UPDATE, this.onTimeUpdate);
        this.onTimeUpdate(null);
    }

    private function onTimeUpdate(param1:Event):void {
        switch (this._status) {
            case INIT:
                if (this.isInActivityHour()) {
                    this.processActivity();
                    this._status = PROCESS;
                }
                break;
            case PROCESS:
                if (!this.isInActivityHour()) {
                    this.dispose();
                    this._status = DISPOSE;
                }
        }
    }

    private function processActivity():void {
        this.extractAssets();
        ActivityHelper.queryFish(0, 0, this.onQueryFish);
    }

    private function extractAssets():void {
        this._iconMc = this._resLib.getMovieClip("Icon");
        this._iconMc.gotoAndStop(1);
        this._iconMc.x = 734;
        this._iconMc.y = 317;
        this._petMc = this._resLib.getMovieClip("Pet");
        this._petMc.gotoAndStop(1);
        this._petMc.x = 788;
        this._petMc.y = 417;
        this._mcPlayer = new MovieClipPlayer();
        this._mcExtractor = new MovieClipExtractor();
    }

    private function onQueryFish(param1:int, param2:int):void {
        this._caidanId = param1;
        this._feedCount = param2;
        if (this._feedCount == 2) {
            this.showPetFight();
        } else {
            this.showPetStart();
        }
    }

    private function showPetStart():void {
        this._mapModel.front.addChild(this._petMc);
        this._mcExtractor.extract(this._petMc, this._feedCount + 1, [0], function (param1:Vector.<DisplayObject>):void {
            var vec:Vector.<DisplayObject> = param1;
            var mc:MovieClip = vec[0] as MovieClip;
            _mcPlayer.playMc(mc, 1, "frame1", false, function ():void {
                showPetIcon();
            });
        });
    }

    private function showPetIcon():void {
        var index:int;
        this._mapModel.front.addChild(this._iconMc);
        index = CAIDAN_ID_VEC.indexOf(this._caidanId);
        this._mcExtractor.extract(this._iconMc, index + 1, [0], function (param1:Vector.<DisplayObject>):void {
            var vec:Vector.<DisplayObject> = param1;
            var mc:MovieClip = vec[0] as MovieClip;
            _mcPlayer.playMc(mc, 1, mc.totalFrames, false, function ():void {
                _iconMc.buttonMode = true;
                _iconMc.addEventListener(MouseEvent.CLICK, onIconClick);
            });
        });
    }

    private function onIconClick(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        NpcDialog.show(442, "冰湖豚", [[0, "%*%*￥*￥饿…………&*%……（*#吃…………"]], ["（需要做出相应的料理，放入锅中）"], [function ():void {
            ItemManager.requestItemList(onRequestItemList);
        }]);
    }

    private function onRequestItemList():void {
        if (ItemManager.containsReferenceId(this._caidanId)) {
            DisplayObjectUtil.removeFromParent(this._iconMc);
            this.showPetEnd();
        } else {
            AlertManager.showAlert("啧啧啧！你做的料理不是它想吃的！注意看冒泡提示！");
        }
    }

    private function showPetEnd():void {
        this._mcExtractor.extract(this._petMc, this._feedCount + 1, [0], function (param1:Vector.<DisplayObject>):void {
            var vec:Vector.<DisplayObject> = param1;
            var mc:MovieClip = vec[0] as MovieClip;
            _mcPlayer.playMc(mc, "frame1", "frame2", false, function ():void {
                ActivityHelper.queryFish(1, _caidanId, onQueryFish);
            });
        });
    }

    private function showPetFight():void {
        this._mapModel.front.addChild(this._petMc);
        this._mcExtractor.extract(this._petMc, this._petMc.totalFrames, [0], function (param1:Vector.<DisplayObject>):void {
            var vec:Vector.<DisplayObject> = param1;
            var mc:MovieClip = vec[0] as MovieClip;
            _mcPlayer.playMc(mc, "frame2", mc.totalFrames, false, function ():void {
                _petMc.buttonMode = true;
                _petMc.addEventListener(MouseEvent.CLICK, onPetClick);
            });
        });
    }

    private function onPetClick(param1:MouseEvent):void {
        this._petMc.removeEventListener(MouseEvent.CLICK, this.onPetClick);
        FightManager.startFightWithWild(33);
    }

    public function dispose():void {
        if (this._status == DISPOSE) {
            return;
        }
        _resourceLoader.cancel();
        if (this._iconMc) {
            DisplayObjectUtil.removeFromParent(this._iconMc);
            this._iconMc.removeEventListener(MouseEvent.CLICK, this.onIconClick);
        }
        if (this._petMc) {
            DisplayObjectUtil.removeFromParent(this._petMc);
            this._petMc.removeEventListener(MouseEvent.CLICK, this.onPetClick);
        }
        if (this._mcPlayer) {
            this._mcPlayer.cancel();
        }
        if (this._mcExtractor) {
            this._mcExtractor.cancel();
        }
        ActivityHelper.cancel();
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onQuestComplete);
        TimeManager.removeEventListener(TimeManager.TIME_UPDATE, this.onTimeUpdate);
        this._mapModel = null;
    }

    private function isInActivityHour():Boolean {
        var _loc1_:Date = new Date(TimeManager.getServerTime() * DateUtil.MILLISECONDS_PER_SECOND);
        return _loc1_.hours >= HOUR_MIN && _loc1_.hours < HOUR_MAX;
    }
}
}

import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.core.net.LittleEndianByteArray;
import com.taomee.seer2.core.net.MessageEvent;

import flash.utils.IDataInput;

class ActivityHelper {

    private static var _callBack:Function;

    private static var _type:int;

    private static var _itemId:int;


    public function ActivityHelper() {
        super();
    }

    public static function queryFish(param1:int, param2:int, param3:Function):void {
        _callBack = param3;
        _type = param1;
        _itemId = param2;
        Connection.addErrorHandler(CommandSet.ACTIVITY_PRE_FISH_1139, onFail);
        Connection.addCommandListener(CommandSet.ACTIVITY_PRE_FISH_1139, onSuccess);
        var _loc4_:LittleEndianByteArray;
        (_loc4_ = new LittleEndianByteArray()).writeByte(_type);
        _loc4_.writeUnsignedInt(_itemId);
        Connection.send(CommandSet.ACTIVITY_PRE_FISH_1139, _loc4_);
    }

    public static function cancel():void {
        _callBack = null;
    }

    private static function onFail(param1:MessageEvent):void {
        clearListener();
        switch (param1.message.statusCode) {
            case 117:
                AlertManager.showAlert("用户参加活动时间不正确");
                break;
            case 160:
                AlertManager.showAlert("传来的鱼与服务器随机出来的鱼不一致");
        }
    }

    private static function onSuccess(param1:MessageEvent):void {
        clearListener();
        if (_type != 0) {
            ItemManager.reduceItemQuantity(_itemId, 1);
        }
        var _loc2_:IDataInput = param1.message.getRawData();
        var _loc3_:int = int(_loc2_.readUnsignedInt());
        var _loc4_:int = int(_loc2_.readUnsignedInt());
        _callBack(_loc3_, _loc4_);
    }

    private static function clearListener():void {
        Connection.removeErrorHandler(CommandSet.ACTIVITY_PRE_FISH_1139, onFail);
        Connection.removeCommandListener(CommandSet.ACTIVITY_PRE_FISH_1139, onSuccess);
    }
}
