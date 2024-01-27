package com.taomee.seer2.app.inventory.item {
public class SpecialItem {


    public var referenceId:uint;

    public var quantity:uint;

    public var expiryTime:uint;

    public var getTime:uint;

    public function SpecialItem(param1:uint, param2:int, param3:uint, param4:uint = 0) {
        super();
        this.referenceId = param1;
        this.quantity = param2;
        this.expiryTime = param3;
        this.getTime = param4;
    }
}
}
