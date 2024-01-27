package com.taomee.seer2.app.activity.onlineReward {
public class Nono1122Info {

    private static var _instance:Nono1122Info;


    private var _isVipReward:uint;

    private var _totalVipTime:uint;

    private var _whichStage:uint;

    private var _resideTime:uint;

    public function Nono1122Info() {
        super();
    }

    public static function instance():Nono1122Info {
        if (!_instance) {
            _instance = new Nono1122Info();
        }
        return _instance;
    }

    public function set isVipReward(param1:uint):void {
        this._isVipReward = param1;
    }

    public function get isVipReward():uint {
        return this._isVipReward;
    }

    public function set totalVipTime(param1:uint):void {
        this._totalVipTime = param1;
    }

    public function get totalVipTime():uint {
        return this._totalVipTime;
    }

    public function set whichStage(param1:uint):void {
        this._whichStage = param1;
    }

    public function get whichStage():uint {
        return this._whichStage;
    }

    public function set resideTime(param1:uint):void {
        this._resideTime = param1;
    }

    public function get resideTime():uint {
        return this._resideTime;
    }
}
}
