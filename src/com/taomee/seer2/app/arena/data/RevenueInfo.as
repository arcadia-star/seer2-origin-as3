package com.taomee.seer2.app.arena.data {
import flash.utils.IDataInput;

public class RevenueInfo {


    private var _fighterRevenueInfoVec:Vector.<FighterRevenueInfo>;

    private var _expRate:uint;

    public function RevenueInfo(param1:IDataInput) {
        var _loc4_:FighterRevenueInfo = null;
        super();
        this._fighterRevenueInfoVec = new Vector.<FighterRevenueInfo>();
        var _loc2_:int = int(param1.readUnsignedInt());
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_) {
            _loc4_ = new FighterRevenueInfo(param1);
            this._fighterRevenueInfoVec.push(_loc4_);
            _loc3_++;
        }
        this._expRate = param1.readUnsignedInt();
    }

    public function get expRate():uint {
        return this._expRate;
    }

    public function get fighterRevenueInfoVec():Vector.<FighterRevenueInfo> {
        return this._fighterRevenueInfoVec;
    }
}
}
