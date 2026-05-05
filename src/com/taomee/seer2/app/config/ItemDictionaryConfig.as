package com.taomee.seer2.app.config {
import com.taomee.seer2.app.starMagic.StarInfo;

public class ItemDictionaryConfig {

    private static var _xmlClass:Class = ItemDictionaryConfig__xmlClass;

    private static var _itemDictionaryConfigXML:XML;

    private static var _starInfoVec:Vector.<StarInfo>;

    {
        initialize();
    }
    public function ItemDictionaryConfig() {
        super();
    }

    private static function initialize():void {
        _itemDictionaryConfigXML = XML(new _xmlClass);
        _starInfoVec = new Vector.<StarInfo>();
        var star:StarInfo = null;
        var xml:XML = null;
        var list:XMLList = _itemDictionaryConfigXML.descendants("star");
        var _loc4_:String = null;
        var _loc5_:uint = 0;
        var _loc6_:String = null;
        var _loc7_:String = null;
        var _loc8_:String = null;
        var _loc9_:String = null;
        var _loc10_:String = null;
        var _loc11_:String = null;
        var _loc12_:String = null;
        var _loc14_:String = null;
        var _loc15_:Array = null;
        var _loc16_:Array = null;
        var _loc17_:int = 0;
        var _loc18_:String = null;
        for each(xml in list) {
            star = new StarInfo();
            _loc4_ = String(xml.attribute("type"));
            _loc5_ = uint(xml.attribute("max_lvl"));
            _loc6_ = String(xml.attribute("name"));
            _loc7_ = String(xml.attribute("value"));
            _loc8_ = String(xml.attribute("lvl_cof"));
            _loc9_ = String(xml.attribute("index"));
            _loc10_ = String(xml.attribute("desc"));
            _loc11_ = String(xml.attribute("needExp"));
            _loc12_ = String(xml.attribute("effdesc"));
            _loc14_ = String(xml.attribute("effv"));
            _loc18_ = String(xml.attribute("itemIcon"));
            _loc15_ = _loc11_.split(",");
            star.id = int(_loc9_);
            star.buffId = int(_loc9_);
            star.level_cof = int(_loc8_);
            star.maxLevel = int(_loc5_);
            star.sell_exp = int(_loc7_);
            star.type = int(_loc4_);
            star.nameT = _loc6_;
            star.nextExpArr = _loc15_;
            star.effdesc = _loc12_;
            star.desc = _loc10_.split(";");
            star.itemIcon = int(_loc18_);
            _loc15_ = _loc14_.split(";");
            _loc16_ = [];
            _loc17_ = 0;
            while (_loc17_ < _loc15_.length) {
                _loc16_.push(_loc15_[_loc17_].split(","));
                _loc17_++;
            }
            star.effvalue = _loc16_;
            _starInfoVec.push(star);
        }
        //TODO:只做了星魂部分，道具和BUFF需要之后实现
    }

    public static function getStarInfoVec():Vector.<StarInfo> {
        if (_starInfoVec.length < 1) {
            return null;
        }
        return _starInfoVec;
    }
}
}
