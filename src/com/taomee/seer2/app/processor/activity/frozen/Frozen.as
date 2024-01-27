package com.taomee.seer2.app.processor.activity.frozen {
import com.taomee.seer2.core.scene.LayerManager;

import flash.display.MovieClip;

import org.taomee.utils.DisplayUtil;

public class Frozen {


    private var _mc:MovieClip;

    private var _blood:MovieClip;

    private var _bloodList:Vector.<MovieClip>;

    private var _type:uint;

    private var _hp:uint;

    public function Frozen(param1:MovieClip) {
        this._bloodList = Vector.<MovieClip>([]);
        super();
        this._mc = param1;
        this._mc.mouseChildren = false;
        this._mc.mouseEnabled = false;
    }

    public function setType(param1:uint):void {
        this._type = param1;
    }

    public function setHp(param1:uint):void {
        this._hp = param1;
        this.resHp();
    }

    public function updateHp():void {
        --this._hp;
        this.resHp();
    }

    public function resHp():void {
        if (this._type != 3 && this._type != 4 && this._type != 5) {
            return;
        }
        if (this._blood == null) {
            FrozenStatus.getSwfContent(function ():void {
                _blood = FrozenStatus.getFrozenBlood(_type);
                LayerManager.uiLayer.addChild(_blood);
                _bloodList.push(_blood);
                _blood.gotoAndStop(int(_hp / 200));
            });
            return;
        }
        this._blood.gotoAndStop(int(this._hp / 200));
    }

    public function get hp():uint {
        return this._hp;
    }

    public function get mc():MovieClip {
        return this._mc;
    }

    public function disposeBlood():void {
        var _loc1_:MovieClip = null;
        for each(_loc1_ in this._bloodList) {
            DisplayUtil.removeForParent(_loc1_);
        }
        this._bloodList = Vector.<MovieClip>([]);
    }

    public function removeBlood():void {
        DisplayUtil.removeForParent(this._blood);
        this._blood = null;
    }
}
}
