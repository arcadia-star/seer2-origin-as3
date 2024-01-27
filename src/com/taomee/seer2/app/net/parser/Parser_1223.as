package com.taomee.seer2.app.net.parser {
import flash.utils.IDataInput;

public class Parser_1223 {


    public var itemId:uint;

    public var price:uint;

    public var vipPrice:uint;

    public var nonVipPrice:uint;

    public var type:int;

    public var category:int;

    public var giftMoney:uint;

    public var mustVip:int;

    public var maxLimit:uint;

    public var totalCount:uint;

    public var currentCount:uint;

    public var isValid:int;

    public var flag:int;

    public function Parser_1223(param1:IDataInput) {
        super();
        this.itemId = param1.readUnsignedInt();
        this.price = param1.readUnsignedInt();
        this.vipPrice = param1.readUnsignedInt();
        this.nonVipPrice = param1.readUnsignedInt();
        this.type = param1.readUnsignedByte();
        this.category = param1.readUnsignedByte();
        this.giftMoney = param1.readUnsignedInt();
        this.mustVip = param1.readUnsignedByte();
        this.maxLimit = param1.readUnsignedInt();
        this.totalCount = param1.readUnsignedInt();
        this.currentCount = param1.readUnsignedInt();
        this.isValid = param1.readUnsignedByte();
        this.flag = param1.readUnsignedByte();
    }
}
}
