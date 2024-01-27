package com.taomee.seer2.app.processor.map {
import com.greensock.TweenNano;
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.manager.DayLimitManager;
import com.taomee.seer2.app.net.parser.Parser_1142;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.shopManager.ShopManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;
import flash.text.TextField;

import org.taomee.filter.ColorFilter;

public class MapProcessor_80314 extends MapProcessor {


    private var fightThirdID:Array;

    private var _mc:MovieClip;

    private var _gameCount:int;

    private var boosNpc:Mobile;

    private var npcId:int = 751;

    private var harmTxt:TextField;

    private var skipBtn:SimpleButton;

    private var buyBtn:SimpleButton;

    private var foreverLimit:Array;

    private var dayLimit:int = 1342;

    private var _harm:int;

    private var isGot:int;

    public function MapProcessor_80314(param1:MapModel) {
        this.fightThirdID = [1226];
        this.foreverLimit = [204743, 204744, 204802];
        super(param1);
    }

    override public function init():void {
        this.harmTxt = _map.content["harmTxt"];
        this.skipBtn = _map.content["skipBtn"];
        this.buyBtn = _map.content["buyBtn"];
        this.buyBtn.addEventListener(MouseEvent.CLICK, this.onBuy);
        this.skipBtn.addEventListener(MouseEvent.CLICK, this.onSkip);
        this.createNPC();
        this.checkStatues();
    }

    private function onBuy(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        ShopManager.buyItemForId(500612, function (param1:*):void {
            checkStatues();
        });
    }

    private function onSkip(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        ShopManager.buyItemForId(604196, function (param1:*):void {
            var p:* = param1;
            ServerMessager.addMessage("恭喜通关喽!");
            SceneManager.changeScene(SceneType.LOBBY, 70);
            TweenNano.delayedCall(3, function ():void {
                ModuleManager.showAppModule("MiuSiSuperStrengthenPanel");
            });
        });
    }

    private function checkStatues():void {
        DayLimitManager.getDoCount(this.dayLimit, function (param1:int):void {
            var harmNums:int = param1;
            _harm = harmNums;
            ActiveCountManager.requestActiveCountList(foreverLimit, function (param1:Parser_1142):void {
                isGot = param1.infoVec[2];
                if (ActorManager.actorInfo.vipInfo.isVip()) {
                    _gameCount = getCanNum(param1.infoVec[0], param1.infoVec[1], 2);
                } else {
                    _gameCount = getCanNum(param1.infoVec[0], param1.infoVec[1], 1);
                }
                harmTxt.text = _harm.toString();
                if (isGot == 1) {
                    setBtnEnable(buyBtn, false);
                } else {
                    setBtnEnable(buyBtn, true);
                }
            });
        });
    }

    private function onSwitchMap(param1:SceneEvent):void {
        var e:SceneEvent = param1;
        if (SceneManager.prevSceneType == SceneType.ARENA) {
            if (this.fightThirdID.indexOf(FightManager.currentFightRecord.initData.positionIndex) != -1) {
                DayLimitManager.getDoCount(1342, function (param1:int):void {
                    var harmNums:int = param1;
                    _harm = harmNums;
                    if (_harm >= 100000) {
                        MovieClipUtil.playNpcTalkNew(URLUtil.getActivityFullScreen("MiuSiSuperStrengthen3"), 2, [[1, 0]], function ():void {
                        });
                    }
                    SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, onSwitchMap);
                    SceneManager.changeScene(SceneType.LOBBY, 70);
                    ModuleManager.showModule(URLUtil.getAppModule("MiuSiSuperStrengthenPanel"), "正在打开面板...");
                });
            }
        }
    }

    private function createNPC():void {
        this.boosNpc = new Mobile();
        this.boosNpc.resourceUrl = URLUtil.getNpcSwf(this.npcId);
        this.boosNpc.buttonMode = true;
        this.boosNpc.x = 665;
        this.boosNpc.y = 270;
        this.boosNpc.addEventListener(MouseEvent.CLICK, this.toFight);
        MobileManager.addMobile(this.boosNpc, MobileType.NPC);
    }

    private function toFight(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        if (this._gameCount <= 0) {
            ShopManager.buyItemForId(604135, function (param1:*):void {
                checkStatues();
            });
        } else {
            SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, this.onSwitchMap);
            FightManager.startFightWithWild(this.fightThirdID[0]);
        }
    }

    public function getCanNum(param1:int, param2:int, param3:int):int {
        var _loc4_:int = 0;
        if (param1 > param3) {
            _loc4_ = param2;
        } else {
            _loc4_ = param3 - param1 + param2;
        }
        return _loc4_;
    }

    private function setBtnEnable(param1:SimpleButton, param2:Boolean):void {
        if (param2) {
            param1.filters = [];
        } else {
            ColorFilter.setGrayscale(param1);
        }
        param1.mouseEnabled = param2;
    }
}
}
