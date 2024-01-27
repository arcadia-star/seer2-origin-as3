package com.taomee.seer2.app.processor.map {
import com.greensock.TweenNano;
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.controls.PetAvatarPanel;
import com.taomee.seer2.app.info.DayLimitListInfo;
import com.taomee.seer2.app.lobby.LobbyScene;
import com.taomee.seer2.app.manager.DayLimitListManager;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.net.parser.Parser_1140;
import com.taomee.seer2.app.net.parser.Parser_1142;
import com.taomee.seer2.app.pet.data.PetInfo;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.utils.ActsHelperUtil;
import com.taomee.seer2.app.vip.VipManager;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.text.TextField;

public class MapProcessor_80203 extends MapProcessor_80101 {

    private static const DAY_LIST:Array = [1132, 1138];

    private static const FIGHT_INDEX_LIST:Vector.<int> = Vector.<int>([984, 985, 986, 987, 988]);

    private static const FOR_LIST:Array = [204200];

    private static const RANDOM_ID:int = 96;

    private static const FIGHT_NUM_RULE:Vector.<int> = Vector.<int>([3, 3]);

    private static const FIGHT_RULE:Vector.<int> = Vector.<int>([8]);


    private var _numList:Vector.<TextField>;

    private var _stoneList:Vector.<MovieClip>;

    private var _par:Parser_1142;

    private var _info:DayLimitListInfo;

    private var _canFightNum:int;

    public function MapProcessor_80203(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this.stoneManActInit();
    }

    private function stoneManActInit():void {
        if (SceneManager.prevSceneType == SceneType.ARENA && FIGHT_INDEX_LIST.indexOf(FightManager.currentFightRecord.initData.positionIndex) != -1) {
            this.getDataHandleFromBattle();
        } else {
            this.getDataHandleNormal();
        }
    }

    private function getDataHandleNormal():void {
        DayLimitListManager.getDaylimitList(DAY_LIST, function (param1:DayLimitListInfo):void {
            var info:DayLimitListInfo = param1;
            ActiveCountManager.requestActiveCountList(FOR_LIST, function (param1:Parser_1142):void {
                _par = param1;
                _info = info;
                _canFightNum = ActsHelperUtil.getCanNum(_info.getCount(DAY_LIST[0]), _par.infoVec[0], VipManager.vipInfo.isVip() ? FIGHT_NUM_RULE[1] : FIGHT_NUM_RULE[0]);
                initSet();
            });
        });
    }

    private function getDataHandleFromBattle():void {
        DayLimitListManager.getDaylimitList(DAY_LIST, function (param1:DayLimitListInfo):void {
            var info:DayLimitListInfo = param1;
            ActiveCountManager.requestActiveCountList(FOR_LIST, function (param1:Parser_1142):void {
                var par:Parser_1142 = param1;
                _par = par;
                _info = info;
                _canFightNum = ActsHelperUtil.getCanNum(_info.getCount(DAY_LIST[0]), _par.infoVec[0], VipManager.vipInfo.isVip() ? FIGHT_NUM_RULE[1] : FIGHT_NUM_RULE[0]);
                if (_canFightNum > 0) {
                    initSet();
                } else {
                    TweenNano.delayedCall(3, function ():void {
                        ServerMessager.addMessage("今日免费挑战次数已用完，可花费星钻继续战斗！");
                        SceneManager.changeScene(SceneType.LOBBY, 70);
                    });
                }
            });
        });
    }

    private function initSet():void {
        this._numList = new Vector.<TextField>();
        var _loc1_:int = 0;
        while (_loc1_ < 2) {
            this._numList.push(_map.front["num" + _loc1_]);
            _loc1_++;
        }
        this._stoneList = new Vector.<MovieClip>();
        _loc1_ = 0;
        while (_loc1_ < 5) {
            this._stoneList.push(_map.content["stone" + _loc1_]);
            this._stoneList[_loc1_].buttonMode = true;
            this._stoneList[_loc1_].addEventListener(MouseEvent.CLICK, this.onRandom);
            _loc1_++;
        }
        this.hideLobbyMenu();
        this._numList[0].text = this._canFightNum.toString();
        this._numList[1].text = (FIGHT_RULE[0] - this._info.getCount(DAY_LIST[0]) % FIGHT_RULE[0]).toString();
        Connection.addCommandListener(CommandSet.RANDOM_EVENT_1140, this.onEventStart);
    }

    private function forwardFilter():Boolean {
        if (TimeManager.getAvailableTime() <= 0) {
            AlertManager.showAlert("电池已耗完,暂时不可前进,以防遇到对战不可进入战斗哦!");
            return false;
        }
        var _loc1_:PetInfo = PetInfoManager.getFirstPetInfo();
        if (_loc1_ != null) {
            if (_loc1_.hp == 0) {
                AlertManager.showAlert("首发精灵体力耗尽,暂时不可前进,以防遇到对战不可进入战斗哦!");
                return false;
            }
            return true;
        }
        AlertManager.showAlert("没有设置首发精灵,暂时不可前进,以防遇到对战不可进入战斗哦!");
        return false;
    }

    private function onEventStart(param1:MessageEvent):void {
        var _loc2_:Parser_1140 = new Parser_1140(param1.message.getRawDataCopy());
        if (_loc2_.index == RANDOM_ID) {
            this.setStoneMouseEnable(true);
            FightManager.startFightWithWild(FIGHT_INDEX_LIST[_loc2_.id - 1]);
        }
    }

    private function setStoneMouseEnable(param1:Boolean):void {
        var _loc2_:MovieClip = null;
        for each(_loc2_ in this._stoneList) {
            _loc2_.mouseEnabled = _loc2_.mouseChildren = param1;
        }
    }

    private function onRandom(param1:MouseEvent):void {
        this.setStoneMouseEnable(false);
        if (this.forwardFilter()) {
            if (this._info.getCount(DAY_LIST[1]) > 0) {
                FightManager.startFightWithWild(FIGHT_INDEX_LIST[this._info.getCount(DAY_LIST[1]) - 1]);
                this.setStoneMouseEnable(true);
            } else {
                Connection.send(CommandSet.RANDOM_EVENT_1140, RANDOM_ID, 0);
            }
        } else {
            this.setStoneMouseEnable(true);
        }
    }

    private function hideLobbyMenu():void {
        (SceneManager.active as LobbyScene).hideToolbar();
        PetAvatarPanel.show();
    }

    private function stoneManActDispose():void {
        var _loc1_:MovieClip = null;
        Connection.removeCommandListener(CommandSet.RANDOM_EVENT_1140, this.onEventStart);
        if (this._numList) {
            this._numList = null;
        }
        if (this._stoneList) {
            for each(_loc1_ in this._stoneList) {
                _loc1_.removeEventListener(MouseEvent.CLICK, this.onRandom);
            }
            this._stoneList = null;
        }
    }

    override public function dispose():void {
        this.stoneManActDispose();
        super.dispose();
    }
}
}
