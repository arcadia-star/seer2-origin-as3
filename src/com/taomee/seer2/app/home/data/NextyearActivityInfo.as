package com.taomee.seer2.app.home.data {
import flash.utils.IDataInput;

public class NextyearActivityInfo {


    public var isYes:uint;

    public var winCount:uint;

    public var noWinCount:uint;

    public function NextyearActivityInfo(param1:IDataInput) {
        super();
        this.isYes = param1.readUnsignedByte();
        this.winCount = param1.readUnsignedByte();
        this.noWinCount = param1.readUnsignedByte();
    }
}
}
