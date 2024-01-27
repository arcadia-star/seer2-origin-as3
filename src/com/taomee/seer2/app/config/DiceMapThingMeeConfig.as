package com.taomee.seer2.app.config {
import com.taomee.seer2.app.config.info.DiceThingInfo;
import com.taomee.seer2.app.processor.map.diceThing.DiceThingType;

import org.taomee.ds.HashMap;

public class DiceMapThingMeeConfig {

    private static var _xmlClass:Class = DiceMapThingMeeConfig__xmlClass;

    private static var _thingMap:HashMap = new HashMap();

    private static var _luckyThingNum:int;

    private static var _boxThingNum:int;

    private static var _chanceThingNum:int;

    private static var _addMoneyThingNum:int;

    private static var _subMoneyThingNum:int;

    private static var _petFightThingNum:int;

    private static var _reverseThingNum:int;

    private static var _diceMapList:Array = [];

    {
        initlize();
    }

    public function DiceMapThingMeeConfig() {
        super();
    }

    public static function get diceMapList():Array {
        return _diceMapList;
    }

    public static function get reverseThingNum():int {
        return _reverseThingNum;
    }

    public static function get luckyThingNum():int {
        return _luckyThingNum;
    }

    public static function get petFightThingNum():int {
        return _petFightThingNum;
    }

    public static function get subMoneyThingNum():int {
        return _subMoneyThingNum;
    }

    public static function get addMoneyThingNum():int {
        return _addMoneyThingNum;
    }

    public static function get chanceThingNum():int {
        return _chanceThingNum;
    }

    public static function get boxThingNum():int {
        return _boxThingNum;
    }

    public static function get thingMap():HashMap {
        return _thingMap;
    }

    private static function initlize():void {
        var _loc1_:XML = XML(new _xmlClass());
        var _loc2_:XMLList = _loc1_.descendants("maps").descendants("map");
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_.length()) {
            _diceMapList.push(uint(_loc2_[_loc3_]));
            _loc3_++;
        }
        var _loc4_:XMLList = _loc1_.descendants(DiceThingType.LUCKY_THING).descendants("thing");
        var _loc5_:XMLList = _loc1_.descendants(DiceThingType.BOX_THING).descendants("thing");
        var _loc6_:XMLList = _loc1_.descendants(DiceThingType.CHANCE_THING).descendants("thing");
        var _loc7_:XMLList = _loc1_.descendants(DiceThingType.ADDMONEY_THING).descendants("thing");
        var _loc8_:XMLList = _loc1_.descendants(DiceThingType.SUBMONEY_THING).descendants("thing");
        var _loc9_:XMLList = _loc1_.descendants(DiceThingType.FIGHT_THING).descendants("thing");
        var _loc10_:XMLList = _loc1_.descendants(DiceThingType.REVERSE_THING).descendants("thing");
        paseXml(DiceThingType.LUCKY_THING, _loc4_);
        paseXml(DiceThingType.BOX_THING, _loc5_);
        paseXml(DiceThingType.CHANCE_THING, _loc6_);
        paseXml(DiceThingType.ADDMONEY_THING, _loc7_);
        paseXml(DiceThingType.SUBMONEY_THING, _loc8_);
        paseXml(DiceThingType.FIGHT_THING, _loc9_);
        paseXml(DiceThingType.REVERSE_THING, _loc10_);
        _luckyThingNum = _loc4_.length();
        _boxThingNum = _loc5_.length();
        _chanceThingNum = _loc6_.length();
        _addMoneyThingNum = _loc7_.length();
        _subMoneyThingNum = _loc8_.length();
        _petFightThingNum = _loc9_.length();
        _reverseThingNum = _loc10_.length();
    }

    private static function paseXml(param1:String, param2:XMLList):void {
        var _loc3_:XML = null;
        var _loc4_:DiceThingInfo = null;
        var _loc5_:String = null;
        for each(_loc3_ in param2) {
            (_loc4_ = new DiceThingInfo()).type = String(param1);
            _loc4_.id = int(_loc3_.@id);
            _loc4_.strikeId = int(_loc3_.@strikeId);
            _loc4_.des = String(_loc3_.@des);
            _loc4_.stopTime = int(_loc3_.@stopTime);
            _loc4_.className = String(_loc3_.@className);
            _loc4_.fightType = String(_loc3_.@fightType);
            _loc4_.moveTile = int(_loc3_.@moveTile);
            _loc4_.moneyNum = int(_loc3_.@moneyNum);
            _loc5_ = param1 + _loc4_.id.toString();
            _thingMap.add(_loc5_, _loc4_);
        }
    }
}
}
