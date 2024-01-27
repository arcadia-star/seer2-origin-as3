package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.record.FightRecordData;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.constant.FunctionalityType;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.dialog.functionality.CustomUnit;
import com.taomee.seer2.app.info.DayLimitListInfo;
import com.taomee.seer2.app.manager.DayLimitListManager;
import com.taomee.seer2.app.manager.SeatTipsManager;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.net.parser.Parser_1140;
import com.taomee.seer2.app.npc.NpcEvent;
import com.taomee.seer2.app.npc.NpcManager;
import com.taomee.seer2.app.peakbattle.PeakBattleModel;
import com.taomee.seer2.app.serverBuffer.ServerBuffer;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferType;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.module.ModuleEvent;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.geom.Point;

public class MapProcessor_1300 extends MapProcessor {


    private var rank:MovieClip;

    private var hasAdId:int = 829;

    private var FIGHT_COUNT:int = 645;

    private var fightCount:uint;

    private var MEET_FIGHT:uint = 819;

    private var RANDOM_ID:uint = 80;

    private var showAd:uint;

    public function MapProcessor_1300(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        super.init();
        PeakBattleModel.getInstance().requestMyScore();
        var _loc1_:MovieClip = _map.content["eft"] as MovieClip;
        _loc1_.mouseEnabled = _loc1_.mouseChildren = false;
        var _loc2_:int = Math.random() * 10;
        this.rank = _map.content["rank"];
        if (_loc2_ < 4) {
            this.rank.gotoAndStop(1);
        } else if (_loc2_ < 7) {
            this.rank.gotoAndStop(2);
        } else {
            this.rank.gotoAndStop(3);
        }
        this.rank.buttonMode = true;
        DayLimitListManager.getDaylimitList([this.hasAdId, this.FIGHT_COUNT], this.getFightCount);
    }

    private function getFightCount(param1:DayLimitListInfo):void {
        this.fightCount = param1.getCount(this.FIGHT_COUNT);
        this.showAd = param1.getCount(this.hasAdId);
        var _loc2_:Date = new Date(2014, 1, 7, 0, 0, 0, 0);
        if (_loc2_.getTime() / 1000 < TimeManager.getServerTime()) {
            this.checkPVPFight();
        } else {
            this.initEvent();
        }
    }

    private function checkPVPFight():void {
        if (SceneManager.prevSceneType == SceneType.ARENA && FightManager.currentFightRecord.initData.type == FightRecordData.FIGHT_PVP && FightManager.getPositionIndex() == 5) {
            if (this.fightCount == 1) {
                FightManager.startFightWithBoss(this.MEET_FIGHT);
            } else {
                Connection.addCommandListener(CommandSet.RANDOM_EVENT_1140, this.getRandomState);
                Connection.send(CommandSet.RANDOM_EVENT_1140, this.RANDOM_ID, 0);
            }
        } else {
            this.initEvent();
        }
    }

    private function initEvent():void {
        this.rank.addEventListener(MouseEvent.CLICK, this.showRank);
        DialogPanel.addEventListener(DialogPanelEvent.DIALOG_SHOW, this.onDiaLogShow);
        NpcManager.addEventListener(NpcEvent.ACTOR_ARRIVE, this.onArrive);
    }

    private function getRandomState(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.RANDOM_EVENT_1140, this.getRandomState);
        var _loc2_:Parser_1140 = new Parser_1140(param1.message.getRawDataCopy());
        if (_loc2_.index == this.RANDOM_ID) {
            if (_loc2_.id == 1) {
                FightManager.startFightWithBoss(this.MEET_FIGHT);
            } else {
                this.initEvent();
            }
        }
    }

    private function onArrive(param1:NpcEvent):void {
        if (param1.npcDefinition.id == 195) {
            NpcManager.removeEventListener(NpcEvent.ACTOR_ARRIVE, this.onArrive);
            SeatTipsManager.removeSeat(new Point(470, 105), 1600);
        }
    }

    protected function onDiaLogShow(param1:DialogPanelEvent):void {
        var _loc2_:CustomUnit = null;
        if (param1.content == 195) {
            _loc2_ = new CustomUnit(FunctionalityType.MODULE, "我要竞技", "我要竞技");
            DialogPanel.functionalityBox.addUnit(_loc2_);
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.onCustomUnitClick);
        }
    }

    private function onCustomUnitClick(param1:DialogPanelEvent):void {
        var str:String;
        var event:DialogPanelEvent = param1;
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.onCustomUnitClick);
        str = DialogPanelEventData(event.content).params;
        if (str == "我要竞技") {
            ServerBufferManager.getServerBuffer(ServerBufferType.NEW_SKY_FIGHT_FIRST, function (param1:ServerBuffer):void {
                var server:ServerBuffer = param1;
                if (server.readDataAtPostion(1) == 0) {
                    ModuleManager.addEventListener("NewSkyTipPanel", ModuleEvent.HIDE, function onTipHide(param1:ModuleEvent):void {
                        ModuleManager.showAppModule("SkySportsPanel");
                    });
                    ModuleManager.showAppModule("NewSkyTipPanel");
                    ServerBufferManager.updateServerBuffer(ServerBufferType.NEW_SKY_FIGHT_FIRST, 1, 1);
                } else {
                    ModuleManager.toggleModule(URLUtil.getAppModule("SkySportsPanel"));
                }
            });
        } else if (str == "[活]资质试炼") {
            ModuleManager.showAppModule("KaiXueBigTrialWithPotentialPanel");
        }
    }

    protected function showRank(param1:MouseEvent):void {
        ModuleManager.toggleModule(URLUtil.getAppModule("SkySportsPanel"));
    }

    override public function dispose():void {
        super.dispose();
        this.rank.removeEventListener(MouseEvent.CLICK, this.showRank);
        DialogPanel.removeEventListener(DialogPanelEvent.DIALOG_SHOW, this.onDiaLogShow);
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.onCustomUnitClick);
        NpcManager.removeEventListener(NpcEvent.ACTOR_ARRIVE, this.onArrive);
    }
}
}
