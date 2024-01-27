package com.taomee.seer2.app.lobby.effect {
import com.taomee.seer2.core.ui.UIManager;

import flash.display.MovieClip;
import flash.events.Event;

public class StageClickEffectPool {

    private static var _poolVec:Vector.<MovieClip>;

    private static var _activeVec:Vector.<MovieClip>;

    {
        initialize();
    }

    public function StageClickEffectPool() {
        super();
    }

    private static function initialize():void {
        _poolVec = new Vector.<MovieClip>();
        _activeVec = new Vector.<MovieClip>();
    }

    public static function checkOut(param1:int, param2:int):MovieClip {
        var _loc3_:MovieClip = null;
        if (_poolVec.length > 0) {
            _loc3_ = _poolVec.pop();
        } else {
            _loc3_ = UIManager.getMovieClip("UI_StageClickEffect");
            _loc3_.mouseEnabled = false;
            _loc3_.mouseChildren = false;
        }
        _loc3_.x = param1;
        _loc3_.y = param2;
        _loc3_.addEventListener(Event.ENTER_FRAME, onEffectPlay);
        _loc3_.play();
        _activeVec.push(_loc3_);
        return _loc3_;
    }

    private static function onEffectPlay(param1:Event):void {
        var _loc2_:MovieClip = param1.target as MovieClip;
        if (_loc2_.currentFrame == _loc2_.totalFrames) {
            _loc2_.removeEventListener(Event.ENTER_FRAME, onEffectPlay);
            _loc2_.stop();
            checkIn(_loc2_);
        }
    }

    private static function checkIn(param1:MovieClip):void {
        var _loc2_:int = int(_activeVec.length);
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_) {
            if (_activeVec[_loc3_] == param1) {
                _activeVec.splice(_loc3_, 1);
                break;
            }
            _loc3_++;
        }
        _poolVec.push(param1);
    }
}
}
