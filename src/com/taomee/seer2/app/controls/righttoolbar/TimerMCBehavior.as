package com.taomee.seer2.app.controls.righttoolbar {
import flash.display.MovieClip;

public class TimerMCBehavior {


    private var _timeMC:MovieClip;

    private var _mcMinDecade:MovieClip;

    private var _mcMinUnit:MovieClip;

    private var _mcSecDecade:MovieClip;

    private var _mcSecUnit:MovieClip;

    public function TimerMCBehavior(param1:MovieClip) {
        super();
        this._timeMC = param1;
        this._mcMinDecade = this._timeMC["mcMinDecade"];
        this._mcMinUnit = this._timeMC["mcMinUnit"];
        this._mcSecDecade = this._timeMC["mcSecDecade"];
        this._mcSecUnit = this._timeMC["mcSecUnit"];
    }

    public function update(param1:uint):void {
        var _loc2_:uint = param1 / 60;
        var _loc3_:uint = param1 % 60;
        this._timeMC.visible = true;
        if (param1 == 0) {
            this._timeMC.visible = false;
        }
        this._mcMinDecade.gotoAndStop(uint(_loc2_ / 10) + 1);
        this._mcMinUnit.gotoAndStop(uint(_loc2_ % 10) + 1);
        this._mcSecDecade.gotoAndStop(uint(_loc3_ / 10) + 1);
        this._mcSecUnit.gotoAndStop(uint(_loc3_ % 10) + 1);
    }

    public function get timeMC():MovieClip {
        return this._timeMC;
    }
}
}
