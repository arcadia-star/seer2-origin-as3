package com.taomee.seer2.app.popup.alert {
import com.taomee.seer2.app.popup.AlertInfo;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.core.ui.UIManager;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

public class FishingStartAlert extends Sprite implements IAlert {


    private var _ui:MovieClip;

    private var _confirmBtn:SimpleButton;

    private var _closeBtn:SimpleButton;

    private var _confirmHandler:Function;

    private var _closeHandler:Function;

    public function FishingStartAlert() {
        super();
        this.mouseEnabled = false;
        this._ui = UIManager.getMovieClip("UI_FishingStart");
        this._confirmBtn = this._ui["startBtn"];
        this._confirmBtn.addEventListener(MouseEvent.CLICK, this.onConfirmBtnClick);
        this._closeBtn = this._ui["closeBtn"];
        this._closeBtn.addEventListener(MouseEvent.CLICK, this.onCancelBtnClick);
        addChild(this._ui);
    }

    private function onCancelBtnClick(param1:MouseEvent):void {
        if (this._closeHandler != null) {
            this._closeHandler();
            this._closeHandler = null;
        }
        this.dispose();
        param1.stopImmediatePropagation();
    }

    private function onConfirmBtnClick(param1:MouseEvent):void {
        if (this._confirmHandler != null) {
            this._confirmHandler();
            this._confirmHandler = null;
        }
        this.dispose();
        param1.stopImmediatePropagation();
    }

    public function show(param1:AlertInfo):void {
        this._confirmHandler = param1.initInfo.confirmHandler;
        this._closeHandler = param1.initInfo.cancelHandler;
        AlertManager.addPopUp(param1, this);
    }

    public function dispose():void {
        this._confirmHandler = null;
        this._closeHandler = null;
        this._ui = null;
        this._confirmBtn.removeEventListener(MouseEvent.CLICK, this.onConfirmBtnClick);
        this._closeBtn.removeEventListener(MouseEvent.CLICK, this.onCancelBtnClick);
        this._confirmBtn = null;
        this._closeBtn = null;
        AlertManager.removePopUp(this);
        this.dispatchEvent(new Event(Event.CLOSE));
    }
}
}
