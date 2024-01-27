package com.taomee.seer2.app.config {
import com.taomee.seer2.core.quest.data.DialogDefinition;
import com.taomee.seer2.core.quest.data.QuestDefinition;
import com.taomee.seer2.core.quest.data.QuestPrerequisiteDefinition;
import com.taomee.seer2.core.quest.data.QuestProductDefinition;
import com.taomee.seer2.core.quest.data.QuestStepDefinition;
import com.taomee.seer2.core.quest.data.TargetDefinition;
import com.taomee.seer2.core.quest.data.dialog.BranchDefinition;

import org.taomee.ds.HashMap;

public class QuestConfig {

    private static var _xmlClass:Class = QuestConfig__xmlClass;

    private static var _xml:XML;

    private static var _map:HashMap = new HashMap();

    {
        initlize();
    }

    public function QuestConfig() {
        super();
    }

    public static function initlize():void {
        var _loc2_:XML = null;
        _xml = XML(new _xmlClass());
        var _loc1_:XMLList = _xml.descendants("quest");
        for each(_loc2_ in _loc1_) {
            parseQuest(_loc2_);
        }
    }

    private static function parseQuest(param1:XML):void {
        var _loc2_:QuestDefinition = null;
        var _loc17_:XML = null;
        var _loc18_:String = null;
        var _loc19_:Array = null;
        var _loc20_:XML = null;
        var _loc3_:uint = uint(param1.@id);
        var _loc4_:String = addStringPropertyToResult(param1.@name);
        var _loc5_:uint = addUintPropertyToResult(param1.@type);
        var _loc6_:uint = addUintPropertyToResult(param1.@autoNext);
        var _loc7_:uint = addUintPropertyToResult(param1.@track);
        var _loc8_:uint = addUintPropertyToResult(param1.@needAcceptMark);
        var _loc9_:uint = addUintPropertyToResult(param1.@acceptMapId);
        var _loc10_:uint = addUintPropertyToResult(param1.@acceptNpcId);
        var _loc11_:String = addStringPropertyToResult(param1.@onlineTime);
        var _loc12_:String = addStringPropertyToResult(param1.@monLvlUp);
        var _loc13_:uint = addUintPropertyToResult(param1.@isShow);
        var _loc14_:Vector.<int> = addMapIdsToResult(param1.@relatedMapIds);
        _loc2_ = new QuestDefinition(_loc3_, _loc4_, _loc5_, _loc6_, _loc7_, _loc8_, _loc9_, _loc10_, _loc11_, _loc12_, _loc13_, _loc14_);
        var _loc15_:XMLList;
        if ((_loc15_ = param1.elements("prerequisite")).length() > 0) {
            _loc17_ = _loc15_[0];
            _loc18_ = _loc17_.@questId;
            _loc19_ = _loc18_.split(",", _loc18_.length);
            _loc2_.prerequisiteDefinition = new QuestPrerequisiteDefinition(_loc19_, _loc17_.@level);
        }
        if (param1.elements("acceptDialog").length() > 0) {
            _loc20_ = param1.elements("acceptDialog")[0];
            _loc2_.acceptDialog = parseDialogXML(_loc20_);
        }
        var _loc16_:XML = param1.elements("steps")[0];
        parseStepList(_loc16_, _loc2_);
        if (param1.elements("doc").length() > 0) {
            _loc2_.des = param1.elements("doc").toString();
        }
        _map.add(_loc2_.id, _loc2_);
    }

    private static function parseStepList(param1:XML, param2:QuestDefinition):void {
        var _loc4_:XML = null;
        param2.stepDefinitionVec = new Vector.<QuestStepDefinition>();
        var _loc3_:XMLList = param1.elements("step");
        for each(_loc4_ in _loc3_) {
            param2.stepDefinitionVec.push(parseStep(_loc4_));
        }
    }

    private static function parseStep(param1:XML):QuestStepDefinition {
        var _loc2_:QuestStepDefinition = new QuestStepDefinition(int(param1.@id), int(param1.@relatedNpcId), param1.@name, param1.@sum, param1.@des, param1.@point, param1.@transport);
        if (param1.elements("target").length() > 0) {
            _loc2_.targetDefinition = parseTargetXML(param1.elements("target")[0]);
        }
        if (param1.elements("dialog").length() > 0) {
            _loc2_.dialogDefinition = parseDialogXML(param1.elements("dialog")[0]);
        }
        if (param1.elements("income").length() > 0) {
            _loc2_.income = parseProduct(param1.elements("income")[0]);
        }
        if (param1.elements("outcome").length() > 0) {
            _loc2_.outcome = parseProduct(param1.elements("outcome")[0]);
        }
        return _loc2_;
    }

    private static function parseTargetXML(param1:XML):TargetDefinition {
        var _loc2_:TargetDefinition = new TargetDefinition();
        _loc2_.type = param1.@type;
        _loc2_.count = param1.@count;
        _loc2_.params = param1.@params;
        _loc2_.alert = param1.@alert;
        _loc2_.transport = param1.@transport;
        return _loc2_;
    }

    private static function parseProduct(param1:XML):QuestProductDefinition {
        var _loc6_:XML = null;
        var _loc7_:QuestProductDefinition = null;
        var _loc2_:Array = [];
        var _loc3_:Array = [];
        var _loc4_:Array = [];
        var _loc5_:XMLList = param1.elements("item");
        for each(_loc6_ in _loc5_) {
            _loc2_.push(_loc6_.@giveId);
            _loc3_.push(_loc6_.@cnt);
            if (String(_loc6_.@isPet) == "true") {
                _loc4_.push(true);
            } else {
                _loc4_.push(false);
            }
        }
        _loc2_ = _loc2_.slice(0, _loc2_.length);
        _loc3_ = _loc3_.slice(0, _loc3_.length);
        _loc4_ = _loc4_.slice(0, _loc4_.length);
        return new QuestProductDefinition(_loc2_, _loc3_, _loc4_);
    }

    private static function parseDialogXML(param1:XML):DialogDefinition {
        var _loc2_:DialogDefinition = null;
        var _loc3_:BranchDefinition = null;
        var _loc5_:XML = null;
        var _loc6_:int = 0;
        var _loc7_:String = null;
        var _loc8_:XMLList = null;
        var _loc9_:XML = null;
        var _loc10_:XMLList = null;
        var _loc11_:XML = null;
        _loc2_ = new DialogDefinition();
        _loc2_.npcId = param1.@npcId;
        _loc2_.npcName = param1.@npcName;
        _loc2_.transport = param1.@transport;
        _loc2_.branchVec = new Vector.<BranchDefinition>();
        var _loc4_:XMLList = param1.elements("branch");
        for each(_loc5_ in _loc4_) {
            _loc3_ = new BranchDefinition();
            _loc3_.id = _loc5_.@id;
            if ((_loc6_ = int(_loc5_.@npcId.toString())) == 0) {
                _loc6_ = int(param1.@npcId);
                _loc7_ = param1.@npcName;
            } else {
                _loc6_ = int(_loc5_.@npcId);
                _loc7_ = _loc5_.@npcName;
            }
            _loc3_.npcId = _loc6_;
            _loc3_.npcName = _loc7_;
            _loc3_.contentVec = new Vector.<String>();
            _loc3_.emotionVec = new Vector.<String>();
            _loc8_ = _loc5_.elements("node");
            for each(_loc9_ in _loc8_) {
                _loc3_.emotionVec.push(_loc9_.@emotion);
                _loc3_.contentVec.push(_loc9_.toString());
            }
            _loc10_ = _loc5_.elements("reply");
            _loc3_.replyLabelVec = new Vector.<String>();
            _loc3_.replyActionVec = new Vector.<String>();
            _loc3_.replyParamVec = new Vector.<String>();
            for each(_loc11_ in _loc10_) {
                _loc3_.replyLabelVec.push(_loc11_.toString());
                _loc3_.replyActionVec.push(_loc11_.@action);
                _loc3_.replyParamVec.push(_loc11_.@params);
            }
            _loc2_.branchVec.push(_loc3_);
        }
        return _loc2_;
    }

    private static function addMapIdsToResult(param1:String):Vector.<int> {
        if (param1 == "") {
            return new Vector.<int>();
        }
        return Vector.<int>(param1.split(","));
    }

    private static function addStringPropertyToResult(param1:String):String {
        if (param1 == "") {
            return "0";
        }
        return param1;
    }

    private static function addUintPropertyToResult(param1:String):uint {
        if (param1 == "") {
            return 0;
        }
        return uint(param1);
    }

    public static function getQuestDefinition(param1:int):QuestDefinition {
        if (_map.containsKey(param1)) {
            return _map.getValue(param1) as QuestDefinition;
        }
        return null;
    }

    public static function getAllDefinition():Vector.<QuestDefinition> {
        return Vector.<QuestDefinition>(_map.getValues());
    }
}
}
