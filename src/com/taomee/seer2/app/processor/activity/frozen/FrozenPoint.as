package com.taomee.seer2.app.processor.activity.frozen {
import flash.display.MovieClip;

public class FrozenPoint {


    private var _mc:MovieClip;

    private var _thisMc:MovieClip;

    public var status:Boolean;

    public var serverStatus:Boolean;

    public function FrozenPoint(param1:MovieClip, param2:MovieClip) {
        super();
        this._mc = param1;
        this._mc.mouseEnabled = false;
        this._mc.mouseChildren = false;
        this._thisMc = param2;
        this._thisMc.mouseEnabled = false;
        this._thisMc.mouseChildren = false;
    }

    public function get mc():MovieClip {
        return this._mc;
    }

    public function get thisMc():MovieClip {
        return this._thisMc;
    }
}
}
