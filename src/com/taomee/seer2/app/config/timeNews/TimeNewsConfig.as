package com.taomee.seer2.app.config.timeNews {
import com.taomee.seer2.core.manager.GlobalsManager;
import com.taomee.seer2.core.utils.URLUtil;

public class TimeNewsConfig {

    private static var _xmlClass:Class = TimeNewsConfig__xmlClass;

    private static var _configXML:XML;

    public static var pageInfos:Array;

    private static var _version:String;

    {
        setup();
    }

    public function TimeNewsConfig() {
        super();
    }

    private static function setup():void {
        var _loc1_:XML = null;
        _configXML = XML(new _xmlClass());
        pageInfos = [];
        GlobalsManager.timeNewsPage = int(_configXML.@initPage);
        _version = _configXML.@version;
        for each(_loc1_ in _configXML["page"]) {
            pageInfos.push(parsePage(_loc1_));
        }
    }

    private static function parsePage(param1:XML):PageInfo {
        var _loc4_:XML = null;
        var _loc5_:Array = null;
        var _loc6_:String = null;
        var _loc7_:BtnInfo = null;
        var _loc2_:PageInfo = new PageInfo();
        _loc2_.id = param1.@id;
        _loc2_.title = param1.@title;
        _loc2_.type = param1.@title;
        _loc2_.isNew = Boolean(int(param1.@isNew));
        _loc2_.isPet = Boolean(int(param1.@isPet));
        _loc2_.petInfo = param1.@petInfo;
        _loc2_.name = param1.@name;
        _loc2_.getWay = param1.@getWay;
        _loc2_.txtColor = param1.@txtColor;
        if (_loc2_.name != "") {
            _loc2_.url = URLUtil.getTimeNews(_version, _loc2_.name + URLUtil.POSTFIX_SWF);
        } else {
            _loc2_.url = URLUtil.getTimeNews(_version, _loc2_.id.toString() + URLUtil.POSTFIX_SWF);
        }
        if (String(param1.@award) != "") {
            _loc2_.awardList = new Vector.<int>();
            _loc5_ = String(param1.@award).split(",");
            for each(_loc6_ in _loc5_) {
                _loc2_.awardList.push(int(_loc6_));
            }
        }
        var _loc3_:XMLList = param1.elements("btn");
        for each(_loc4_ in _loc3_) {
            (_loc7_ = new BtnInfo()).type = String(_loc4_.@type);
            _loc7_.tip = String(_loc4_.@tip);
            _loc7_.content = _loc4_.toString();
            _loc2_.btnInfos.push(_loc7_);
        }
        return _loc2_;
    }

    public static function get version():String {
        return _version;
    }

    public static function getPageInfo(param1:uint = 0, param2:String = ""):PageInfo {
        var _loc3_:PageInfo = null;
        for each(_loc3_ in pageInfos) {
            if (param1 != 0) {
                if (_loc3_.id == param1) {
                    return _loc3_;
                }
            }
            if (param2 != "") {
                if (_loc3_.name == param2) {
                    return _loc3_;
                }
            }
        }
        return null;
    }
}
}
