package com.taomee.seer2.app.config {
import com.taomee.seer2.app.config.info.EquipElementInfo;

import org.taomee.ds.HashMap;

public class EquipElementConfig {

    private static var _xmlClass:Class = EquipElementConfig__xmlClass;

    private static var _xml:XML;

    private static var _mapList:Vector.<HashMap> = Vector.<HashMap>([]);

    private static var _itemMapList:Vector.<HashMap> = Vector.<HashMap>([]);

    {
        setup();
    }

    public function EquipElementConfig() {
        super();
    }

    public static function setup():void {
        var _loc2_:EquipElementInfo = null;
        var _loc3_:XML = null;
        var _loc4_:String = null;
        var _loc5_:Array = null;
        var _loc6_:Array = null;
        var _loc7_:int = 0;
        var _loc8_:String = null;
        var _loc9_:String = null;
        var _loc10_:uint = 0;
        var _loc11_:String = null;
        var _loc12_:uint = 0;
        var _loc13_:String = null;
        var _loc14_:Array = null;
        var _loc15_:Array = null;
        var _loc16_:int = 0;
        var _loc17_:String = null;
        var _loc18_:HashMap = null;
        var _loc19_:int = 0;
        var _loc20_:HashMap = null;
        var _loc21_:int = 0;
        _xml = XML(new _xmlClass());
        var _loc1_:XMLList = _xml.descendants("equip");
        for each(_loc3_ in _loc1_) {
            _loc2_ = new EquipElementInfo();
            _loc5_ = (_loc4_ = String(_loc3_.attribute("idList"))).split(",");
            _loc6_ = [];
            _loc7_ = 0;
            while (_loc7_ < _loc5_.length) {
                _loc6_.push(uint(_loc5_[_loc7_]));
                _loc7_++;
            }
            _loc8_ = String(_loc3_.attribute("elementType"));
            _loc9_ = String(_loc3_.attribute("elementCount"));
            _loc10_ = uint(_loc3_.attribute("equipIcon"));
            _loc11_ = String(_loc3_.attribute("itemIdList"));
            _loc12_ = uint(_loc3_.attribute("levelMax"));
            _loc13_ = String(_loc3_.attribute("nextObj"));
            _loc14_ = _loc11_.split(",");
            _loc15_ = [];
            _loc16_ = 0;
            while (_loc16_ < _loc14_.length) {
                _loc15_.push(uint(_loc14_[_loc16_]));
                _loc16_++;
            }
            _loc17_ = String(_loc3_.attribute("obj"));
            _loc2_.idVec = Vector.<uint>(_loc6_);
            _loc2_.elementCount = updateCount(_loc9_);
            _loc2_.equipIcon = _loc10_;
            _loc2_.elementType = updateType(_loc8_);
            _loc2_.itemVec = Vector.<uint>(_loc15_);
            _loc2_.nextObj = _loc13_;
            _loc2_.levelMax = _loc12_;
            _loc2_.obj = _loc17_;
            _loc18_ = new HashMap();
            _loc19_ = 0;
            while (_loc19_ < _loc2_.idVec.length) {
                _loc18_.add(_loc2_.idVec[_loc19_], _loc2_);
                _loc19_++;
            }
            _mapList.push(_loc18_);
            _loc20_ = new HashMap();
            _loc21_ = 0;
            while (_loc21_ < _loc2_.itemVec.length) {
                _loc20_.add(_loc2_.itemVec[_loc21_], _loc2_);
                _loc21_++;
            }
            _itemMapList.push(_loc20_);
        }
    }

    private static function updateCount(param1:String):Array {
        var _loc3_:Array = null;
        var _loc6_:Array = null;
        var _loc7_:int = 0;
        var _loc2_:Array = param1.split("|");
        var _loc4_:Array = [];
        var _loc5_:int = 0;
        while (_loc5_ < _loc2_.length) {
            _loc3_ = String(_loc2_[_loc5_]).split(",");
            _loc6_ = [];
            _loc7_ = 0;
            while (_loc7_ < _loc3_.length) {
                _loc6_.push(Number(_loc3_[_loc7_]));
                _loc7_++;
            }
            _loc4_.push(_loc6_);
            _loc5_++;
        }
        return _loc4_;
    }

    private static function updateType(param1:String):Array {
        var _loc3_:Array = null;
        var _loc6_:Array = null;
        var _loc7_:int = 0;
        var _loc2_:Array = param1.split("|");
        var _loc4_:Array = [];
        var _loc5_:int = 0;
        while (_loc5_ < _loc2_.length) {
            _loc3_ = String(_loc2_[_loc5_]).split(",");
            _loc6_ = [];
            _loc7_ = 0;
            while (_loc7_ < _loc3_.length) {
                _loc6_.push(uint(_loc3_[_loc7_]));
                _loc7_++;
            }
            _loc4_.push(_loc6_);
            _loc5_++;
        }
        return _loc4_;
    }

    public static function getInfo(param1:uint):EquipElementInfo {
        var _loc2_:HashMap = null;
        for each(_loc2_ in _mapList) {
            if (_loc2_.containsKey(param1)) {
                return _loc2_.getValue(param1);
            }
        }
        return null;
    }

    public static function getItemInfo(param1:uint):EquipElementInfo {
        var _loc2_:HashMap = null;
        for each(_loc2_ in _itemMapList) {
            if (_loc2_.containsKey(param1)) {
                return _loc2_.getValue(param1);
            }
        }
        return null;
    }
}
}
