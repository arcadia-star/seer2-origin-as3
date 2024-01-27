package com.taomee.seer2.core.inventory.events {
import flash.events.Event;

public class InventoryEvent extends Event {

    public static const QUANTITY_ADD:String = "quantityAdd";

    public static const ADD:String = "add";

    public static const REMOVE:String = "remove";

    public static const UPDATE_QUANTITY:String = "updateQuantity";


    private var _itemReferenceId:int;

    public function InventoryEvent(param1:String, param2:int, param3:Boolean = false, param4:Boolean = false) {
        super(param1, param3, param4);
        this._itemReferenceId = param2;
    }

    public function get itemReferenceId():int {
        return this._itemReferenceId;
    }

    override public function clone():Event {
        return new InventoryEvent(this.type, this._itemReferenceId);
    }
}
}
