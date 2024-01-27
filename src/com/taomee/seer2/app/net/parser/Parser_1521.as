package com.taomee.seer2.app.net.parser {
import com.taomee.seer2.app.net.parser.baseData.RankServerInfo;

import flash.utils.IDataInput;

public class Parser_1521 {


    public var maxId:uint;

    public var midId:int;

    public var minId:uint;

    public var rankInfoList:Vector.<RankServerInfo>;

    public function Parser_1521(param1:IDataInput) {
        var _loc3_:RankServerInfo = null;
        super();
        this.maxId = param1.readUnsignedInt();
        this.midId = param1.readUnsignedInt();
        this.minId = param1.readUnsignedInt();
        var _loc2_:uint = uint(param1.readUnsignedInt());
        this.rankInfoList = Vector.<RankServerInfo>([]);
        var _loc4_:int = 0;
        while (_loc4_ < _loc2_) {
            _loc3_ = new RankServerInfo(param1);
            this.rankInfoList.push(_loc3_);
            _loc4_++;
        }
        this.rankInfoList.sort(this.sortVec);
    }

    private function sortVec(param1:RankServerInfo, param2:RankServerInfo):int {
        if (param1.currRank > param2.currRank) {
            return 1;
        }
        if (param1.currRank < param2.currRank) {
            return -1;
        }
        return 0;
    }
}
}
