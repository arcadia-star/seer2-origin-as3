package com.taomee.seer2.app.actives.fireClaw {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.controls.PetAvatarPanel;
import com.taomee.seer2.app.info.BuyPropInfo;
import com.taomee.seer2.app.lobby.LobbyScene;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.net.parser.Parser_1142;
import com.taomee.seer2.app.net.parser.Parser_1224;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.shopManager.ShopManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.app.vip.VipManager;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.utils.IDataInput;

import org.taomee.manager.EventManager;
import org.taomee.utils.BitUtil;

public class FireClawPayMode {


    private const FREE_COUNT:uint = 203072;

    private const PAY_COUNT:uint = 203073;

    private const CLONE_NUM:uint = 203075;

    private const FIGHT_SEAT:uint = 203076;

    private const NEED_CLONE:uint = 203074;

    private const FIGHT_STATE:uint = 203077;

    private const GUN_NUM:uint = 203078;

    private const DATA_LIST:Array = [this.FREE_COUNT, this.PAY_COUNT, this.CLONE_NUM, this.FIGHT_SEAT, this.NEED_CLONE, this.FIGHT_STATE, this.GUN_NUM];

    private const RANDOM_CLONE:uint = 55;

    private const FIGHT_TRUE:uint = 563;

    private const FIGHT_CLONE1:uint = 564;

    private const FIGHT_CLONE2:uint = 565;

    private const COUNT_ID:uint = 603222;

    private const CLONEFIRE_SEAT:Array = [[101, 433, 263, 390], [402, 450, 490, 360], [645, 426, 820, 460], [666, 280, 800, 210], [630, 180, 825, 115], [560, 90, 300, 45], [610, 320, 380, 280], [320, 330, 240, 80]];

    private var leftCount:uint = 0;

    private var cloneNum:uint = 0;

    private var fightSeat:int = 0;

    private var needClone:Boolean;

    private var fightState:uint;

    private var gunNum:uint;

    private var content:Sprite;

    private var fireList:Vector.<MovieClip>;

    private var eftList:Vector.<MovieClip>;

    private var cloneFireList:Vector.<MovieClip>;

    private var waterGunBtn:SimpleButton;

    private var actItemBtn:SimpleButton;

    private var fightItemBtn:SimpleButton;

    private var clickFire:MovieClip;

    private var playNum:uint;

    private var cloneValue:uint;

    public function FireClawPayMode() {
        super();
    }

    public function dispose():void {
        var _loc1_:int = 0;
        _loc1_ = 0;
        while (_loc1_ < 8) {
            this.fireList[_loc1_].removeEventListener(MouseEvent.CLICK, this.toFightTrue);
            if (_loc1_ < 2) {
                this.cloneFireList[_loc1_].removeEventListener(MouseEvent.CLICK, this.toFightClone);
            }
            _loc1_++;
        }
    }

    public function setup():void {
        StatisticsManager.sendNovice("0x1003403D");
        var _loc1_:Boolean = SceneManager.prevSceneType == SceneType.ARENA && !FightManager.isWinWar() && FightManager.getPositionIndex() == this.FIGHT_TRUE;
        if (_loc1_) {
            this.exitMap();
            return;
        }
        (SceneManager.active as LobbyScene).hideToolbar();
        PetAvatarPanel.show();
        this.content = SceneManager.active.mapModel.content;
        this.initUIInfo();
        ActiveCountManager.requestActiveCountList(this.DATA_LIST, this.getData);
    }

    private function initUIInfo():void {
        this.fireList = new Vector.<MovieClip>();
        this.eftList = new Vector.<MovieClip>();
        this.cloneFireList = new Vector.<MovieClip>();
        var _loc1_:int = 0;
        while (_loc1_ < 8) {
            this.fireList.push(this.content["fire" + _loc1_]);
            this.fireList[_loc1_].buttonMode = true;
            this.fireList[_loc1_].mouseChildren = false;
            if (_loc1_ < 2) {
                this.cloneFireList.push(this.content["clone" + _loc1_]);
                this.cloneFireList[_loc1_].mouseChildren = false;
                this.cloneFireList[_loc1_].buttonMode = true;
                this.eftList.push(this.content["eft" + _loc1_]);
                this.eftList[_loc1_].mouseChildren = this.eftList[_loc1_].mouseEnabled = false;
                this.eftList[_loc1_].gotoAndStop(1);
                this.cloneFireList[_loc1_].gotoAndStop(1);
                DisplayObjectUtil.removeFromParent(this.eftList[_loc1_]);
                DisplayObjectUtil.removeFromParent(this.cloneFireList[_loc1_]);
            }
            _loc1_++;
        }
        this.waterGunBtn = SceneManager.active.mapModel.front["waterGunBtn"];
        this.actItemBtn = SceneManager.active.mapModel.front["actItemBtn"];
        this.fightItemBtn = SceneManager.active.mapModel.front["fightItemBtn"];
    }

    private function getData(param1:Parser_1142):void {
        var _loc2_:uint = VipManager.vipInfo.isVip() ? 5 : 3;
        var _loc3_:uint = param1.infoVec[0];
        _loc3_ = _loc3_ >= _loc2_ ? _loc2_ : _loc3_;
        this.leftCount = _loc2_ - _loc3_ + param1.infoVec[1];
        this.cloneValue = param1.infoVec[2];
        this.cloneNum = 0;
        var _loc4_:int = 0;
        while (_loc4_ < 2) {
            if (BitUtil.getBit(this.cloneValue, _loc4_ + 2)) {
                ++this.cloneNum;
            }
            _loc4_++;
        }
        var _loc5_:Boolean;
        if (_loc5_ = this.cloneNum == 0 && SceneManager.prevSceneType == SceneType.ARENA && (FightManager.getPositionIndex() == this.FIGHT_CLONE1 || FightManager.getPositionIndex() == this.FIGHT_CLONE1)) {
            this.exitMap();
            return;
        }
        this.fightSeat = param1.infoVec[3] >= 1 ? int(param1.infoVec[3] - 1) : 0;
        this.needClone = Boolean(param1.infoVec[4]);
        if (SceneManager.prevSceneType == SceneType.ARENA && FightManager.isWinWar() && FightManager.getPositionIndex() == this.FIGHT_TRUE && !this.needClone) {
            this.exitMap();
            return;
        }
        this.fightState = param1.infoVec[5];
        this.gunNum = param1.infoVec[6];
        this.initEvent();
        this.updateDisplay();
    }

    private function exitMap():void {
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, this.onCompleteMap);
        SceneManager.changeScene(SceneType.LOBBY, 70);
    }

    private function onCompleteMap(param1:SceneEvent):void {
        if (SceneManager.active.mapID != 70) {
            SceneManager.changeScene(SceneType.LOBBY, 70);
        } else {
            SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, this.onCompleteMap);
            ModuleManager.toggleModule(URLUtil.getAppModule("FireClawActPanel"));
        }
    }

    private function initEvent():void {
        var _loc1_:int = 0;
        _loc1_ = 0;
        while (_loc1_ < 8) {
            this.fireList[_loc1_].addEventListener(MouseEvent.CLICK, this.toFightTrue);
            if (_loc1_ < 2) {
                this.cloneFireList[_loc1_].addEventListener(MouseEvent.CLICK, this.toFightClone);
            }
            _loc1_++;
        }
        this.waterGunBtn.addEventListener(MouseEvent.CLICK, this.toBuy);
        this.actItemBtn.addEventListener(MouseEvent.CLICK, this.toBuy);
        this.fightItemBtn.addEventListener(MouseEvent.CLICK, this.toBuy);
    }

    private function toBuy(param1:MouseEvent):void {
        var _loc2_:String = null;
        if (param1.target == this.waterGunBtn) {
            _loc2_ = "FireClawGunPanel";
            if (this.cloneNum != 0) {
                EventManager.addEventListener("buyWaterGunComplete", this.clearGun);
                ModuleManager.toggleModule(URLUtil.getAppModule(_loc2_), "", true);
                return;
            }
        }
        if (param1.target == this.actItemBtn) {
            _loc2_ = "FireClawItemPanel";
        }
        if (param1.target == this.fightItemBtn) {
            _loc2_ = "MedicineShopPanel";
        }
        ModuleManager.toggleModule(URLUtil.getAppModule(_loc2_));
    }

    private function toFightClone(param1:MouseEvent):void {
        this.clickFire = param1.target as MovieClip;
        if (this.leftCount == 0) {
            AlertManager.showConfirm("你的挑战次数不足，要购买挑战次数吗？", this.buyFightCount);
            return;
        }
        this.fightPet();
    }

    private function fightPet(param1:Parser_1224 = null):void {
        var _loc2_:uint = 0;
        if (this.clickFire == this.cloneFireList[0]) {
            FightManager.startFightWithBoss(this.FIGHT_CLONE1);
        } else if (this.clickFire == this.cloneFireList[1]) {
            FightManager.startFightWithBoss(this.FIGHT_CLONE2);
        } else {
            _loc2_ = this.fireList.indexOf(this.clickFire);
            ModuleManager.toggleModule(URLUtil.getAppModule("FireClawRulePanel"), "", _loc2_);
        }
    }

    private function toFightTrue(param1:MouseEvent):void {
        this.clickFire = param1.target as MovieClip;
        if (this.cloneNum != 0) {
            AlertManager.showAlert("打完分身再来打我吧！");
            return;
        }
        if (this.leftCount == 0) {
            AlertManager.showConfirm("你的挑战次数不足，要购买挑战次数吗？", this.buyFightCount);
            return;
        }
        var _loc2_:uint = this.fireList.indexOf(this.clickFire);
        ModuleManager.toggleModule(URLUtil.getAppModule("FireClawRulePanel"), "", _loc2_);
    }

    private function buyFightCount():void {
        var _loc1_:BuyPropInfo = new BuyPropInfo();
        _loc1_.itemId = this.COUNT_ID;
        _loc1_.buyComplete = this.fightPet;
        ShopManager.buyVirtualItem(_loc1_);
    }

    private function updateDisplay():void {
        var _loc1_:int = 0;
        _loc1_ = 0;
        while (_loc1_ < 8) {
            if (BitUtil.getBit(this.fightState, _loc1_)) {
                this.fireList[_loc1_].gotoAndStop(1);
                DisplayObjectUtil.removeFromParent(this.fireList[_loc1_]);
            }
            _loc1_++;
        }
        if (this.needClone && this.cloneNum == 0) {
            this.reqClone();
        }
        if (this.cloneNum != 0) {
            this.showClone();
        }
    }

    private function showClone():void {
        var _loc1_:Boolean = SceneManager.prevSceneType == SceneType.ARENA && FightManager.getPositionIndex() == this.FIGHT_TRUE;
        this.playNum = 0;
        DisplayObjectUtil.removeFromParent(this.fireList[this.fightSeat]);
        var _loc2_:int = 0;
        while (_loc2_ < this.cloneNum) {
            if (BitUtil.getBit(this.cloneValue, _loc2_)) {
                this.cloneFireList[_loc2_].x = this.CLONEFIRE_SEAT[this.fightSeat][_loc2_ * 2];
                this.cloneFireList[_loc2_].y = this.CLONEFIRE_SEAT[this.fightSeat][_loc2_ * 2 + 1];
                if (_loc1_) {
                    this.eftList[_loc2_].x = this.cloneFireList[_loc2_].x;
                    this.eftList[_loc2_].y = this.cloneFireList[_loc2_].y;
                    this.content.addChild(this.eftList[_loc2_]);
                    MovieClipUtil.playMc(this.eftList[_loc2_], 1, this.eftList[_loc2_].totalFrames, this.clearEft);
                } else {
                    this.cloneFireList[_loc2_].play();
                    this.content.addChild(this.cloneFireList[_loc2_]);
                }
            }
            _loc2_++;
        }
    }

    private function clearGun(param1:Event = null):void {
        var event:Event = param1;
        EventManager.removeEventListener("buyWaterGunComplete", this.clearGun);
        this.cloneNum = 0;
        if (Boolean(this.cloneFireList[0].parent) || Boolean(this.cloneFireList[1].parent)) {
            MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("WaterGunFull"), function ():void {
                var _loc1_:int = 0;
                while (_loc1_ < 2) {
                    DisplayObjectUtil.removeFromParent(cloneFireList[_loc1_]);
                    _loc1_++;
                }
                exitMap();
            });
        }
    }

    private function clearEft():void {
        ++this.playNum;
        this.eftList[this.playNum - 1].gotoAndStop(1);
        this.cloneFireList[this.playNum - 1].play();
        this.content.addChild(this.cloneFireList[this.playNum - 1]);
        DisplayObjectUtil.removeFromParent(this.eftList[this.playNum - 1]);
        if (this.playNum == this.cloneNum) {
            EventManager.addEventListener("buyWaterGunComplete", this.clearGun);
            ModuleManager.toggleModule(URLUtil.getAppModule("FireClawClonePanel"), "", true);
        }
    }

    private function reqClone():void {
        Connection.addCommandListener(CommandSet.RANDOM_EVENT_1140, this.onRandomStatus);
        Connection.send(CommandSet.RANDOM_EVENT_1140, this.RANDOM_CLONE, 0);
    }

    private function onRandomStatus(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.RANDOM_EVENT_1140, this.onRandomStatus);
        var _loc2_:IDataInput = param1.message.getRawDataCopy();
        var _loc3_:uint = uint(_loc2_.readUnsignedInt());
        this.cloneNum = _loc2_.readUnsignedInt();
        ActiveCountManager.requestActiveCount(this.CLONE_NUM, this.getState);
    }

    private function getState(param1:uint, param2:uint):void {
        this.cloneValue = param2;
        this.updateDisplay();
    }
}
}
