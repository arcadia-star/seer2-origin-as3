package com.taomee.seer2.app.processor.activity.expDoorAct {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.controls.PetAvatarPanel;
import com.taomee.seer2.app.lobby.LobbyScene;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.net.parser.Parser_1142;
import com.taomee.seer2.app.pet.SpawnedPet;
import com.taomee.seer2.app.pet.data.PetInfo;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.app.pet.events.PetInfoEvent;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.quest.animation.QuestCompleteAnimation;
import com.taomee.seer2.app.serverBuffer.ServerBuffer;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.shopManager.ShopManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.module.ModuleEvent;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.ui.toolTip.TooltipManager;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;

import org.taomee.manager.EventManager;

public class ExpDoorAct {

    private static const FOR_LIST:Array = [205120, 205121, 205131, 205137];

    private static const FIGHT_INDEX_LIST:Vector.<int> = Vector.<int>([1345, 1346, 1347, 1348, 1349, 1350]);

    private static const FIGHT_RES_LIST:Vector.<int> = Vector.<int>([43, 10, 342, 71, 207, 714]);

    private static const LEVEL_LIST:Vector.<int> = Vector.<int>([15, 15, 35, 50, 70, 80]);

    private static const MI_ID_LIST:Vector.<uint> = Vector.<uint>([201011, 201010]);


    private var _map:MapModel;

    private var _allExp:TextField;

    private var _getBlood:SimpleButton;

    private var _openPetBag:SimpleButton;

    private var _leave:SimpleButton;

    private var _gateBar:MovieClip;

    private var _startMcList:Vector.<MovieClip>;

    private var _randomMcList:Vector.<MovieClip>;

    private var _miBuyList:Vector.<SimpleButton>;

    private var _itemList:Vector.<SimpleButton>;

    private var _par:Parser_1142;

    private var _curIndex:int;

    private var _oldCoinNum:int = 0;

    public function ExpDoorAct(param1:MapModel) {
        var map:MapModel = param1;
        super();
        this._map = map;
        this.initSet();
        this.initEvent();
        this.update(function ():void {
            _curIndex = -1;
            if (SceneManager.prevSceneType == SceneType.LOBBY && _par.infoVec[0] == 0) {
                _startMcList[0].visible = true;
                MovieClipUtil.playMc(_startMcList[0], 2, _startMcList[0].totalFrames, function ():void {
                    _startMcList[0].gotoAndStop(1);
                    _startMcList[0].visible = false;
                    createMonster(FIGHT_INDEX_LIST[0], FIGHT_RES_LIST[0], 4 - _par.infoVec[3], LEVEL_LIST[0]);
                });
            } else if (SceneManager.prevSceneType == SceneType.ARENA) {
                _curIndex = [1, 3, 7, 15, 31, 63].indexOf(_par.infoVec[0]);
                if (_curIndex == -1) {
                    createMonster(FIGHT_INDEX_LIST[0], FIGHT_RES_LIST[0], 4 - _par.infoVec[3], LEVEL_LIST[0]);
                } else if (FightManager.fightWinnerSide == FightSide.LEFT) {
                    if (FightManager.currentFightRecord.initData.positionIndex == FIGHT_INDEX_LIST[_curIndex]) {
                        if (_curIndex == 2) {
                            ModuleManager.addEventListener("ExpResultPanel", ModuleEvent.HIDE, onResultHide);
                            _randomMcList[0].visible = true;
                            MovieClipUtil.playMc(_randomMcList[0], 2, _randomMcList[0].totalFrames, function ():void {
                                _randomMcList[0].gotoAndStop(1);
                                _randomMcList[0].visible = false;
                                ModuleManager.showAppModule("RandomExpPanel");
                            });
                        } else if (_curIndex == 5) {
                            _randomMcList[1].visible = true;
                            MovieClipUtil.playMc(_randomMcList[1], 2, _randomMcList[1].totalFrames, function ():void {
                                _randomMcList[1].gotoAndStop(1);
                                _randomMcList[1].visible = false;
                                ModuleManager.showAppModule("RandomExpPanel");
                            });
                        } else {
                            ModuleManager.addEventListener("ExpResultPanel", ModuleEvent.HIDE, onResultHide1);
                            ServerBufferManager.getServerBuffer(100014, function (param1:ServerBuffer):void {
                                var _loc4_:Object = null;
                                var _loc5_:QuestCompleteAnimation = null;
                                var _loc2_:int = 6;
                                var _loc3_:int = 0;
                                while (_loc3_ < 6) {
                                    (_loc4_ = new Object())["task_id"] = param1.readDataAtPostion(_loc2_);
                                    _loc4_["step_id"] = param1.readDataAtPostion(++_loc2_);
                                    _loc4_["task_status"] = param1.readDataAtPostion(++_loc2_);
                                    _loc2_++;
                                    if (_loc4_["task_id"] == 13) {
                                        if (_loc4_["task_status"] == 0) {
                                            (_loc5_ = new QuestCompleteAnimation(1)).play();
                                            ServerBufferManager.updataSvrExpandBuffer(100014, 13, 0);
                                        }
                                        EventManager.dispatchEvent(new Event("DiamondTaskEvent"));
                                    }
                                    _loc3_++;
                                }
                            }, false);
                            ModuleManager.showAppModule("ExpResultPanel");
                        }
                    } else {
                        createMonster(FIGHT_INDEX_LIST[_curIndex + 1], FIGHT_RES_LIST[_curIndex + 1], 4 - _par.infoVec[3], LEVEL_LIST[_curIndex + 1]);
                    }
                } else {
                    createMonster(FIGHT_INDEX_LIST[_curIndex + 1], FIGHT_RES_LIST[_curIndex + 1], 4 - _par.infoVec[3], LEVEL_LIST[_curIndex + 1]);
                }
            }
        });
    }

    private function hideLobbyMenu():void {
        (SceneManager.active as LobbyScene).hideToolbar();
        PetAvatarPanel.show();
    }

    private function onResultHide(param1:ModuleEvent):void {
        var evt:ModuleEvent = param1;
        ModuleManager.removeEventListener("ExpResultPanel", ModuleEvent.HIDE, this.onResultHide);
        this._startMcList[this._curIndex + 1].visible = true;
        MovieClipUtil.playMc(this._startMcList[this._curIndex + 1], 2, this._startMcList[this._curIndex + 1].totalFrames, function ():void {
            _startMcList[_curIndex + 1].gotoAndStop(1);
            _startMcList[_curIndex + 1].visible = false;
            createMonster(FIGHT_INDEX_LIST[_curIndex + 1], FIGHT_RES_LIST[_curIndex + 1], 4 - _par.infoVec[3], LEVEL_LIST[_curIndex + 1]);
            update(updateAllExp);
        });
    }

    private function onResultHide1(param1:ModuleEvent):void {
        var evt:ModuleEvent = param1;
        ModuleManager.removeEventListener("ExpResultPanel", ModuleEvent.HIDE, this.onResultHide1);
        this._startMcList[this._curIndex + 1].visible = true;
        MovieClipUtil.playMc(this._startMcList[this._curIndex + 1], 2, this._startMcList[this._curIndex + 1].totalFrames, function ():void {
            _startMcList[_curIndex + 1].gotoAndStop(1);
            _startMcList[_curIndex + 1].visible = false;
            createMonster(FIGHT_INDEX_LIST[_curIndex + 1], FIGHT_RES_LIST[_curIndex + 1], 4 - _par.infoVec[3], LEVEL_LIST[_curIndex + 1]);
            update(updateAllExp);
        });
    }

    private function initSet():void {
        this._allExp = this._map.front["allExp"];
        this._getBlood = this._map.front["getBlood"];
        this._openPetBag = this._map.front["openPetBag"];
        this._leave = this._map.front["leave"];
        this._gateBar = this._map.front["gateBar"];
        this._startMcList = new Vector.<MovieClip>();
        var _loc1_:int = 0;
        while (_loc1_ < 6) {
            this._startMcList.push(this._map.front["startMc" + _loc1_]);
            this._startMcList[_loc1_].mouseEnabled = this._startMcList[_loc1_].mouseChildren = this._startMcList[_loc1_].visible = false;
            _loc1_++;
        }
        this._randomMcList = new Vector.<MovieClip>();
        _loc1_ = 0;
        while (_loc1_ < 2) {
            this._randomMcList.push(this._map.front["randomMc" + _loc1_]);
            this._randomMcList[_loc1_].mouseEnabled = this._randomMcList[_loc1_].mouseChildren = this._randomMcList[_loc1_].visible = false;
            _loc1_++;
        }
        this._miBuyList = new Vector.<SimpleButton>();
        this._itemList = new Vector.<SimpleButton>();
        _loc1_ = 0;
        while (_loc1_ < 2) {
            this._miBuyList.push(this._map.front["miBuy" + _loc1_]);
            this._itemList.push(this._map.front["item" + _loc1_]);
            _loc1_++;
        }
        TooltipManager.addCommonTip(this._itemList[0], "双倍加速器");
        TooltipManager.addCommonTip(this._itemList[1], "三倍经验加速器");
        this.hideLobbyMenu();
    }

    private function initEvent():void {
        var _loc1_:SimpleButton = null;
        this._getBlood.addEventListener(MouseEvent.CLICK, this.onGetBlood);
        this._openPetBag.addEventListener(MouseEvent.CLICK, this.onOpenPetBag);
        this._leave.addEventListener(MouseEvent.CLICK, this.onLeave);
        for each(_loc1_ in this._miBuyList) {
            _loc1_.addEventListener(MouseEvent.CLICK, this.onMiBuy);
        }
    }

    private function onMiBuy(param1:MouseEvent):void {
        var _loc2_:int = this._miBuyList.indexOf(param1.currentTarget as SimpleButton);
        ShopManager.buyItemForId(MI_ID_LIST[_loc2_]);
    }

    private function onLeave(param1:MouseEvent):void {
        ModuleManager.showAppModule("ExpLeaveTipPanel");
    }

    private function onOpenPetBag(param1:MouseEvent):void {
        ModuleManager.showAppModule("PetBagPanel");
    }

    private function onGetBlood(param1:MouseEvent):void {
        if (PetInfoManager.canCure() == false) {
            ServerMessager.addMessage("你的精灵不需要恢复");
            return;
        }
        this._oldCoinNum = ActorManager.actorInfo.coins;
        this.recoverAllPetBagPet();
    }

    private function recoverAllPetBagPet():void {
        Connection.addCommandListener(CommandSet.TREAT_ALL_PET_1215, this.onAddAllPetBlood);
        Connection.send(CommandSet.TREAT_ALL_PET_1215);
    }

    private function onAddAllPetBlood(param1:MessageEvent):void {
        var _loc3_:PetInfo = null;
        var _loc4_:int = 0;
        Connection.removeCommandListener(CommandSet.TREAT_ALL_PET_1215, this.onAddAllPetBlood);
        var _loc2_:Vector.<PetInfo> = PetInfoManager.getAllBagPetInfo();
        for each(_loc3_ in _loc2_) {
            _loc3_.hp = _loc3_.maxHp;
            PetInfoManager.dispatchEvent(PetInfoEvent.PET_PROPERTIES_CHANGE, _loc3_);
        }
        _loc4_ = int(param1.message.getRawData().readUnsignedInt());
        ActorManager.actorInfo.coins = _loc4_;
        ServerMessager.addMessage("消耗" + (this._oldCoinNum - _loc4_) + "赛尔豆恢复背包中所有精灵！");
    }

    private function createMonster(param1:int, param2:int, param3:int, param4:int):void {
        var _loc5_:Mobile = null;
        var _loc6_:int = 0;
        while (_loc6_ < param3) {
            _loc5_ = new SpawnedPet(param2, param1, param4);
            MobileManager.addMobile(_loc5_, MobileType.SPAWNED_PET);
            _loc6_++;
        }
        this.updateAllExp();
    }

    private function update(param1:Function = null):void {
        var func:Function = param1;
        ActiveCountManager.requestActiveCountList(FOR_LIST, function (param1:Parser_1142):void {
            _par = param1;
            if (func != null) {
                func();
            }
        });
    }

    private function updateAllExp():void {
        this._allExp.text = (this._par.infoVec[1] + this._par.infoVec[2]).toString();
        this._gateBar.gotoAndStop(this._curIndex + 2 >= 6 ? 6 : this._curIndex + 2);
    }

    public function dispose():void {
        var _loc1_:SimpleButton = null;
        if (this._getBlood) {
            this._getBlood.removeEventListener(MouseEvent.CLICK, this.onGetBlood);
        }
        if (this._openPetBag) {
            this._openPetBag.removeEventListener(MouseEvent.CLICK, this.onOpenPetBag);
        }
        if (this._leave) {
            this._leave.removeEventListener(MouseEvent.CLICK, this.onLeave);
        }
        if (this._miBuyList) {
            for each(_loc1_ in this._miBuyList) {
                _loc1_.removeEventListener(MouseEvent.CLICK, this.onMiBuy);
            }
        }
        if (this._itemList) {
            TooltipManager.remove(this._itemList[0]);
            TooltipManager.remove(this._itemList[1]);
        }
        ModuleManager.removeEventListener("ExpResultPanel", ModuleEvent.HIDE, this.onResultHide);
        ModuleManager.removeEventListener("ExpResultPanel", ModuleEvent.HIDE, this.onResultHide1);
        this._map = null;
        this._allExp = null;
        this._getBlood = null;
        this._openPetBag = null;
        this._leave = null;
        this._gateBar = null;
        this._startMcList = null;
        this._randomMcList = null;
        this._miBuyList = null;
        this._itemList = null;
    }
}
}
