package com.taomee.seer2.app.controls.toolbar {
import com.taomee.seer2.core.ui.toolTip.TooltipManager;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;

public class ToolBarButton extends Sprite {


    protected const FRAME_ONE_NORMAL:uint = 1;

    protected const FRAME_TWO_ANIMATION:uint = 2;

    protected const FRAME_THREE_ANIMATION:uint = 3;

    protected var _button:MovieClip;

    public function ToolBarButton() {
        super();
        this.initialize();
    }

    protected function initialize():void {
        this.mouseEnabled = true;
        this.createChildren();
        this.setButtonMode();
        this.initEventListener();
        this.initTip();
    }

    protected function createChildren():void {
    }

    protected function setButtonMode():void {
        this._button.buttonMode = true;
        this._button.mouseChildren = false;
    }

    protected function initTip():void {
    }

    protected function removeTip():void {
        if (this._button != null) {
            TooltipManager.remove(this._button);
        }
    }

    protected function initEventListener():void {
        this._button.addEventListener(MouseEvent.CLICK, this.onMouseClick);
        this._button.addEventListener(MouseEvent.ROLL_OVER, this.onMouseRollOver);
        this._button.addEventListener(MouseEvent.ROLL_OUT, this.onMouseRollOut);
    }

    protected function clearEventListener():void {
        this._button.removeEventListener(MouseEvent.CLICK, this.onMouseClick);
        this._button.removeEventListener(MouseEvent.ROLL_OVER, this.onMouseRollOver);
        this._button.removeEventListener(MouseEvent.ROLL_OUT, this.onMouseRollOut);
    }

    protected function onMouseClick(param1:MouseEvent):void {
        this._button.gotoAndStop(this.FRAME_THREE_ANIMATION);
        this.excuteIteractive(param1);
        param1.stopImmediatePropagation();
    }

    protected function onMouseRollOver(param1:MouseEvent):void {
        this._button.gotoAndStop(this.FRAME_TWO_ANIMATION);
    }

    protected function onMouseRollOut(param1:MouseEvent):void {
        this._button.gotoAndStop(this.FRAME_ONE_NORMAL);
    }

    public function getName():String {
        return this._button.name;
    }

    public function getButton():MovieClip {
        return this._button;
    }

    public function setMouseEnable(param1:Boolean):void {
        this._button.mouseEnabled = param1;
        this._button.mouseChildren = param1;
    }

    protected function excuteIteractive(param1:MouseEvent):void {
    }

    public function dispose():void {
        this.clearEventListener();
        this._button = null;
    }
}
}
