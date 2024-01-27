package com.taomee.seer2.app.popup.alert {
import com.taomee.seer2.app.popup.AlertInfo;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.core.ui.UIManager;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;

public class Confirm extends Sprite implements IAlert {


    private var _ui:MovieClip;

    private var _confirmBtn:SimpleButton;

    private var _cancelBtn:SimpleButton;

    private var _contentTxt:TextField;

    private var _confirmHandler:Function;

    private var _cancelHandler:Function;

    public function Confirm() {
        super();
        this.initialize();
    }

    private function initialize():void {
        this.mouseEnabled = false;
        this._ui = UIManager.getMovieClip("UI_Confirm");
        this._confirmBtn = this._ui["confirmBtn"];
        this._confirmBtn.addEventListener(MouseEvent.CLICK, this.onConfirmBtnClick);
        this._cancelBtn = this._ui["cancelBtn"];
        this._cancelBtn.addEventListener(MouseEvent.CLICK, this.onCancelBtnClick);
        this._contentTxt = this._ui["contentTxt"];
        addChild(this._ui);
    }

    public function show(param1:AlertInfo):void {
        this._contentTxt.htmlText = param1.initInfo.message;
        this._confirmHandler = param1.initInfo.confirmHandler;
        this._cancelHandler = param1.initInfo.cancelHandler;
        AlertManager.addPopUp(param1, this);
    }

    public function dispose():void {
        this._confirmHandler = null;
        this._cancelHandler = null;
        this._ui = null;
        this._confirmBtn.removeEventListener(MouseEvent.CLICK, this.onConfirmBtnClick);
        this._cancelBtn.removeEventListener(MouseEvent.CLICK, this.onCancelBtnClick);
        this._confirmBtn = null;
        this._contentTxt = null;
        this._cancelBtn = null;
        AlertManager.removePopUp(this);
        this.dispatchEvent(new Event(Event.CLOSE));
    }

    private function onConfirmBtnClick(param1:MouseEvent):void {
        if (this._confirmHandler != null) {
            this._confirmHandler();
            this._confirmHandler = null;
        }
        this.dispose();
        param1.stopImmediatePropagation();
    }

    private function onCancelBtnClick(param1:MouseEvent):void {
        if (this._cancelHandler != null) {
            this._cancelHandler();
            this._cancelHandler = null;
        }
        this.dispose();
        param1.stopImmediatePropagation();
    }
}
}
