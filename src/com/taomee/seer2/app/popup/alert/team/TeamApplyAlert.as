package com.taomee.seer2.app.popup.alert.team {
import com.taomee.seer2.app.popup.AlertInfo;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.popup.alert.IAlert;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.utils.ByteArray;

import org.taomee.utils.DisplayUtil;

public class TeamApplyAlert extends Sprite implements IAlert {


    private var _mainUI:MovieClip;

    private var _applicantNickTxt:TextField;

    private var _trainerLvTxt:TextField;

    private var _petCategoryCountTxt:TextField;

    private var _highestPetLvTxt:TextField;

    private var _killSptCountTxt:TextField;

    private var _medalCountTxt:TextField;

    private var _confirmBtn:SimpleButton;

    private var _cancelBtn:SimpleButton;

    private var _infoBtn:SimpleButton;

    private var _msgTxt:TextField;

    private var _onConfirm:Function;

    private var _onCancel:Function;

    private var _userID:int;

    private var _rejectStr:String = "";

    private var _rejectUI:MovieClip;

    public function TeamApplyAlert() {
        super();
        this._mainUI = UIManager.getMovieClip("UI_TeamApplyNoticeViewUI");
        addChild(this._mainUI);
        this.createChildren();
        this.initEventListener();
    }

    private function createChildren():void {
        this._confirmBtn = this._mainUI["confirmBtn"];
        this._cancelBtn = this._mainUI["cancelBtn"];
        this._applicantNickTxt = this._mainUI["nickTxt"];
        this._trainerLvTxt = this._mainUI["trainerLvTxt"];
        this._petCategoryCountTxt = this._mainUI["petCategoryCountTxt"];
        this._highestPetLvTxt = this._mainUI["highestPetLvTxt"];
        this._killSptCountTxt = this._mainUI["killSptCountTxt"];
        this._medalCountTxt = this._mainUI["medalCountTxt"];
        this._infoBtn = this._mainUI["infoBtn"];
        this._msgTxt = this._mainUI["msgTxt"];
    }

    private function initEventListener():void {
        this._infoBtn.addEventListener(MouseEvent.CLICK, this.onInfo);
        this._confirmBtn.addEventListener(MouseEvent.CLICK, this.onConfirmClick);
        this._cancelBtn.addEventListener(MouseEvent.CLICK, this.onCancelClick);
        this._mainUI.addEventListener(MouseEvent.MOUSE_DOWN, function ():void {
            _mainUI.startDrag();
        });
        this._mainUI.addEventListener(MouseEvent.MOUSE_UP, function ():void {
            _mainUI.stopDrag();
        });
    }

    public function show(param1:AlertInfo):void {
        this.update(param1);
        this._onConfirm = param1.initInfo.confirmHandler;
        this._onCancel = param1.initInfo.cancelHandler;
        AlertManager.addPopUp(param1, this);
    }

    private function update(param1:AlertInfo):void {
        var _loc2_:Array = param1.initInfo.message.split("_");
        this._applicantNickTxt.text = _loc2_[1];
        this._trainerLvTxt.text = param1.initInfo.teamInfo.id.toString();
        this._petCategoryCountTxt.text = param1.initInfo.teamInfo.logoFront.toString();
        this._highestPetLvTxt.text = param1.initInfo.teamInfo.logoBack.toString();
        this._killSptCountTxt.text = param1.initInfo.teamInfo.logoColor.toString();
        this._medalCountTxt.text = _loc2_[0];
        this._msgTxt.text = param1.initInfo.teamInfo.msg;
        this._userID = int(_loc2_[2]);
    }

    public function dispose():void {
        if (this._rejectUI == null) {
            this._rejectUI.removeEventListener(MouseEvent.CLICK, this.onClick);
            DisplayUtil.removeForParent(this._rejectUI);
            this._rejectUI = null;
        }
        this._infoBtn.removeEventListener(MouseEvent.CLICK, this.onInfo);
        this._confirmBtn.removeEventListener(MouseEvent.CLICK, this.onConfirmClick);
        this._cancelBtn.removeEventListener(MouseEvent.CLICK, this.onCancelClick);
        this._mainUI = null;
        this._applicantNickTxt = null;
        this._trainerLvTxt = null;
        this._petCategoryCountTxt = null;
        this._highestPetLvTxt = null;
        this._killSptCountTxt = null;
        this._medalCountTxt = null;
        this._confirmBtn = null;
        this._cancelBtn = null;
        this._onConfirm = null;
        this._onCancel = null;
        this._infoBtn = null;
        AlertManager.removePopUp(this);
        this.dispatchEvent(new Event(Event.CLOSE));
    }

    private function onInfo(param1:MouseEvent):void {
        ModuleManager.showModule(URLUtil.getAppModule("UserPanel"), "正在打开个人信息面板...", this._userID);
    }

    private function onConfirmClick(param1:MouseEvent):void {
        if (this._onConfirm != null) {
            this._onConfirm();
            this._onConfirm = null;
        }
        this.dispose();
    }

    private function reject(param1:MouseEvent = null):void {
        if (this._onCancel != null) {
            this._onCancel(this._rejectStr);
            this._onCancel = null;
        }
        this.dispose();
    }

    private function onCancelClick(param1:MouseEvent):void {
        if (this._rejectUI == null) {
            this._rejectUI = UIManager.getMovieClip("rejectPanelUI");
            this._rejectUI.addEventListener(MouseEvent.CLICK, this.onClick);
        }
        addChild(this._rejectUI);
        this._mainUI.mouseChildren = this._mainUI.mouseEnabled = false;
    }

    private function onClick(param1:MouseEvent):void {
        var _loc2_:ByteArray = null;
        switch (param1.target.name) {
            case "confirmBtn2":
                this._rejectStr = String(this._rejectUI.inputTxt.text);
                _loc2_ = new ByteArray();
                _loc2_.writeUTFBytes(this._rejectStr);
                _loc2_.position = 0;
                if (_loc2_.length >= 60) {
                    AlertManager.showAlert("你输入的信息太长了哦！");
                    return;
                }
                this.reject();
                break;
            case "cancelBtn2":
                DisplayUtil.removeForParent(this._rejectUI);
                this._mainUI.mouseChildren = this._mainUI.mouseEnabled = true;
        }
    }
}
}
