package com.taomee.seer2.app.inventory {
public class ItemDescription {


    private var _referenceId:uint;

    private var _quantity:uint;

    private var _time:uint;

    private var _isPet:Boolean;

    private var _isAdd:Boolean;

    public function ItemDescription(param1:uint, param2:uint, param3:uint = 0, param4:Boolean = false, param5:Boolean = true) {
        super();
        this._referenceId = param1;
        this._quantity = param2;
        this._time = param3;
        this._isPet = param4;
        this._isAdd = param5;
    }

    public function get referenceId():uint {
        return this._referenceId;
    }

    public function get quantity():uint {
        return this._quantity;
    }

    public function set quantity(param1:uint):void {
        this._quantity = param1;
    }

    public function get time():uint {
        return this._time;
    }

    public function get isPet():Boolean {
        return this._isPet;
    }

    public function get isAdd():Boolean {
        return this._isAdd;
    }

    public function equals(param1:ItemDescription):Boolean {
        return this._referenceId == param1._referenceId && this._quantity == param1._quantity && this._isPet == param1._isPet;
    }
}
}
