package com.taomee.analytics.item {
public class ErrorItem {


    private var _submitLimit:int;

    private var _label:String;

    private var _id:int;

    public function ErrorItem(param1:int, param2:String, param3:int = 1) {
        super();
        _id = param1;
        _label = param2;
        _submitLimit = param3;
    }

    public function get submitLimit():int {
        return _submitLimit;
    }

    public function get label():String {
        return _label;
    }

    public function get id():int {
        return _id;
    }
}
}
