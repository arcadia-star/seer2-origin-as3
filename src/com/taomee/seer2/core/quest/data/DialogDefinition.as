package com.taomee.seer2.core.quest.data {
import com.taomee.seer2.core.quest.data.dialog.BranchDefinition;
import com.taomee.seer2.core.utils.StringConstants;

import flash.utils.getDefinitionByName;

public class DialogDefinition {


    public var npcId:int;

    public var npcName:String;

    public var transport:String;

    public var branchVec:Vector.<BranchDefinition>;

    public function DialogDefinition(param1:XML = null) {
        super();
        if (param1 != null) {
            this.parseData(param1);
        }
    }

    public static function generateDefinition(param1:int, param2:String, param3:Array, param4:String):DialogDefinition {
        var _loc5_:* = "<dialog npcId=\"" + param1 + "\" npcName=\"" + param2 + "\"><branch id=\"default\">";
        var _loc6_:int = 0;
        while (_loc6_ < param3.length) {
            _loc5_ += "<node emotion=\"" + param3[_loc6_][0] + "\"><![CDATA[" + param3[_loc6_][1] + "]]></node>";
            _loc6_++;
        }
        _loc5_ = (_loc5_ += "<reply action=\"close\"><![CDATA[" + param4 + "]]></reply>") + "</branch></dialog>";
        return new DialogDefinition(XML(_loc5_));
    }

    public static function generatQuestDefinition(param1:int, param2:int, param3:String, param4:Vector.<String>, param5:String):DialogDefinition {
        var _loc6_:* = (_loc6_ = "<dialog npcId=\"" + param1 + "\" npcName=\"" + "asdf" + "\"><branch id=\"default\">") + ("<node emotion=\"" + param2 + "\"><![CDATA[" + param3 + "]]></node>");
        var _loc7_:int = int(param4.length);
        var _loc8_:int = 0;
        while (_loc8_ < _loc7_) {
            _loc6_ += "<reply action=\"" + param5 + "_" + _loc8_ + "\"><![CDATA[" + param4[_loc8_] + "]]></reply>";
            _loc8_++;
        }
        _loc6_ += "</branch></dialog>";
        return new DialogDefinition(XML(_loc6_));
    }

    private function parseData(param1:XML):void {
        var _loc4_:XML = null;
        var _loc5_:BranchDefinition = null;
        var _loc6_:Vector.<String> = null;
        var _loc7_:Vector.<String> = null;
        var _loc8_:XMLList = null;
        var _loc9_:XML = null;
        var _loc10_:Vector.<String> = null;
        var _loc11_:Vector.<String> = null;
        var _loc12_:Vector.<String> = null;
        var _loc13_:XMLList = null;
        var _loc14_:XML = null;
        var _loc15_:* = undefined;
        var _loc16_:int = 0;
        this.npcId = int(param1.attribute("npcId").toString());
        this.npcName = param1.attribute("npcName").toString();
        this.transport = param1.attribute("transport").toString();
        this.branchVec = new Vector.<BranchDefinition>();
        var _loc2_:XMLList = param1.elements("branch");
        var _loc3_:int = _loc2_.length();
        for each(_loc4_ in _loc2_) {
            (_loc5_ = new BranchDefinition()).id = _loc4_.attribute("id").toString();
            if (int(_loc4_.attribute("npcId").toString()) == 9999) {
                if ((_loc15_ = getDefinitionByName("com.taomee.seer2.app.actor.ActorManager")).getActor().getInfo().sex == 0) {
                    _loc5_.npcId = 502;
                } else {
                    _loc5_.npcId = 501;
                }
                _loc5_.npcName = "我";
            } else if ((_loc16_ = int(_loc4_.attribute("npcId").toString())) == 0) {
                _loc5_.npcId = this.npcId;
                _loc5_.npcName = this.npcName;
            } else {
                _loc5_.npcId = int(_loc4_.attribute("npcId").toString());
                _loc5_.npcName = _loc4_.attribute("npcName").toString();
            }
            _loc6_ = new Vector.<String>();
            _loc7_ = new Vector.<String>();
            _loc8_ = _loc4_.elements("node");
            for each(_loc9_ in _loc8_) {
                _loc6_.push(_loc9_.toString());
                _loc7_.push(_loc9_.attribute("emotion").toString());
            }
            _loc5_.contentVec = _loc6_;
            _loc5_.emotionVec = _loc7_;
            _loc10_ = new Vector.<String>();
            _loc11_ = new Vector.<String>();
            _loc12_ = new Vector.<String>();
            _loc13_ = _loc4_.elements("reply");
            for each(_loc14_ in _loc13_) {
                _loc10_.push(_loc14_.toString());
                _loc11_.push(_loc14_.attribute("action").toString());
                _loc12_.push(_loc14_.attribute("params").toString());
            }
            _loc5_.replyLabelVec = _loc10_;
            _loc5_.replyActionVec = _loc11_;
            _loc5_.replyParamVec = _loc12_;
            this.branchVec.push(_loc5_);
        }
    }

    public function updateNpcName(param1:String):void {
        var _loc2_:BranchDefinition = null;
        this.npcName = param1;
        for each(_loc2_ in this.branchVec) {
            if (_loc2_.npcName == StringConstants.EMPTY) {
                _loc2_.npcName = param1;
            }
        }
    }
}
}
