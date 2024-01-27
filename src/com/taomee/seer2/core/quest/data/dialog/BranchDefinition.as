package com.taomee.seer2.core.quest.data.dialog {
import flash.utils.getDefinitionByName;

public class BranchDefinition {


    public var id:String;

    public var emotionVec:Vector.<String>;

    public var contentVec:Vector.<String>;

    public var replyLabelVec:Vector.<String>;

    public var replyActionVec:Vector.<String>;

    public var replyParamVec:Vector.<String>;

    private var _npcId:int;

    private var _npcName:String;

    public function BranchDefinition() {
        super();
    }

    public function set npcId(param1:int):void {
        this._npcId = param1;
    }

    public function set npcName(param1:String):void {
        this._npcName = param1;
    }

    public function get npcId():int {
        var _loc1_:* = undefined;
        if (this._npcId == 9999) {
            _loc1_ = getDefinitionByName("com.taomee.seer2.app.actor.ActorManager");
            if (_loc1_.getActor().getInfo().sex == 0) {
                return 502;
            }
            return 501;
        }
        return this._npcId;
    }

    public function get npcName():String {
        if (this._npcId == 9999) {
            return "我";
        }
        return this._npcName;
    }
}
}
