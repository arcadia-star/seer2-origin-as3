package com.taomee.seer2.app.arena.util {
import com.taomee.seer2.app.arena.ui.ButtonPanelData;
import com.taomee.seer2.core.config.ClientConfig;

import org.taomee.ds.HashMap;

public class ControlPanelUtil {

    private static var _btnSetting:Class = ControlPanelUtil__btnSetting;

    private static var _settingDatas:HashMap;


    public function ControlPanelUtil() {
        super();
    }

    public static function getSettingData(param1:uint):ButtonPanelData {
        if (_settingDatas == null) {
            _settingDatas = new HashMap();
            setup();
        }
        var _loc2_:ButtonPanelData = _settingDatas.getValue(param1);
        if (_loc2_ == null) {
            if (ClientConfig.isDebug) {
                throw new Error("没有配置\'arenaControlPanelConfig.xml\'!fightMode:[" + param1 + "]");
            }
            _loc2_ = new ButtonPanelData();
        }
        return _loc2_;
    }

    private static function setup():void {
        var _loc5_:XML = null;
        var _loc6_:ButtonPanelData = null;
        var _loc1_:XML = XML(new _btnSetting());
        var _loc2_:XMLList = _loc1_.child("mode");
        var _loc3_:uint = uint(_loc2_.length());
        var _loc4_:uint = 0;
        while (_loc4_ < _loc3_) {
            _loc5_ = _loc2_[_loc4_];
            (_loc6_ = new ButtonPanelData()).fightEnabled = uint(_loc5_.@fightEnabled) == 1 ? true : false;
            _loc6_.catchEnabled = uint(_loc5_.@catchEnabled) == 1 ? true : false;
            _loc6_.itemEnabled = uint(_loc5_.@itemEnabled) == 1 ? true : false;
            _loc6_.petEnabled = uint(_loc5_.@petEnabled) == 1 ? true : false;
            _loc6_.escapeEnabled = uint(_loc5_.@escapeEnabled) == 1 ? true : false;
            _settingDatas.add(int(_loc5_.@id), _loc6_);
            _loc4_++;
        }
    }
}
}
