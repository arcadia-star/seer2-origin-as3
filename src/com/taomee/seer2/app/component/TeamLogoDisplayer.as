package com.taomee.seer2.app.component {
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.Sprite;

public class TeamLogoDisplayer extends Sprite {


    private var _frontDisplayer:IconDisplayer;

    private var _backDisplayer:IconDisplayer;

    private var _frontData:int;

    private var _backData:int;

    private var _colorData:uint;

    private var _b:Boolean;

    public function TeamLogoDisplayer() {
        super();
        this.createDisplayer();
    }

    private function createDisplayer():void {
        this._backDisplayer = new IconDisplayer();
        this._backDisplayer.scaleX = this._backDisplayer.scaleY = 1.5;
        addChild(this._backDisplayer);
        this._frontDisplayer = new IconDisplayer();
        this._frontDisplayer.scaleX = this._frontDisplayer.scaleY = 1.5;
        addChild(this._frontDisplayer);
    }

    public function setBlack(param1:Boolean = false):void {
        this._b = param1;
    }

    public function changeFront(param1:int):void {
        if (this._frontData != param1 || this._b) {
            this._frontData = param1;
            this._frontDisplayer.setIconUrl(URLUtil.getTeamIcon("front/" + param1));
        }
    }

    public function changeBack(param1:int):void {
        if (this._backData != param1 || this._b) {
            this._backData = param1;
            this._backDisplayer.setIconUrl(URLUtil.getTeamIcon("back/" + param1), this.onLoadBackIconComplete);
        }
    }

    private function onLoadBackIconComplete():void {
        DisplayObjectUtil.changeColor(this._backDisplayer.icon, this._colorData);
    }

    public function changeColor(param1:uint):void {
        if (this._colorData != param1 || this._b) {
            this._colorData = param1;
            if (this._backDisplayer.icon) {
                DisplayObjectUtil.changeColor(this._backDisplayer.icon, this._colorData);
            }
        }
    }

    public function dispose():void {
        this._frontDisplayer.dispose();
        this._backDisplayer.dispose();
    }
}
}
