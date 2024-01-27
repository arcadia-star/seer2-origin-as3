package com.taomee.seer2.app.utils {
import flash.display.MovieClip;
import flash.display.Sprite;

public class NumberPlayUtil {

    public static const PATH_UP:String = "up";

    public static const PATH_DOWN:String = "down";

    public static const PATH_LEFT:String = "left";

    public static const PATH_RIGHT:String = "right";


    public function NumberPlayUtil() {
        super();
    }

    public static function playNumber(param1:String, param2:String = "UI_NumberHpIncrease", param3:String = "up", param4:int = 25):Sprite {
        return new NumMovePlay(param1, param2, param3, param4);
    }

    public static function showArtNumber(param1:Number, param2:uint, param3:MovieClip):void {
        var _loc4_:Array = (_loc4_ = String(param1).split("")).reverse();
        var _loc5_:int = 0;
        while (_loc5_ < param2) {
            if (_loc5_ < _loc4_.length) {
                param3["numMc" + _loc5_].gotoAndStop(uint(_loc4_[_loc5_]) + 1);
            } else {
                param3["numMc" + _loc5_].gotoAndStop(1);
            }
            _loc5_++;
        }
    }
}
}

import com.greensock.TweenLite;
import com.greensock.easing.Expo;
import com.taomee.seer2.core.ui.UIManager;

import flash.display.Sprite;

import org.taomee.utils.DisplayUtil;

import com.taomee.seer2.app.utils.NumberPlayUtil;

class NumMovePlay extends Sprite {


    private var _sprite:Sprite;

    public function NumMovePlay(param1:String, param2:String, param3:String, param4:int) {
        super();
        this._sprite = this.getNumDisplay(param1, param2, param3, param4);
        addChild(this._sprite);
        switch (param3) {
            case NumberPlayUtil.PATH_UP:
                TweenLite.to(this._sprite, 1, {
                    "y": -30,
                    "ease": Expo.easeOut,
                    "onComplete": this.onAnimateComplete
                });
                break;
            case NumberPlayUtil.PATH_DOWN:
                TweenLite.to(this._sprite, 3, {
                    "y": 30,
                    "ease": Expo.easeOut,
                    "onComplete": this.onAnimateComplete
                });
                break;
            case NumberPlayUtil.PATH_LEFT:
                TweenLite.to(this._sprite, 3, {
                    "x": -30,
                    "ease": Expo.easeOut,
                    "onComplete": this.onAnimateComplete
                });
                break;
            case NumberPlayUtil.PATH_RIGHT:
                TweenLite.to(this._sprite, 3, {
                    "x": 30,
                    "ease": Expo.easeOut,
                    "onComplete": this.onAnimateComplete
                });
        }
    }

    private function onAnimateComplete():void {
        TweenLite.to(this._sprite, 1, {
            "alpha": 0,
            "ease": Expo.easeOut,
            "onComplete": this.onPlayComplete
        });
    }

    private function onPlayComplete():void {
        DisplayUtil.removeForParent(this._sprite);
        this._sprite = null;
    }

    private function getNumDisplay(param1:String, param2:String, param3:String, param4:int):Sprite {
        var _loc8_:Sprite = null;
        var _loc5_:Sprite = new Sprite();
        var _loc6_:uint = uint(param1.length);
        var _loc7_:int = 0;
        while (_loc7_ < _loc6_) {
            if (param1.charAt(_loc7_) == "+") {
                _loc8_ = UIManager.getSprite(param2 + "Plus");
            } else {
                _loc8_ = UIManager.getSprite(param2 + param1.charAt(_loc7_));
            }
            _loc8_.x = _loc7_ * param4;
            _loc5_.addChild(_loc8_);
            _loc7_++;
        }
        return _loc5_;
    }
}
