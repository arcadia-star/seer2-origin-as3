package com.taomee.seer2.app.controls.widget {
import com.taomee.seer2.app.controls.widget.core.IWidgetable;
import com.taomee.seer2.app.processor.quest.Quest1InitNono;
import com.taomee.seer2.core.manager.TimeManager;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

public class YueseNonoWidgetClick extends Sprite implements IWidgetable {

    public static const YUESE_NONO:String = "yueseNono";


    private var _mainUI:MovieClip;

    private var _btn:MovieClip;

    private var _mc:MovieClip;

    public function YueseNonoWidgetClick(param1:MovieClip) {
        super();
        this._mainUI = param1;
        addChild(this._mainUI);
        this.initMC();
        this.initEventListener();
    }

    private function initMC():void {
        this._btn = this._mainUI["btn"];
        this._btn.buttonMode = true;
        this._mc = this._mainUI["mc"];
        this._mc.visible = false;
        this._mc.mouseChildren = false;
        this._mc.mouseEnabled = false;
        this._btn.gotoAndStop(1);
    }

    private function initEventListener():void {
        TimeManager.addEventListener(TimeManager.TIME_UPDATE, this.onTimeUpdate);
        this._btn.addEventListener(MouseEvent.CLICK, this.onWidgetClick);
        this._btn.addEventListener(MouseEvent.ROLL_OVER, this.onOver);
        this._btn.addEventListener(MouseEvent.ROLL_OUT, this.onOut);
    }

    private function onTimeUpdate(param1:Event):void {
        this._btn.gotoAndPlay(2);
    }

    private function onOver(param1:MouseEvent):void {
        this._mc.visible = true;
    }

    private function onOut(param1:MouseEvent):void {
        this._mc.visible = false;
    }

    private function onWidgetClick(param1:MouseEvent):void {
        Quest1InitNono.click();
    }
}
}
