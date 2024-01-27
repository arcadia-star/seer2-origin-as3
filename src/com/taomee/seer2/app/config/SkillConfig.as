package com.taomee.seer2.app.config {
import com.taomee.seer2.app.config.skill.HideSkillDefinition;
import com.taomee.seer2.app.config.skill.SkillDefinition;

import org.taomee.ds.HashMap;

import seer2.next.entry.DynConfig;

public class SkillConfig {

    private static var _movesXmlClass:Class = SkillConfig__movesXmlClass;

    private static var _movesConfigXML:XML;

    private static var _hideMovesXmlClass:Class = SkillConfig__hideMovesXmlClass;

    private static var _hideMovesConfigXML:XML;

    private static var _skillMap:HashMap;

    private static var _hideSkillMap:HashMap;

    {
        initialize();
    }

    public function SkillConfig() {
        super();
    }

    private static function initialize():void {
        _skillMap = new HashMap();
        _hideSkillMap = new HashMap();
        setup();
    }

    private static function setup():void {
        _movesConfigXML = DynConfig.movesConfigXML || XML(new _movesXmlClass());
        _hideMovesConfigXML = XML(new _hideMovesXmlClass());
        parseNormalSklls(_movesConfigXML);
        parseHideSklls(_hideMovesConfigXML);
    }

    private static function parseHideSklls(param1:XML):void {
        var _loc3_:XML = null;
        var _loc2_:XMLList = param1.descendants("HideMove");
        for each(_loc3_ in _loc2_) {
            parseHideSkill(_loc3_);
        }
    }

    private static function parseHideSkill(param1:XML):void {
        var _loc2_:uint = uint(param1.@ID);
        var _loc3_:String = param1.@Tips;
        addHideSkillDefinition(_loc2_, _loc3_);
    }

    private static function parseSkill(param1:XML):void {
        var _loc2_:String = "";
        var _loc3_:uint = uint(param1.@ID);
        var _loc4_:String = param1.@Name;
        var _loc5_:uint = uint(param1.@Category);
        var _loc6_:uint = uint(param1.@Type);
        var _loc7_:uint = uint(param1.@Anger);
        var _loc8_:uint = uint(param1.@Power);
        var _loc9_:String = param1.@Tips;
        addSkillDefinition(_loc3_, _loc4_, _loc5_, _loc6_, _loc7_, _loc8_, _loc9_);
    }

    public static function parseNormalSklls(param1:XML):void {
        var _loc3_:XML = null;
        var _loc2_:XMLList = param1.descendants("Move");
        for each(_loc3_ in _loc2_) {
            parseSkill(_loc3_);
        }
    }

    private static function addSkillDefinition(param1:uint, param2:String, param3:uint, param4:uint, param5:uint, param6:uint, param7:String):void {
        var _loc8_:SkillDefinition = new SkillDefinition(param1, param2, param3, param4, param5, param6, param7);
        _skillMap.add(_loc8_.id, _loc8_);
    }

    private static function addHideSkillDefinition(param1:uint, param2:String):void {
        var _loc3_:HideSkillDefinition = new HideSkillDefinition(param1, param2);
        _hideSkillMap.add(_loc3_.id, _loc3_);
    }

    public static function getSkillDefinition(param1:int):SkillDefinition {
        if (_skillMap.containsKey(param1)) {
            return _skillMap.getValue(param1) as SkillDefinition;
        }
        return null;
    }

    public static function getHideSkillDefinition(param1:int):HideSkillDefinition {
        if (_hideSkillMap.containsKey(param1)) {
            return _hideSkillMap.getValue(param1) as HideSkillDefinition;
        }
        return null;
    }

    public static function getAllSkillDefinition():Vector.<SkillDefinition> {
        return Vector.<SkillDefinition>(_skillMap.getValues());
    }
}
}
