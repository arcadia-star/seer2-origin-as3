package com.taomee.seer2.app.popup.alert {
import com.taomee.seer2.app.component.IconDisplayer;
import com.taomee.seer2.app.popup.AlertInfo;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;

public class CoinsGainedAlert extends Sprite implements IAlert {


    private var _ui:MovieClip;

    private var _iconHolder:MovieClip;

    private var _nameTxt:TextField;

    private var _contentTxt:TextField;

    private var _confirmBtn:SimpleButton;

    private var _iconDisplay:IconDisplayer;

    private var _closeHandler:Function;

    private var _quantity:uint;

    public function CoinsGainedAlert() {
        super();
        this.initialize();
    }

    public function show(param1:AlertInfo):void {
        this._quantity = param1.initInfo.quantity;
        this._closeHandler = param1.initInfo.closeHandler;
        this.displayMessage();
        AlertManager.addPopUp(param1, this);
    }

    public function dispose():void {
        this._closeHandler = null;
        this._ui = null;
        this._confirmBtn.removeEventListener(MouseEvent.CLICK, this.onConfirmBtnClick);
        this._confirmBtn = null;
        this._contentTxt = null;
        this._iconDisplay = null;
        this._iconHolder = null;
        this._nameTxt = null;
        AlertManager.removePopUp(this, false);
        this.dispatchEvent(new Event(Event.CLOSE));
    }

    private function initialize():void {
        this.mouseEnabled = false;
        this._ui = UIManager.getMovieClip("UI_ItemGainedAlert");
        this._confirmBtn = this._ui["confirmBtn"];
        this._confirmBtn.addEventListener(MouseEvent.CLICK, this.onConfirmBtnClick);
        this._nameTxt = this._ui["nameTxt"];
        this._contentTxt = this._ui["contentTxt"];
        this._iconDisplay = new IconDisplayer();
        this._iconDisplay.setBoundary(60, 60);
        this._ui["iconBG"].addChild(this._iconDisplay);
        addChild(this._ui);
    }

    private function onConfirmBtnClick(param1:MouseEvent):void {
        if (this._closeHandler != null) {
            this._closeHandler();
            this._closeHandler = null;
        }
        this.dispose();
        param1.stopImmediatePropagation();
    }

    private function displayMessage():void {
        var _loc1_:String = String(URLUtil.getCoinsIcon());
        this._nameTxt.text = "赛尔豆";
        this._iconDisplay.setIconUrl(_loc1_);
        this._contentTxt.text = "x" + this._quantity + ",已经放入你的背包。";
    }
}
}
