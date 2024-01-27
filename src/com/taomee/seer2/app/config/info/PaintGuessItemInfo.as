package com.taomee.seer2.app.config.info {
public class PaintGuessItemInfo {


    public var itemId:uint;

    public var optionArr:Array;

    public var yesOption:String;

    public var isOpen:uint;

    public function PaintGuessItemInfo(param1:uint, param2:Array, param3:String, param4:uint) {
        super();
        this.itemId = param1;
        this.optionArr = param2;
        this.yesOption = param3;
        this.isOpen = param4;
    }
}
}
