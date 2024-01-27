package com.taomee.seer2.app.gameRule.door {
import com.taomee.seer2.app.gameRule.door.constant.DoorType;
import com.taomee.seer2.app.gameRule.door.core.vo.DoorLevelInfomation;
import com.taomee.seer2.app.gameRule.door.support.IDoorSupport;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.net.parser.Parser_1065;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.net.LittleEndianByteArray;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.ui.toolTip.TooltipManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.SimpleButton;
import flash.events.MouseEvent;

public class BaseDoor implements IDoor {

    public static const MAX_DAILY_COUNT:uint = 5;


    protected var _entryButton:SimpleButton;

    protected var _doorName:String = "";

    protected var _doorRule:uint;

    protected var _lastDoorRule:int;

    protected var _doorType:uint = 0;

    protected var _doorEntryDailyLimit:uint = 0;

    protected var _doorEntryMaxLevel:uint = 0;

    protected var _currentLevelHistory:uint = 0;

    protected var _doorInformation:DoorLevelInfomation;

    protected var _doorTotalLevel:uint = 21;

    protected var _doorSupport:IDoorSupport;

    protected var _hasContinueButton:Boolean = true;

    protected var _doorNormalId:int;

    protected var _door50V50Id:int;

    public function BaseDoor(param1:SimpleButton, param2:uint, param3:uint) {
        super();
        this._doorType = param2;
        this._doorRule = param3;
        this._entryButton = param1;
        if (this._entryButton) {
            this._entryButton.addEventListener(MouseEvent.CLICK, this.onDoorEntryClickHandler);
            TooltipManager.addCommonTip(this._entryButton, DoorType.getDoorTip(param2, this._doorRule));
        }
    }

    public function requestEntry():void {
        this.onDoorEntryClickHandler(null);
    }

    protected function onDoorEntryClickHandler(param1:MouseEvent):void {
        this._doorInformation.getInformation(this.requestDailyLimit);
    }

    protected function requestDailyLimit():void {
        var _loc1_:LittleEndianByteArray = new LittleEndianByteArray();
        if (this._doorType == DoorType.Door_NORMAL) {
            this._doorEntryMaxLevel = this._doorInformation.getMaxLevelPVENormalHistory(this._doorRule);
            this._currentLevelHistory = this._doorInformation.getCMaxLevelPVENormalHistory(this._doorRule);
            _loc1_.writeUnsignedInt(this._doorNormalId);
        } else if (this._doorType == DoorType.Door_50V50) {
            if (this.isNoLevel()) {
                AlertManager.showAlert("您还未通关" + this._doorName + "普通模式！");
                return;
            }
            this._doorEntryMaxLevel = this._doorInformation.getMaxLevelPVEFiftyHistory(this._doorRule);
            this._currentLevelHistory = this._doorInformation.getCMaxLevelPVEFiftyHistory(this._doorRule);
            _loc1_.writeUnsignedInt(this._door50V50Id);
        }
        this._doorSupport.supportInfo.neverToMaxLevel = this._doorEntryMaxLevel >= this._doorTotalLevel;
        this._currentLevelHistory = this._currentLevelHistory < 1 ? 1 : this._currentLevelHistory;
        Connection.addCommandListener(CommandSet.DAILY_LIMIT_1065, this.onDailyLimitHandler);
        Connection.send(CommandSet.DAILY_LIMIT_1065, _loc1_);
    }

    public function isNoLevel():Boolean {
        if (this._doorInformation.getMaxLevelPVENormalHistory(this._doorRule) < this._doorTotalLevel) {
            return true;
        }
        return false;
    }

    private function onDailyLimitHandler(param1:MessageEvent):void {
        var _loc2_:uint = this._doorType == DoorType.Door_NORMAL ? uint(this._doorNormalId) : uint(this._door50V50Id);
        var _loc3_:Parser_1065 = new Parser_1065(param1.message.getRawDataCopy());
        if (_loc3_.id == _loc2_) {
            Connection.removeCommandListener(CommandSet.DAILY_LIMIT_1065, this.onDailyLimitHandler);
            this._doorEntryDailyLimit = _loc3_.count;
            this.openDoorSupportPanel();
        }
    }

    protected function openDoorSupportPanel():void {
        var _loc1_:Object = new Object();
        _loc1_["doorRule"] = this._doorRule;
        _loc1_["doorType"] = this._doorType;
        _loc1_["maxLevel"] = this._doorEntryMaxLevel;
        _loc1_["dailyLimit"] = MAX_DAILY_COUNT - this._doorEntryDailyLimit;
        _loc1_["doorSupport"] = this._doorSupport;
        _loc1_["lastDoorMaxLevel"] = this._doorInformation.getMaxLevelHistory(this._lastDoorRule);
        _loc1_["currentLevelHistory"] = this._currentLevelHistory;
        _loc1_["totalLevel"] = this._doorTotalLevel;
        _loc1_["hasContinue"] = this._hasContinueButton;
        ModuleManager.toggleModule(URLUtil.getAppModule("DoorSupportPanel"), "正在打开门战面板...", _loc1_);
    }

    public function dispose():void {
        this._entryButton.removeEventListener(MouseEvent.CLICK, this.onDoorEntryClickHandler);
        this._entryButton = null;
        this._doorInformation = null;
        this._doorEntryDailyLimit = 0;
        this._doorEntryMaxLevel = 0;
    }

    public function get doorType():uint {
        return this._doorType;
    }
}
}
