package com.taomee.seer2.app.gameRule.spt.support {
public class SptDialogContentInfo {


    public var id:uint;

    public var content:String;

    public function SptDialogContentInfo() {
        super();
    }

    public function getContent(param1:Array):String {
        var _loc3_:uint = 0;
        var _loc4_:uint = 0;
        var _loc2_:String = this.content;
        if (param1 != null) {
            _loc3_ = param1.length;
            _loc4_ = 0;
            while (_loc4_ < _loc3_) {
                _loc2_ = this.replaceParam(_loc2_, param1[_loc4_], _loc4_);
                _loc4_++;
            }
        }
        return _loc2_;
    }

    private function replaceParam(param1:String, param2:String, param3:uint):String {
        var _loc4_:* = "{" + param3 + "}";
        return param1.replace(_loc4_, param2);
    }
}
}
