package com.taomee.seer2.app.dialog.functionality {
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.StringConstants;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldType;

import org.taomee.utils.StringUtil;

public class InputUnit extends BaseUnit {


    private var _inputMc:MovieClip;

    private var _inputTxt:TextField;

    private var _confirmBtn:SimpleButton;

    private var _confirmHandler:Function;

    public function InputUnit(param1:Function) {
        this._confirmHandler = param1;
        super();
        this.init();
    }

    private function init():void {
        this._inputMc = UIManager.getMovieClip("UI_DialogInput");
        addChild(this._inputMc);
        this._inputTxt = this._inputMc["inputTxt"];
        this._confirmBtn = this._inputMc["confirmBtn"];
        this._inputTxt.type = TextFieldType.INPUT;
        this._inputTxt.selectable = true;
        this._inputTxt.restrict = "0-9";
        this._inputTxt.addEventListener(Event.CHANGE, this.onInputChange);
        this._confirmBtn.addEventListener(MouseEvent.CLICK, this.onConfirm);
        this._inputTxt.text = "";
        this._confirmBtn.visible = false;
    }

    private function onInputChange(param1:Event):void {
        if (StringUtil.trim(this._inputTxt.text) == StringConstants.EMPTY) {
            this._confirmBtn.visible = false;
        } else {
            this._confirmBtn.visible = true;
        }
    }

    private function onConfirm(param1:MouseEvent):void {
        var _loc2_:uint = uint(this._inputTxt.text);
        this._confirmHandler(_loc2_);
        this._confirmHandler = null;
    }

    public function hide():void {
        this._inputTxt.removeEventListener(Event.CHANGE, this.onInputChange);
        this._confirmBtn.removeEventListener(MouseEvent.CLICK, this.onConfirm);
        DisplayObjectUtil.removeFromParent(this._inputMc);
    }
}
}
