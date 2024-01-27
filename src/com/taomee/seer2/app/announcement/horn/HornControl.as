package com.taomee.seer2.app.announcement.horn {
import com.taomee.seer2.app.config.HornConfig;
import com.taomee.seer2.core.manager.GlobalsManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DateUtil;

public class HornControl {

    public static var _isShowHorn:Boolean;

    private static var _isYesInfo:Boolean;

    private static var _hornVec:Vector.<HornInfo>;

    private static var _hornInfo:HornInfo;

    private static var _horn:AbstractHorn;

    private static const MILLISECONDS_PER_SECOND:uint = 1000;

    private static var _curHour:uint;


    public function HornControl() {
        super();
    }

    public static function checkTime():void {
        var _loc1_:HornInfo = null;
        var _loc2_:uint = 0;
        var _loc3_:uint = 0;
        var _loc4_:uint = 0;
        if (_isShowHorn) {
            return;
        }
        if (SceneManager.currentSceneType == SceneType.ARENA) {
            return;
        }
        if (GlobalsManager.isPlayingGame) {
            return;
        }
        _hornVec = HornConfig.getHornInfoVec();
        _hornInfo = null;
        for each(_loc1_ in _hornVec) {
            _loc2_ = _loc1_.week;
            _loc3_ = _loc1_.time;
            _loc4_ = _loc1_.minute;
            if (DateUtil.inInDateScope(_loc2_, _loc3_, _loc4_, _loc3_, _loc4_ + 3)) {
                _hornInfo = _loc1_;
                createHorn(HornType.NORMAL_HORN);
                break;
            }
        }
    }

    private static function createHorn(param1:uint):void {
        _isShowHorn = true;
        if (param1 == HornType.NORMAL_HORN) {
            _horn = new Horn(_hornInfo);
        } else if (param1 == HornType.VIP_HORN) {
            _horn = new VipHorn(null);
        }
    }
}
}
