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

public class Alert extends Sprite implements IAlert {


    private var _ui:MovieClip;

    private var _confirmBtn:SimpleButton;

    private var _contentTxt:TextField;

    private var _closeHandler:Function;

    public function Alert() {
        super();
        this.initialize();
    }

    private function initialize():void {
        this.mouseEnabled = false;
        this._ui = UIManager.getMovieClip("UI_Alert");
        this._confirmBtn = this._ui["confirmBtn"];
        this._confirmBtn.addEventListener(MouseEvent.CLICK, this.onConfirmBtnClick);
        this._contentTxt = this._ui["contentTxt"];
        addChild(this._ui);
    }

    public function show(param1:AlertInfo):void {
        this._contentTxt.htmlText = param1.initInfo.message;
        this._closeHandler = param1.initInfo.closeHandler;
        AlertManager.addPopUp(param1, this);
    }

    public function dispose():void {
        this._closeHandler = null;
        this._ui = null;
        this._confirmBtn.removeEventListener(MouseEvent.CLICK, this.onConfirmBtnClick);
        this._confirmBtn = null;
        this._contentTxt = null;
        AlertManager.removePopUp(this);
        this.dispatchEvent(new Event(Event.CLOSE));
    }

    protected function onConfirmBtnClick(param1:MouseEvent):void {
        if (this._closeHandler != null) {
            this._closeHandler();
        }
        this.dispose();
        if (param1 != null) {
            param1.stopImmediatePropagation();
        }
    }
}
}
