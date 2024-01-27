package com.taomee.seer2.app.config.item {
public class BasisItemDefinition {


    public var id:int;

    public var category:int;

    public var name:String;

    public var price:Number = 0;

    public var currencyType:int = 1;

    public var tradability:int = 0;

    public var vipTradability:int = 0;

    public var isVipOnly:Boolean = false;

    public var quantityLimit:int;

    public var isHide:Boolean;

    public var tip:String;

    public function BasisItemDefinition(param1:int, param2:int, param3:String, param4:Number, param5:int, param6:int, param7:int, param8:Boolean, param9:Boolean, param10:int, param11:String) {
        super();
        this.id = param1;
        this.category = param2;
        this.name = param3;
        this.quantityLimit = param10;
        this.tip = param11;
        this.price = param4;
        this.currencyType = param5;
        this.tradability = param6;
        this.vipTradability = param7;
        this.isVipOnly = param8;
        this.isHide = param9;
    }
}
}
