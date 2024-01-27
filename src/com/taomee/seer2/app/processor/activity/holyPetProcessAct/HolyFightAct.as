package com.taomee.seer2.app.processor.activity.holyPetProcessAct {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.FightVerifyManager;
import com.taomee.seer2.app.config.ItemConfig;
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.inventory.events.ItemEvent;
import com.taomee.seer2.app.lobby.LobbyScene;
import com.taomee.seer2.app.net.parser.Parser_1142;
import com.taomee.seer2.app.pet.data.PetInfo;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.module.ModuleEvent;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;
import flash.system.ApplicationDomain;
import flash.text.TextField;
import flash.utils.IDataInput;

import org.taomee.utils.DomainUtil;

public class HolyFightAct {

    private static var _self:HolyFightAct;

    private static const ITEM_ID:Vector.<uint> = Vector.<uint>([500588, 500589, 500590, 500591, 500592]);

    private static const TURN_FOR:uint = 203199;

    private static const MI_TURN_FOR:uint = 203200;

    private static const ALL_HURT_FOR:int = 203198;

    private static const FIGHT_INDEX:uint = 597;

    private static const EXIT_MAP_SWAP:int = 1903;

    private static const MAX_BLOOD_NUM:uint = 680000;

    private static const DEFAULT_BLOOD_WIDTH:int = 168;


    private var _map:MapModel;

    private var _resLib:ApplicationDomain;

    private var _menu:MovieClip;

    private var _itemTxt:TextField;

    private var _turnTxt:TextField;

    private var _allHurtTxt:TextField;

    private var _hpTxt:TextField;

    private var _exitBtn:SimpleButton;

    private var _buyBtn:SimpleButton;

    private var _hpBar:MovieClip;

    private var _petBagBtn:SimpleButton;

    private var _tip:MovieClip;

    private var _turnValue:int;

    private var _hurtValue:int;

    private var _leftBlood:int;

    private var _npc:Mobile;

    private var _isToFight:Boolean = false;

    public function HolyFightAct() {
        super();
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, this.onSwitchComplete);
    }

    public static function getInstance():HolyFightAct {
        if (_self == null) {
            _self = new HolyFightAct();
        }
        return _self;
    }

    public function setup(param1:MapModel):void {
        if (SceneManager.prevSceneType == SceneType.ARENA && FightManager.getPositionIndex() == FIGHT_INDEX && FightManager.isWinWar()) {
            SwapManager.swapItem(EXIT_MAP_SWAP, 1, this.closeSwap);
            return;
        }
        this._map = param1;
        this.getURL();
    }

    private function getURL():void {
        QueueLoader.load(URLUtil.getActivityAnimation("holyPetProcessAct/HolyFightAct"), LoadType.SWF, function (param1:ContentInfo):void {
            _resLib = param1.domain;
            init();
        });
    }

    private function init():void {
        this.initSet();
        this.initEvent();
        this.show();
    }

    private function getMovie(param1:String):MovieClip {
        if (this._resLib) {
            return DomainUtil.getMovieClip(param1, this._resLib);
        }
        return null;
    }

    private function initSet():void {
        this._menu = this.getMovie("Menu");
        this._itemTxt = this._menu["itemTxt"];
        this._turnTxt = this._menu["turnTxt"];
        this._allHurtTxt = this._menu["allHurtTxt"];
        this._hpTxt = this._menu["hpTxt"];
        this._hpBar = this._menu["hpBar"];
        this._buyBtn = this._menu["buyBtn"];
        this._exitBtn = this._menu["exitBtn"];
        this._petBagBtn = this._menu["petBtn"];
        this._tip = this._menu["tip"];
        this._tip.mouseEnabled = this._tip.mouseChildren = this._tip.visible = false;
        this._isToFight = false;
        (SceneManager.active as LobbyScene).hideToolbar();
        this.addNpc();
    }

    private function show():void {
        this.update();
        this._map.content.addChild(this._menu);
    }

    private function addNpc():void {
        if (!this._npc) {
            this._npc = new Mobile();
            this._npc.x = 435;
            this._npc.y = 300;
            this._npc.buttonMode = true;
        }
        this._npc.resourceUrl = URLUtil.getActivityMobile("HolyProcessBoss");
        MobileManager.addMobile(this._npc, MobileType.NPC);
    }

    private function toFight(param1:MouseEvent):void {
        if (this._turnValue > 0) {
            if (this.fightFilter()) {
                this._isToFight = true;
                FightManager.startFightWithBoss(FIGHT_INDEX);
            }
        } else {
            this.toExit();
        }
    }

    private function fightFilter():Boolean {
        var _loc1_:Boolean = true;
        if (!FightVerifyManager.validateFightStart()) {
            _loc1_ = false;
        }
        if (!this.isHasPetInBagByRestraint()) {
            _loc1_ = false;
            AlertManager.showAlert("精灵背包中至少有一只被克制的精灵才可以挑战哦!");
        }
        return _loc1_;
    }

    private function isHasPetInBagByRestraint():Boolean {
        var _loc1_:Vector.<int> = Vector.<int>([6, 7, 16, 3, 5, 8, 9, 18, 17]);
        var _loc2_:Boolean = false;
        var _loc3_:Vector.<PetInfo> = PetInfoManager.getAllBagPetInfo();
        var _loc4_:int = 0;
        while (_loc4_ < _loc3_.length) {
            if (_loc1_.indexOf(_loc3_[_loc4_].type) != -1) {
                _loc2_ = true;
                break;
            }
            _loc4_++;
        }
        return _loc2_;
    }

    private function update():void {
        this.requestItem();
        this.requestForeverLimit();
    }

    private function initEvent():void {
        this._exitBtn.addEventListener(MouseEvent.CLICK, this.toExit);
        this._buyBtn.addEventListener(MouseEvent.CLICK, this.toBuy);
        this._petBagBtn.addEventListener(MouseEvent.CLICK, this.openPanel);
        this._npc.addEventListener(MouseEvent.CLICK, this.toFight);
        this._npc.addEventListener(MouseEvent.ROLL_OVER, this.onNpcOver);
        this._npc.addEventListener(MouseEvent.ROLL_OUT, this.onNpcOut);
    }

    private function onNpcOver(param1:MouseEvent):void {
        this._tip.visible = true;
    }

    private function onNpcOut(param1:MouseEvent):void {
        this._tip.visible = false;
    }

    private function openPanel(param1:MouseEvent):void {
        ModuleManager.toggleModule(URLUtil.getAppModule("PetBagPanel"));
    }

    private function toBuy(param1:MouseEvent):void {
        ModuleManager.addEventListener("BuyHurtItemPanel", ModuleEvent.DISPOSE, this.closeBuy);
        ModuleManager.toggleModule(URLUtil.getAppModule("BuyHurtItemPanel"), "正在打开购买伤害面板...", {"type": 2});
    }

    private function closeBuy(param1:ModuleEvent):void {
        ModuleManager.removeEventListener("BuyHurtItemPanel", ModuleEvent.DISPOSE, this.closeBuy);
        this.requestItem();
    }

    private function toExit(param1:MouseEvent = null):void {
        ModuleManager.addEventListener("HolyPetProcessHurtAlertPanel", ModuleEvent.DISPOSE, this.closeAlert);
        ModuleManager.toggleModule(URLUtil.getAppModule("HolyPetProcessHurtAlertPanel"), "", {
            "hurt": this._hurtValue,
            "leftCount": this._turnValue
        });
    }

    private function closeAlert(param1:ModuleEvent):void {
        ModuleManager.removeEventListener("HolyPetProcessHurtAlertPanel", ModuleEvent.DISPOSE, this.closeAlert);
        this.updateTurns();
    }

    private function updateTurns():void {
        this._npc.mouseEnabled = this._npc.mouseChildren = false;
        ActiveCountManager.requestActiveCountList([TURN_FOR, MI_TURN_FOR], function (param1:Parser_1142):void {
            _turnValue = 5 - param1.infoVec[0] + param1.infoVec[1];
            _npc.mouseEnabled = _npc.mouseChildren = true;
            _turnTxt.text = _turnValue.toString();
        });
    }

    private function requestForeverLimit():void {
        this._npc.mouseEnabled = this._npc.mouseChildren = false;
        ActiveCountManager.requestActiveCountList([TURN_FOR, MI_TURN_FOR, ALL_HURT_FOR], this.getNewInfo);
    }

    private function getNewInfo(param1:Parser_1142):void {
        this._turnValue = 5 - param1.infoVec[0] + param1.infoVec[1];
        this._npc.mouseEnabled = this._npc.mouseChildren = true;
        this._hurtValue = param1.infoVec[2];
        this._leftBlood = MAX_BLOOD_NUM - this._hurtValue;
        this.updateBlood();
        if (this._turnValue == 0) {
            this.toExit();
        }
    }

    private function closeSwap(param1:IDataInput):void {
        new SwapInfo(param1);
        SceneManager.changeScene(SceneType.LOBBY, 70);
    }

    private function updateBlood():void {
        this._turnTxt.text = this._turnValue.toString();
        this._hpBar.width = this._leftBlood / MAX_BLOOD_NUM * DEFAULT_BLOOD_WIDTH;
        this._hpTxt.text = this._leftBlood + "/" + MAX_BLOOD_NUM;
        this._allHurtTxt.text = this._hurtValue.toString();
    }

    private function requestItem():void {
        ItemManager.addEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS, this.checkItem);
        ItemManager.requestSpecialItemList(true);
    }

    private function checkItem(param1:ItemEvent):void {
        ItemManager.removeEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS, this.checkItem);
        var _loc2_:int = 0;
        while (_loc2_ < ITEM_ID.length) {
            if (Boolean(ItemManager.getSpecialItem(ITEM_ID[_loc2_])) && ItemManager.getSpecialItem(ITEM_ID[_loc2_]).quantity > 0) {
                this._itemTxt.text = "当前魔神荣耀:" + ItemConfig.getItemDefinition(ITEM_ID[_loc2_]).tip;
                break;
            }
            this._itemTxt.text = "当前魔神荣耀:";
            _loc2_++;
        }
    }

    public function onSwitchComplete(param1:SceneEvent):void {
        if (SceneManager.active.mapID == 70) {
            SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, this.onSwitchComplete);
            ModuleManager.showModule(URLUtil.getAppModule("HolyPetProcessActPanel"), "正在打开魔圣前传(下):神之沙面板...");
            _self = null;
        }
    }

    public function dispose():void {
        this._npc.removeEventListener(MouseEvent.CLICK, this.toFight);
        ModuleManager.removeEventListener("HolyPetProcessHurtAlertPanel", ModuleEvent.DISPOSE, this.closeAlert);
        ModuleManager.removeEventListener("BuyHurtItemPanel", ModuleEvent.DISPOSE, this.closeBuy);
        if (!this._isToFight) {
            (SceneManager.active as LobbyScene).showToolbar();
        }
        this._exitBtn.removeEventListener(MouseEvent.CLICK, this.toExit);
        this._buyBtn.removeEventListener(MouseEvent.CLICK, this.toBuy);
        this._petBagBtn.removeEventListener(MouseEvent.CLICK, this.openPanel);
    }
}
}
