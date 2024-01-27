package com.taomee.seer2.app.arena.data {
public class BuffResultInfo {


    public var userId:uint;

    public var fighterId:uint;

    public var isDying:Boolean;

    public var buffResultInfoRoundDatas:Vector.<BuffResultInfoRoundData>;

    public function BuffResultInfo() {
        super();
    }

    public function get buffNum():uint {
        return this.buffResultInfoRoundDatas.length;
    }

    public function getChangeHp(param1:uint):int {
        var _loc2_:uint = this.buffResultInfoRoundDatas.length - 1;
        if (param1 <= _loc2_) {
            return this.buffResultInfoRoundDatas[param1].changeHp;
        }
        return 0;
    }
}
}
