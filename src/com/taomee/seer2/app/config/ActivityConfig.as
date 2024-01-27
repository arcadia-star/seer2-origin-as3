package com.taomee.seer2.app.config {
import com.taomee.seer2.app.activity.data.ActivityDefinition;
import com.taomee.seer2.app.activity.data.ActivityPetDefinition;

import org.taomee.ds.HashMap;

public class ActivityConfig {

    private static var _xmlClass:Class = ActivityConfig__xmlClass;

    private static var _configXML:XML;

    private static var _timeActivityMap:HashMap;

    private static var _timelessActivityMap:HashMap;

    private static var _activityPetMap:HashMap;

    private static var _activityProcessorMap:HashMap;

    {
        initialize();
    }

    public function ActivityConfig() {
        super();
    }

    private static function initialize():void {
        _timeActivityMap = new HashMap();
        _timelessActivityMap = new HashMap();
        _activityPetMap = new HashMap();
        _activityProcessorMap = new HashMap();
        setup();
    }

    private static function setup():void {
        var _loc2_:XML = null;
        _configXML = XML(new _xmlClass());
        var _loc1_:XMLList = _configXML.descendants("activity");
        for each(_loc2_ in _loc1_) {
            initActivityPet(_loc2_);
            initActivityDefinition(_loc2_);
        }
    }

    private static function initActivityPet(param1:XML):void {
        var _loc3_:XML = null;
        var _loc4_:uint = 0;
        var _loc5_:String = null;
        var _loc6_:Array = null;
        var _loc7_:XML = null;
        var _loc2_:XMLList = param1.descendants("activityPet");
        for each(_loc3_ in _loc2_) {
            _loc4_ = uint(_loc3_.@id);
            _loc5_ = _loc3_.@name;
            _loc6_ = new Array();
            for each(_loc7_ in _loc3_.descendants("slogan")) {
                _loc6_.push(String(_loc7_.@value));
            }
            addActivityPetDefinition(_loc4_, _loc5_, _loc6_);
        }
    }

    private static function initActivityDefinition(param1:XML):void {
        var _loc2_:uint = uint(param1.@ID);
        var _loc3_:String = param1.@processor;
        addActivityProcessor(_loc2_, _loc3_);
        var _loc4_:String = param1.@name;
        var _loc5_:int;
        if ((_loc5_ = int(param1.@circleType)) == -1) {
            addTimelessActivity(_loc2_, _loc4_, _loc5_);
        } else {
            addTimeActivity(_loc2_, _loc4_, _loc5_, param1);
        }
    }

    private static function addTimelessActivity(param1:uint, param2:String, param3:int):void {
        _timelessActivityMap.add(param1, new ActivityDefinition(param1, param2, param3, null, null, null));
    }

    private static function addTimeActivity(param1:uint, param2:String, param3:int, param4:XML):void {
        var _loc10_:XML = null;
        var _loc11_:String = null;
        var _loc12_:String = null;
        var _loc13_:Array = null;
        var _loc14_:String = null;
        var _loc5_:String;
        _loc5_ = param4.@circleDate;
        _loc5_ = _loc5_.replace(/ /g, "");
        var _loc6_:Array = _loc5_.split(",");
        var _loc7_:Array = new Array();
        var _loc8_:Array = new Array();
        var _loc9_:XMLList = param4.descendants("phase");
        for each(_loc10_ in _loc9_) {
            _loc12_ = String(_loc10_.@value);
            _loc13_ = (_loc12_ = _loc12_.replace(/ /g, "")).split(",");
            for each(_loc11_ in _loc13_) {
                _loc7_.push(_loc11_);
            }
            _loc14_ = _loc10_.@detail;
            _loc13_ = (_loc14_ = _loc14_.replace(/ /g, "")).split(",");
            for each(_loc11_ in _loc13_) {
                _loc8_.push(_loc11_);
            }
        }
        addTimeActivityDefinition(param1, param2, param3, _loc6_, _loc8_, _loc7_);
    }

    private static function addActivityProcessor(param1:uint, param2:String):void {
        _activityProcessorMap.add(param1, param2);
    }

    private static function addTimeActivityDefinition(param1:uint, param2:String, param3:int, param4:Array, param5:Array, param6:Array):void {
        _timeActivityMap.add(param1, new ActivityDefinition(param1, param2, param3, param4, param5, param6));
    }

    public static function getInprogressActivityVec():Vector.<ActivityDefinition> {
        var _loc3_:ActivityDefinition = null;
        var _loc1_:Vector.<ActivityDefinition> = new Vector.<ActivityDefinition>();
        var _loc2_:Vector.<ActivityDefinition> = Vector.<ActivityDefinition>(_timeActivityMap.getValues());
        for each(_loc3_ in _loc2_) {
            if (_loc3_.isEnterable()) {
                _loc1_.push(_loc3_);
            }
        }
        return _loc1_;
    }

    public static function getTimelessActivityVec():Vector.<ActivityDefinition> {
        return Vector.<ActivityDefinition>(_timelessActivityMap.getValues());
    }

    public static function getActivityProcessorName(param1:uint):String {
        if (_activityProcessorMap.containsKey(param1)) {
            return _activityProcessorMap.getValue(param1);
        }
        return null;
    }

    public static function getActivityById(param1:uint):ActivityDefinition {
        if (_timeActivityMap.containsKey(param1)) {
            return _timeActivityMap.getValue(param1);
        }
        return null;
    }

    private static function addActivityPetDefinition(param1:uint, param2:String, param3:Array):void {
        _activityPetMap.add(param1, new ActivityPetDefinition(param1, param2, param3));
    }

    public static function getActivityPetDefinition(param1:int):ActivityPetDefinition {
        if (_activityPetMap.containsKey(param1)) {
            return _activityPetMap.getValue(param1) as ActivityPetDefinition;
        }
        return null;
    }
}
}
