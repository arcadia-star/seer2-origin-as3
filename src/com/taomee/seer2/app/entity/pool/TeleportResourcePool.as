package com.taomee.seer2.app.entity.pool {
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.MovieClip;
import flash.display.Sprite;

public class TeleportResourcePool {

    private static var _resourceVec:Vector.<Sprite>;

    private static var _dreamResourceVec:Vector.<MovieClip>;

    {
        initialize();
    }

    public function TeleportResourcePool() {
        super();
    }

    private static function initialize():void {
        _resourceVec = new Vector.<Sprite>();
        _dreamResourceVec = new Vector.<MovieClip>();
    }

    public static function checkOut():Sprite {
        if (_resourceVec.length > 0) {
            return _resourceVec.pop();
        }
        var _loc1_:Sprite = UIManager.getSprite("UI_Teleport");
        DisplayObjectUtil.disableSprite(_loc1_);
        return _loc1_;
    }

    public static function checkDreamTeleportOut():MovieClip {
        if (_dreamResourceVec.length > 0) {
            return _dreamResourceVec.pop();
        }
        var _loc1_:MovieClip = UIManager.getMovieClip("UI_DreamTeleport");
        DisplayObjectUtil.disableSprite(_loc1_);
        return _loc1_;
    }

    public static function checkIn(param1:Sprite):void {
        _resourceVec.push(param1);
    }

    public static function checkDreamTeleportIn(param1:MovieClip):void {
        _dreamResourceVec.push(param1);
    }
}
}
