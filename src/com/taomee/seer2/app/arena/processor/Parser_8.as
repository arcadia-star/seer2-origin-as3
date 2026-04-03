package com.taomee.seer2.app.arena.processor {
import com.taomee.seer2.app.arena.data.FighterBuffInfo;

import flash.utils.IDataInput;

public class Parser_8 {


    public var userId:uint;

    public var fighterId:uint;

    public var angerValue:uint;

    public function Parser_8(param1:IDataInput) {
        super();
        this.userId = param1.readUnsignedInt();
        this.fighterId = param1.readUnsignedInt();
        this.angerValue = param1.readUnsignedInt();
    }

    public function parserFighterBuffInfo(param1:IDataInput):Vector.<FighterBuffInfo> {
        var _loc2_:uint = uint(param1.readUnsignedInt());
        var _loc3_:Vector.<FighterBuffInfo> = new Vector.<FighterBuffInfo>();
        var _loc4_:uint = 0;
        while (_loc4_ < _loc2_) {
            _loc3_.push(new FighterBuffInfo(param1));
            _loc4_++;
        }
        return _loc3_;
    }
}
}

