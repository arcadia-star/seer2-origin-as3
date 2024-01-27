package com.taomee.seer2.app.popup.alert.team {
import com.taomee.seer2.app.popup.AlertInfo;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.popup.alert.IAlert;
import com.taomee.seer2.core.ui.UIManager;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

public class TeamEntryAlert extends Sprite implements IAlert {


    private var _mainUI:MovieClip;

    private var _confirmBtn:SimpleButton;

    private var _cancelBtn:SimpleButton;

    private var _closeBtn:SimpleButton;

    private var _onConfirm:Function;

    private var _onCancel:Function;

    public function TeamEntryAlert() {
        super();
        this._mainUI = UIManager.getMovieClip("UI_TeamEntryUI");
        addChild(this._mainUI);
        this._confirmBtn = this._mainUI["confirmBtn"];
        this._cancelBtn = this._mainUI["cancelBtn"];
        this._closeBtn = this._mainUI["closeBtn"];
        this._confirmBtn.addEventListener(MouseEvent.CLICK, this.onConfirmClick);
        this._cancelBtn.addEventListener(MouseEvent.CLICK, this.onCancelClick);
        this._closeBtn.addEventListener(MouseEvent.CLICK, this.onClose);
    }

    public function show(param1:AlertInfo):void {
        this._onConfirm = param1.initInfo.confirmHandler;
        this._onCancel = param1.initInfo.cancelHandler;
        AlertManager.addPopUp(param1, this);
    }

    private function onConfirmClick(param1:MouseEvent):void {
        if (this._onConfirm != null) {
            this._onConfirm();
            this._onConfirm = null;
        }
        this.dispose();
    }

    private function onCancelClick(param1:MouseEvent):void {
        if (this._onCancel != null) {
            this._onCancel();
            this._onCancel = null;
        }
        this.dispose();
    }

    private function onClose(param1:MouseEvent):void {
        this.dispose();
    }

    public function dispose():void {
        this._confirmBtn.removeEventListener(MouseEvent.CLICK, this.onConfirmClick);
        this._cancelBtn.removeEventListener(MouseEvent.CLICK, this.onCancelClick);
        this._closeBtn.removeEventListener(MouseEvent.CLICK, this.onClose);
        this._mainUI = null;
        this._confirmBtn = null;
        this._cancelBtn = null;
        this._closeBtn = null;
        this._onConfirm = null;
        this._onCancel = null;
        AlertManager.removePopUp(this);
        this.dispatchEvent(new Event(Event.CLOSE));
    }
}
}
