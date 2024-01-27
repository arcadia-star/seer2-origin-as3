package com.taomee.seer2.core.ui {
import flash.display.Sprite;

import org.taomee.ds.HashMap;

internal class DigitSpritePool {


    private var _name:String;

    private var _availableMap:HashMap;

    private var _activeVec:Vector.<Sprite>;

    public function DigitSpritePool(param1:String) {
        super();
        this._name = param1;
        this.initialize();
    }

    private function initialize():void {
        this._availableMap = new HashMap();
        this._activeVec = new Vector.<Sprite>();
    }

    public function checkOut(param1:int):Sprite {
        return this.getDigitSprite(param1);
    }

    private function getDigitSprite(param1:int):Sprite {
        var _loc2_:Sprite = null;
        var _loc3_:Vector.<Sprite> = this.getDigitSpriteVec(param1);
        if (_loc3_.length > 0) {
            _loc2_ = _loc3_.pop();
        } else {
            _loc2_ = UIManager.getSprite(this._name + param1);
            _loc2_.name = param1.toString();
        }
        this._activeVec.push(_loc2_);
        return _loc2_;
    }

    private function getDigitSpriteVec(param1:int):Vector.<Sprite> {
        if (this._availableMap.containsKey(param1) == false) {
            this._availableMap.add(param1, new Vector.<Sprite>());
        }
        return this._availableMap.getValue(param1) as Vector.<Sprite>;
    }

    public function recycle():void {
        var _loc3_:Sprite = null;
        var _loc4_:Vector.<Sprite> = null;
        var _loc1_:int = int(this._activeVec.length);
        var _loc2_:int = _loc1_ - 1;
        while (_loc2_ >= 0) {
            _loc3_ = this._activeVec[_loc2_];
            if (_loc3_.stage == null) {
                (_loc4_ = this.getDigitSpriteVec(int(_loc3_.name))).push(_loc3_);
                this._activeVec.splice(_loc2_, 1);
            }
            _loc2_--;
        }
    }
}
}
