package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.lobby.LobbyScene;
import com.taomee.seer2.app.manager.DayLimitManager;
import com.taomee.seer2.app.net.parser.Parser_1142;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.vip.VipManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;

import flash.events.Event;
import flash.events.MouseEvent;

public class MapProcessor_80221 extends MapProcessor {

    private static var HAMLEITE_WIN_FOR:uint = 204476;

    private static var HAMLEITE_USETIME_FOR:uint = 204469;

    private static var HMULEITE_HAVE_GET_FOR:uint = 204406;

    private static var MI_BUY_NUM_HMULEITE_FOR:uint = 204407;

    public static var havewin:Boolean = false;


    private const FIGHT_DAY:int = 1231;

    private const ITEM_LIST:Vector.<uint> = Vector.<uint>([400498]);

    private const FIGHT_ID:int = 1094;

    private var isToFight:Boolean = false;

    public function MapProcessor_80221(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this.isToFight = false;
        _map.front["tarMc"].visible = true;
        _map.front["pet"].buttonMode = true;
        _map.front["pet"];
        this.update();
        this.initEvent();
    }

    override public function dispose():void {
        if (!this.isToFight) {
            (SceneManager.active as LobbyScene).showToolbar();
        }
    }

    private function initEvent():void {
        if (!_map.front["pet"].hasEventListener(MouseEvent.CLICK)) {
            _map.front["pet"].addEventListener(MouseEvent.CLICK, this.onClickPet);
        }
        if (!_map.front["tarMc"]["leaveBtn"].hasEventListener(MouseEvent.CLICK)) {
            _map.front["tarMc"]["leaveBtn"].addEventListener(MouseEvent.CLICK, this.onClick);
        }
        if (!_map.front["vipBtn"].hasEventListener(MouseEvent.CLICK)) {
            _map.front["vipBtn"].addEventListener(MouseEvent.CLICK, this.onClick2);
        }
    }

    private function onGoShowClose(param1:MouseEvent):void {
    }

    private function onGoShowOk(param1:MouseEvent):void {
        SceneManager.changeScene(SceneType.LOBBY, 70);
    }

    private function onHelp(param1:MouseEvent):void {
        ModuleManager.showAppModule("MedicineShopPanel");
    }

    private function onPetBag(param1:MouseEvent):void {
        ModuleManager.showAppModule("PetBagPanel");
    }

    private function onVip(param1:MouseEvent):void {
        VipManager.navigateToPayPage();
    }

    private function onClickPet(param1:MouseEvent):void {
        this.onSpeak1();
    }

    private function onClick(param1:MouseEvent):void {
        havewin = false;
        SceneManager.changeScene(SceneType.LOBBY, 70);
    }

    private function onClick2(param1:MouseEvent):void {
        ModuleManager.showAppModule("VipRechargeBasePanel");
    }

    private function onSpeak1():void {
        if (uint(_map.front["tarMc"]["times"].text) <= 0) {
            AlertManager.showAlert("今天挑战次数已用尽！");
            return;
        }
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, this.onOver);
        this.isToFight = true;
        havewin = false;
        FightManager.startFightWithWild(this.FIGHT_ID);
    }

    private function onOver(param1:Event):void {
        if (FightManager.getPositionIndex() != this.FIGHT_ID) {
            return;
        }
        if (SceneManager.prevSceneType == SceneType.ARENA && FightManager.fightWinnerSide == FightSide.LEFT) {
            havewin = true;
        } else if (SceneManager.prevSceneType == SceneType.ARENA && FightManager.fightWinnerSide == FightSide.RIGHT) {
        }
    }

    private function update():void {
        var miBuyVal:int = 0;
        var power:int = 0;
        var win:int = 0;
        var practiceVal:int = 0;
        DayLimitManager.getDoCount(this.FIGHT_DAY, function (param1:int):void {
            var val:int = param1;
            ActiveCountManager.requestActiveCountList([HAMLEITE_WIN_FOR, HAMLEITE_USETIME_FOR, MI_BUY_NUM_HMULEITE_FOR], function (param1:Parser_1142):void {
                var _loc2_:int = val;
                win = param1.infoVec[0];
                if (win >= 3) {
                    win = 0;
                }
                miBuyVal = param1.infoVec[1];
                var _loc3_:uint = 6;
                if (_loc2_ > _loc3_) {
                    practiceVal = miBuyVal;
                } else {
                    practiceVal = _loc3_ - _loc2_ + miBuyVal;
                }
                _map.front["tarMc"]["totle"].text = 3 - win + "";
                _map.front["tarMc"]["times"].text = _loc3_ - miBuyVal + "";
            });
        });
    }
}
}
