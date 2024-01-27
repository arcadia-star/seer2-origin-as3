package com.taomee.seer2.app.info {
import com.taomee.seer2.app.net.parser.Parser_1065;
import com.taomee.seer2.core.net.LittleEndianByteArray;

public class DayLimitListInfo {


    public var data:LittleEndianByteArray;

    public var dayLimitList:Vector.<Parser_1065>;

    public var callBack:Function;

    public function DayLimitListInfo() {
        this.dayLimitList = Vector.<Parser_1065>([]);
        super();
    }

    public function getCount(param1:uint):uint {
        var _loc2_:Parser_1065 = null;
        for each(_loc2_ in this.dayLimitList) {
            if (_loc2_.id == param1) {
                return _loc2_.count;
            }
        }
        return 0;
    }
}
}
