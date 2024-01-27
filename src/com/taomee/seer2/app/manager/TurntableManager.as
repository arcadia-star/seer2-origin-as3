package com.taomee.seer2.app.manager {
import flash.display.MovieClip;
import flash.events.Event;

public class TurntableManager {


    private var _objectRotation:MovieClip;

    private var Jpwz:int = 6;

    private var MaxSd:int = 10;

    private var MinSd:int = 0;

    private var ASd:Number;

    private var Sd:Number = 0;

    private var RotationLong:Number;

    public function TurntableManager() {
        super();
    }

    public function init(param1:MovieClip, param2:int = 10, param3:int = 0, param4:int = 6):void {
        this._objectRotation = param1;
        this.MaxSd = param2;
        this.MinSd = param3;
        this.Jpwz = param4;
        this.RotationLong = this.getRotationLong(6, 0, 7, 10, this.Jpwz, 0.2);
        this.ASd = (this.MaxSd * this.MaxSd - this.MinSd * this.MinSd) / this.RotationLong;
        this.Sd = 0;
        this._objectRotation.rotation = 0;
    }

    public function start():void {
        this._objectRotation.frameRate = 60;
        this._objectRotation.addEventListener(Event.ENTER_FRAME, this.Onrotation);
    }

    public function over():void {
        this._objectRotation.removeEventListener(Event.ENTER_FRAME, this.Onrotation);
    }

    private function Onrotation(param1:Event):void {
        if (this.Sd >= this.MaxSd) {
            this.Sd = 2 * this.MaxSd - this.Sd;
            this.ASd = -this.ASd;
        }
        this.Sd += this.ASd;
        if (this.Sd > 0) {
            this._objectRotation.rotation += this.Sd;
        } else {
            this._objectRotation.removeEventListener(Event.ENTER_FRAME, this.Onrotation);
        }
    }

    private function getRotationLong(param1:int, param2:Number, param3:int, param4:int, param5:int, param6:Number):Number {
        var _loc7_:Number = 360 * (Math.floor(Math.random() * (param4 - param3)) + param3);
        var _loc8_:Number = 360 / param1 * param2;
        var _loc9_:Number = 360 / param1 * param5;
        var _loc10_:Number = Math.floor(Math.random() * (360 / param1) * (1 - 2 * param6)) + 360 / param1 * param6;
        return _loc7_ + _loc8_ + _loc9_ + _loc10_;
    }
}
}
