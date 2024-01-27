package com.taomee.seer2.app.processor.map {
import com.greensock.TweenNano;
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.controls.PetAvatarPanel;
import com.taomee.seer2.app.info.DayLimitListInfo;
import com.taomee.seer2.app.lobby.LobbyScene;
import com.taomee.seer2.app.manager.DayLimitListManager;
import com.taomee.seer2.app.net.parser.Parser_1142;
import com.taomee.seer2.app.pet.SpawnedPet;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.shopManager.ShopManager;
import com.taomee.seer2.app.utils.ActsHelperUtil;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DateUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;
import flash.text.TextField;

import org.taomee.utils.BitUtil;
import org.taomee.utils.DisplayUtil;
import org.taomee.utils.Tick;

public class MapProcessor_80242 extends MapProcessor {

    private static const FOR_LIST:Array = [204561, 204560];

    private static const DAY_LIST:Array = [1281];

    private static const FIGHT_INDEX:Vector.<uint> = Vector.<uint>([1154, 1155, 1156, 1157]);

    private static const LAST_TIME:int = 300;

    private static const RES_ID:int = 1100;

    private static const MI_ID_LIST:Vector.<uint> = Vector.<uint>([604073]);

    private static var _par:Parser_1142;

    private static var _info:DayLimitListInfo;


    private var _timeUI:MovieClip;

    private var _scoreUI:MovieClip;

    private var _leftTim:TextField;

    private var _scroe:TextField;

    private var _miPass:SimpleButton;

    private var _leaveTime:int;

    private var _monsterList:Vector.<SpawnedPet>;

    public function MapProcessor_80242(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this.onActInit();
    }

    private function onActInit():void {
        this._timeUI = _map.front["timeUI"];
        this._scoreUI = _map.front["scoreUI"];
        this._leftTim = this._timeUI["leftTim"];
        this._scroe = this._scoreUI["scroe"];
        this._miPass = _map.front["miPass"];
        this.hideLobbyMenu();
        this.update();
    }

    private function update():void {
        ActiveCountManager.requestActiveCountList(FOR_LIST, function (param1:Parser_1142):void {
            var par:Parser_1142 = param1;
            DayLimitListManager.getDaylimitList(DAY_LIST, function (param1:DayLimitListInfo):void {
                _info = param1;
                if (_par == null) {
                    _par = par;
                } else {
                    if (_par.infoVec[1] < par.infoVec[1]) {
                        ServerMessager.addMessage("恭喜本次挑战获得" + (par.infoVec[1] - _par.infoVec[1]) + "分哦!");
                    }
                    if (par.infoVec[0] != _par.infoVec[0]) {
                        ServerMessager.addMessage("恭喜通关喽!");
                    }
                    _par = par;
                }
                if (BitUtil.getBit(_par.infoVec[0], 0)) {
                    _miPass.visible = false;
                } else {
                    _miPass.visible = true;
                }
                _miPass.addEventListener(MouseEvent.CLICK, onMiPass);
                _scroe.text = _par.infoVec[1].toString();
                _leaveTime = LAST_TIME - (TimeManager.getPrecisionServerTime() - _info.getCount(DAY_LIST[0]));
                if (_leaveTime <= 0) {
                    _leaveTime = 0;
                }
                _leftTim.text = DateUtil.getMS(_leaveTime).toString();
                Tick.instance.removeRender(timeUpdate);
                if (_leaveTime > 0) {
                    Tick.instance.addRender(timeUpdate, 1000);
                    if (_par.infoVec[0] == 0) {
                        createMonster();
                    } else if (_par.infoVec[1] < 50) {
                        createMonster();
                    }
                }
            });
        });
    }

    private function hideLobbyMenu():void {
        (SceneManager.active as LobbyScene).hideToolbar();
        PetAvatarPanel.show();
    }

    private function onMiPass(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        ShopManager.buyItemForId(MI_ID_LIST[0], function ():void {
            ServerMessager.addMessage("恭喜通关喽!");
            SceneManager.changeScene(SceneType.LOBBY, 70);
            TweenNano.delayedCall(3, function ():void {
                ModuleManager.showAppModule("LeiYiSuperProcessPanel");
            });
        });
    }

    private function createMonster():void {
        this.clearMonsterList();
        this._monsterList = new Vector.<SpawnedPet>();
        var _loc1_:int = 0;
        while (_loc1_ < 3) {
            this._monsterList.push(new SpawnedPet(RES_ID, FIGHT_INDEX[ActsHelperUtil.getRandom(0, 3)], 0));
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

    private function timeUpdate(param1:uint):void {
        --this._leaveTime;
        if (this._leaveTime <= 0) {
            Tick.instance.removeRender(this.timeUpdate);
            this.clearMonsterList();
        }
        this._leftTim.text = DateUtil.getMS(this._leaveTime).toString();
    }

    private function onActDispose():void {
        this.clearMonsterList();
        Tick.instance.removeRender(this.timeUpdate);
        this._timeUI = null;
        this._scoreUI = null;
        this._leftTim = null;
        this._scroe = null;
        if (this._miPass) {
            this._miPass.removeEventListener(MouseEvent.CLICK, this.onMiPass);
            this._miPass = null;
        }
    }

    override public function dispose():void {
        this.onActDispose();
        super.dispose();
    }
}
}
