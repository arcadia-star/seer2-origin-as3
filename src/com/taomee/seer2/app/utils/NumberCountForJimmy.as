package com.taomee.seer2.app.utils {
public class NumberCountForJimmy {


    public function NumberCountForJimmy() {
        super();
    }

    public static function countLeftNum(param1:int, param2:int, param3:int):int {
        var _loc4_:int = 0;
        if (param1 > param3) {
            _loc4_ = param2;
        } else {
            _loc4_ = param2 + param3 - param1;
        }
        return _loc4_;
    }
}
}
