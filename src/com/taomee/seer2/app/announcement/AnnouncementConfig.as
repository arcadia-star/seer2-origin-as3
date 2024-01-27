package com.taomee.seer2.app.announcement {
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.utils.DateUtil;

import org.taomee.ds.HashMap;

public class AnnouncementConfig {

    private static var _xmlClass:Class = AnnouncementConfig__xmlClass;

    private static var _announcementXML:XML;

    private static var _announcementMap:HashMap;

    {
        setup();
    }

    public function AnnouncementConfig() {
        super();
    }

    private static function setup():void {
        var _loc2_:AnnouncementInfo = null;
        var _loc3_:XML = null;
        _announcementMap = new HashMap();
        _announcementXML = XML(new _xmlClass());
        var _loc1_:XMLList = _announcementXML.descendants("announcement");
        for each(_loc3_ in _loc1_) {
            _loc2_ = new AnnouncementInfo();
            _loc2_.serverId = int(_loc3_.attribute("id"));
            _loc2_.day = int(_loc3_.attribute("day"));
            _loc2_.content = String(_loc3_.attribute("content"));
            _loc2_.frequency = String(_loc3_.attribute("frequency"));
            _announcementMap.add(_loc2_.serverId, _loc2_);
        }
    }

    public static function getAnnouncementInfo(param1:int):AnnouncementInfo {
        if (_announcementMap.containsKey(param1)) {
            return _announcementMap.getValue(param1);
        }
        return null;
    }

    public static function getAnnouncementInfoList():Array {
        var _loc8_:AnnouncementInfo = null;
        var _loc1_:uint = uint(TimeManager.getServerTime());
        var _loc2_:String = String(DateUtil.formatCalendarWithWeekHourMinuteSecond(_loc1_));
        var _loc3_:Array = _loc2_.split("-");
        var _loc4_:Array = _announcementMap.getValues();
        var _loc5_:Array = [];
        var _loc6_:Array = [];
        var _loc7_:Array = [];
        for each(_loc8_ in _loc4_) {
            if (_loc8_.day == 5) {
                _loc5_.push(_loc8_);
            } else if (_loc8_.day == 6) {
                _loc6_.push(_loc8_);
            } else if (_loc8_.day == 7) {
                _loc7_.push(_loc8_);
            }
        }
        if (int(_loc3_[0]) == 5) {
            return _loc5_;
        }
        if (int(_loc3_[0]) == 6) {
            return _loc6_;
        }
        return _loc7_;
    }
}
}
