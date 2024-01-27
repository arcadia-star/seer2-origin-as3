package com.taomee.seer2.app.controls.widget {
import com.taomee.seer2.app.controls.widget.core.IWidgetable;
import com.taomee.seer2.core.ui.toolTip.TooltipManager;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;

public class ToolBarRadioWidget extends Sprite implements IWidgetable {

    public static const SOUND:String = "sound";

    public static const ACTOR:String = "actor";

    public static const USERUP:String = "userUp";


    private var _mc:MovieClip;

    private var _isOn:Boolean;

    private var _toggleOnTips:String;

    private var _toggleOffTips:String;

    private var _toggleOnHandler:Function;

    private var _toggleOffHandler:Function;

    public function ToolBarRadioWidget(param1:MovieClip, param2:Array, param3:Array) {
        super();
        this._mc = param1;
        this._mc.stop();
        this._mc.buttonMode = true;
        addChild(this._mc);
        this._toggleOnTips = param2[0];
        this._toggleOffTips = param2[1];
        this._toggleOnHandler = param3[0];
        this._toggleOffHandler = param3[1];
        this._mc.addEventListener(MouseEvent.CLICK, this.onClick);
    }

    private function onClick(param1:MouseEvent):void {
        this.toggle(!this._isOn);
    }

    public function toggle(param1:Boolean):void {
        this._isOn = param1;
        if (this._isOn) {
            TooltipManager.addCommonTip(this, this._toggleOffTips);
            this._mc.gotoAndStop(1);
            this._toggleOnHandler();
        } else {
            TooltipManager.addCommonTip(this, this._toggleOnTips);
            this._mc.gotoAndStop(2);
            this._toggleOffHandler();
        }
    }
}
}
