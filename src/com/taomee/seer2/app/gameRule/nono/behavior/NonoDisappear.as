package com.taomee.seer2.app.gameRule.nono.behavior {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.gameRule.nono.NonoUtil;
import com.taomee.seer2.app.gameRule.nono.core.INonoBehavior;
import com.taomee.seer2.app.gameRule.nono.core.NonoInfo;
import com.taomee.seer2.core.ui.toolTip.TooltipManager;

import flash.display.SimpleButton;
import flash.events.MouseEvent;

public class NonoDisappear implements INonoBehavior {


    private var _nonoInfo:NonoInfo;

    private var _iconButton:SimpleButton;

    public function NonoDisappear(param1:NonoInfo) {
        super();
        this._nonoInfo = param1;
    }

    public function get nonoX():Number {
        return 30;
    }

    public function get nonoY():Number {
        return 0;
    }

    public function get tipDescription():String {
        return "收回";
    }

    public function get iconButton():SimpleButton {
        return this._iconButton;
    }

    public function set iconButton(param1:SimpleButton):void {
        if (this._iconButton) {
            this._iconButton.removeEventListener(MouseEvent.CLICK, this.onClick);
        }
        this._iconButton = param1;
        this._iconButton.addEventListener(MouseEvent.CLICK, this.onClick);
        TooltipManager.addCommonTip(this._iconButton, this.tipDescription);
    }

    private function onClick(param1:MouseEvent):void {
        if (this._nonoInfo == ActorManager.actorInfo.getNonoInfo()) {
            this.clickHandler();
        }
    }

    public function clickHandler():void {
        NonoUtil.hide();
    }

    public function dispose():void {
        if (this._iconButton) {
            this._iconButton.removeEventListener(MouseEvent.CLICK, this.onClick);
        }
        this._iconButton = null;
    }
}
}
