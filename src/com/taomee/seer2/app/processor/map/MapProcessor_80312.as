package com.taomee.seer2.app.processor.map {
import com.greensock.TweenNano;
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.controls.PetAvatarPanel;
import com.taomee.seer2.app.info.DayLimitListInfo;
import com.taomee.seer2.app.lobby.LobbyScene;
import com.taomee.seer2.app.manager.DayLimitListManager;
import com.taomee.seer2.app.pet.SpawnedPet;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.shopManager.ShopManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.utils.DateUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.SimpleButton;
import flash.events.MouseEvent;
import flash.text.TextField;

import org.taomee.filter.ColorFilter;
import org.taomee.utils.BitUtil;
import org.taomee.utils.DisplayUtil;
import org.taomee.utils.Tick;

public class MapProcessor_80312 extends MapProcessor {


    private var _timeTxt:TextField;

    private var _scoreTxt:TextField;

    private var _skipBtn:SimpleButton;

    private var boosNpc:Mobile;

    private var _info:DayLimitListInfo;

    private var _par:int;

    private var dayLimit:Array;

    private var _scoreNums:int;

    private var _cdTime:int;

    private var _leftTime:int;

    private var _monsterList:Vector.<SpawnedPet>;

    private var RES_ID:Array;

    private var fightFirstID:Array;

    private var npcId:int = 450;

    public function MapProcessor_80312(param1:MapModel) {
        this.dayLimit = [1339, 1350];
        this.RES_ID = [450, 558, 643];
        this.fightFirstID = [1221, 1222, 1223];
        super(param1);
    }

    override public function init():void {
        this._timeTxt = _map.content["timeTxt"];
        this._scoreTxt = _map.content["scoreTxt"];
        this._skipBtn = _map.content["skipBtn"];
        this._skipBtn.addEventListener(MouseEvent.CLICK, this.onSkip);
        this.checkStatues();
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, this.onSwitchMap);
    }

    private function onSwitchMap(param1:SceneEvent):void {
        if (SceneManager.prevSceneType == SceneType.ARENA) {
            if (this.fightFirstID.indexOf(FightManager.currentFightRecord.initData.positionIndex) != -1) {
                if (this._par == 1) {
                    SceneManager.changeScene(SceneType.LOBBY, 70);
                    ModuleManager.showModule(URLUtil.getAppModule("MiuSiSuperStrengthenPanel"), "正在打开面板...");
                    SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, this.onSwitchMap);
                }
            }
        }
    }

    private function hideLobbyMenu():void {
        (SceneManager.active as LobbyScene).hideToolbar();
        PetAvatarPanel.show();
    }

    private function onSkip(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        ShopManager.buyItemForId(604194, function (param1:*):void {
            Tick.instance.removeRender(updateTime);
            checkStatues();
        });
    }

    private function checkStatues():void {
        ActiveCountManager.requestActiveCount(204745, function (param1:int, param2:int):void {
            var type:int = param1;
            var parBit:int = param2;
            _par = parBit;
            DayLimitListManager.getDaylimitList(dayLimit, function (param1:DayLimitListInfo):void {
                var info:DayLimitListInfo = param1;
                _scoreNums = info.getCount(dayLimit[0]);
                _cdTime = info.getCount(dayLimit[1]);
                _info = info;
                if (_info == null) {
                    _info = info;
                } else {
                    if (_info.getCount(dayLimit[0]) < info.getCount(dayLimit[0])) {
                        ServerMessager.addMessage("恭喜本次挑战获得" + (info.getCount(dayLimit[0]) - _info.getCount(dayLimit[0])) + "分哦!");
                    }
                    if (_par == 1) {
                        MovieClipUtil.playNpcTalkNew(URLUtil.getActivityFullScreen("MiuSiSuperStrengthen1"), 2, [[1, 0]], function ():void {
                            ServerMessager.addMessage("恭喜通关喽!");
                            SceneManager.changeScene(SceneType.LOBBY, 70);
                            TweenNano.delayedCall(3, function ():void {
                                ModuleManager.showAppModule("MiuSiSuperStrengthenPanel");
                            });
                        });
                    }
                    _info = info;
                }
                if (BitUtil.getBit(_par, 0)) {
                    _skipBtn.visible = false;
                } else {
                    _skipBtn.visible = true;
                }
                updateShow();
            });
        });
    }

    private function updateShow():void {
        this._leftTime = this._cdTime - TimeManager.getPrecisionServerTime();
        if (this._leftTime <= 0) {
            this._leftTime = 0;
        }
        this._timeTxt.text = DateUtil.getMS(this._leftTime).toString();
        Tick.instance.removeRender(this.updateTime);
        if (this._leftTime > 0) {
            Tick.instance.addRender(this.updateTime, 1000);
            if (BitUtil.getBit(this._par, 0) == 0) {
                this.createMonster();
            } else if (this._scoreNums < 50) {
                this.createMonster();
            }
        } else {
            this.createMonster();
        }
        this._scoreTxt.text = this._scoreNums.toString();
    }

    private function createMonster():void {
        this.clearMonsterList();
        this._monsterList = new Vector.<SpawnedPet>();
        var _loc1_:int = 0;
        while (_loc1_ < 3) {
            this._monsterList.push(new SpawnedPet(this.RES_ID[_loc1_], this.fightFirstID[_loc1_], 0));
            MobileManager.addMobile(this._monsterList[_loc1_], MobileType.SPAWNED_PET);
            _loc1_++;
        }
    }

    private function clearMonsterList():void {
        var _loc1_:SpawnedPet = null;
        if (this._monsterList) {
            for each(_loc1_ in this._monsterList) {
                DisplayUtil.removeForParent(_loc1_);
            }
            this._monsterList = null;
        }
    }

    private function updateTime(param1:uint):void {
        if (this._leftTime <= 0) {
            Tick.instance.removeRender(this.updateTime);
        } else {
            this.updateTimeTxt();
        }
    }

    private function updateTimeTxt():void {
        --this._leftTime;
        var _loc1_:String = String(DateUtil.getMS(this._leftTime));
        this._timeTxt.text = _loc1_;
    }

    private function setBtnEnable(param1:SimpleButton, param2:Boolean):void {
        if (param2) {
            param1.filters = [];
        } else {
            ColorFilter.setGrayscale(param1);
        }
        param1.mouseEnabled = param2;
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
}
}
