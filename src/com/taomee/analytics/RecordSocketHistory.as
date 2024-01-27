package com.taomee.analytics {
internal class RecordSocketHistory {

    public static const TAG_SYSTEM_BUSY:String = "SystemBusy";

    public static const TAG_DB_TIMEOUT:String = "DBTimeOut";

    private static var oldTimer:Number = 0;

    public static var actionHistory:Array = [];

    public static const ACTION_WRITE:String = "write";

    public static var recordCount:int = 40;

    public static const ACTION_READ:String = "read";


    public function RecordSocketHistory() {
        super();
    }

    public static function pushInActionHistory(param1:int, param2:String):void {
        var _loc3_:Number = new Date().time;
        var _loc4_:int = _loc3_ - (oldTimer == 0 ? _loc3_ : oldTimer);
        actionHistory.push(param1 + ":" + String(_loc4_) + "/" + param2);
        if (actionHistory.length > recordCount) {
            actionHistory.shift();
        }
        oldTimer = _loc3_;
    }

    public static function pushInTagHistory(param1:int, param2:String):void {
        var _loc3_:Number = new Date().time;
        var _loc4_:int = _loc3_ - (oldTimer == 0 ? _loc3_ : oldTimer);
        actionHistory.push(param1 + ":" + param2 + "-" + String(_loc4_) + "/Tag");
        if (actionHistory.length > recordCount) {
            actionHistory.shift();
        }
        oldTimer = _loc3_;
    }
}
}
