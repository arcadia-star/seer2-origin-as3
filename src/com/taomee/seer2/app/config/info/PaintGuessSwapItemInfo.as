package com.taomee.seer2.app.config.info {
public class PaintGuessSwapItemInfo {


    public var id:uint;

    public var tip:String;

    public var isPet:uint;

    public var condition:String;

    public var swapId:uint;

    public var onlyFlag:uint;

    public function PaintGuessSwapItemInfo(param1:uint, param2:String, param3:uint, param4:String, param5:uint, param6:uint) {
        super();
        this.id = param1;
        this.tip = param2;
        this.isPet = param3;
        this.condition = param4;
        this.swapId = param5;
        this.onlyFlag = param6;
    }
}
}
