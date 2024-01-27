package com.taomee.seer2.core.inventory {
import com.taomee.seer2.core.inventory.events.InventoryErrorEvent;
import com.taomee.seer2.core.inventory.events.InventoryEvent;
import com.taomee.seer2.core.log.Logger;

import flash.events.EventDispatcher;

import org.taomee.ds.HashMap;

public class Inventory extends EventDispatcher {


    protected var _capacity:int;

    protected var _logger:Logger;

    protected var _content:HashMap;

    protected var _usedCapacity:int;

    public function Inventory() {
        super(this);
        this.initialize();
    }

    private function initialize():void {
        this._content = new HashMap();
        this._logger = Logger.getLogger("Inventory");
    }

    public function set capacity(param1:int):void {
        this._capacity = param1;
    }

    public function get capacity():int {
        return this._capacity;
    }

    public function get usedCapacity():int {
        return this._usedCapacity;
    }

    public function getAvailableCapacity():int {
        return this._capacity - this._usedCapacity;
    }

    public function isFull():Boolean {
        return this._capacity > 0 && this._usedCapacity >= this._capacity;
    }

    public function isEmpty():Boolean {
        return this._usedCapacity == 0;
    }

    public function canAddItem(param1:Item):Boolean {
        if (this.isEmpty()) {
            return true;
        }
        if (param1 is StackableItem) {
            return this.canAddStackableItem(param1 as StackableItem);
        }
        if (param1 is UnstackableItem && this.isFull()) {
            return false;
        }
        return false;
    }

    protected function canAddStackableItem(param1:StackableItem):Boolean {
        var _loc2_:Item = null;
        var _loc3_:int = 0;
        if (this.contains(param1)) {
            _loc2_ = this.getItemByUniqueId(param1.uniqueId);
            _loc3_ = _loc2_.quantity + param1.quantity;
            if (_loc3_ > param1.quantityLimit) {
                return false;
            }
            return true;
        }
        if (param1.getOccupiedSpace() > this.getAvailableCapacity()) {
            return false;
        }
        return true;
    }

    public function addItem(param1:Item):void {
        if (param1 is StackableItem) {
            this.addStackableItem(param1 as StackableItem);
        } else {
            this.addUnstackableItem(param1 as UnstackableItem);
        }
    }

    protected function addStackableItem(param1:StackableItem):void {
        var _loc2_:Item = null;
        var _loc3_:int = 0;
        if (this.containsUniqueId(param1.uniqueId)) {
            _loc2_ = this.getItemByUniqueId(param1.uniqueId);
            _loc2_.expiryTime = param1.expiryTime;
            _loc3_ = _loc2_.quantity + param1.quantity;
            if (param1.category == 1) {
                _loc3_ = param1.quantity;
            }
            if (_loc3_ > param1.quantityLimit) {
                this.dispatchInventoryErrorEvent(InventoryErrorEvent.QUANTITY_LIMIT_REACH);
                return;
            }
            _loc2_.quantity = _loc3_;
            this.dispatchInventoryEvent(InventoryEvent.QUANTITY_ADD, param1.referenceId);
            this.dispatchInventoryEvent(InventoryEvent.UPDATE_QUANTITY, param1.referenceId);
        } else {
            if (param1.getOccupiedSpace() > this.getAvailableCapacity()) {
                this.dispatchInventoryErrorEvent(InventoryErrorEvent.FULL);
                return;
            }
            this._content.add(param1.uniqueId, param1);
            this.dispatchInventoryEvent(InventoryEvent.QUANTITY_ADD, param1.referenceId);
            this.dispatchInventoryEvent(InventoryEvent.ADD, param1.referenceId);
            this.dispatchInventoryEvent(InventoryEvent.UPDATE_QUANTITY, param1.referenceId);
        }
        this.updateUsedCapacity();
    }

    protected function addUnstackableItem(param1:UnstackableItem):void {
        if (this.isFull()) {
            this.dispatchInventoryErrorEvent(InventoryErrorEvent.FULL);
        } else {
            this._content.add(param1.uniqueId, param1);
            this.dispatchInventoryEvent(InventoryEvent.QUANTITY_ADD, param1.referenceId);
            this.dispatchInventoryEvent(InventoryEvent.ADD, param1.referenceId);
            this.dispatchInventoryEvent(InventoryEvent.UPDATE_QUANTITY, param1.referenceId);
            this.updateUsedCapacity();
        }
    }

    protected function dispatchInventoryEvent(param1:String, param2:int):void {
        if (hasEventListener(param1)) {
            dispatchEvent(new InventoryEvent(param1, param2));
        }
    }

    protected function dispatchInventoryErrorEvent(param1:String):void {
        if (hasEventListener(param1)) {
            dispatchEvent(new InventoryErrorEvent(param1));
        }
    }

    protected function updateUsedCapacity():void {
        var _loc2_:Item = null;
        this._usedCapacity = 0;
        var _loc1_:Array = this._content.getValues();
        for each(_loc2_ in _loc1_) {
            this._usedCapacity += _loc2_.getOccupiedSpace();
        }
        if (this._usedCapacity < 0) {
            this._usedCapacity = 0;
        }
    }

    public function removeItem(param1:Item):void {
        this.removeItemByUniqueId(param1.uniqueId);
    }

    public function removeItemByUniqueId(param1:int):void {
        var _loc2_:Item = null;
        if (this._content.containsKey(param1)) {
            _loc2_ = this._content.getValue(param1) as Item;
            this._content.remove(param1);
            this.dispatchInventoryEvent(InventoryEvent.REMOVE, _loc2_.referenceId);
            this.dispatchInventoryEvent(InventoryEvent.UPDATE_QUANTITY, _loc2_.referenceId);
        } else {
            this.dispatchInventoryErrorEvent(InventoryErrorEvent.NO_SUCH_ITEM);
        }
    }

    public function removeItemByReferenceId(param1:int):void {
        var _loc3_:Item = null;
        var _loc2_:Vector.<Item> = this.getContent();
        for each(_loc3_ in _loc2_) {
            if (_loc3_.referenceId == param1) {
                this.removeItem(_loc3_);
            }
        }
    }

    public function reduceItemQuantity(param1:int, param2:int):void {
        var _loc3_:Item = null;
        if (this.containsReferenceId(param1)) {
            _loc3_ = this.getItemByReferenceId(param1);
            if (param2 >= _loc3_.quantity) {
                this.removeItem(_loc3_);
            } else {
                _loc3_.quantity -= param2;
                this.dispatchInventoryEvent(InventoryEvent.UPDATE_QUANTITY, _loc3_.referenceId);
            }
        } else {
            this.dispatchInventoryErrorEvent(InventoryErrorEvent.NO_SUCH_ITEM);
        }
    }

    public function contains(param1:Item):Boolean {
        return this.containsUniqueId(param1.uniqueId);
    }

    public function containsUniqueId(param1:int):Boolean {
        return this._content.containsKey(param1);
    }

    public function containsReferenceId(param1:int):Boolean {
        var _loc3_:Item = null;
        var _loc2_:Vector.<Item> = this.getContent();
        for each(_loc3_ in _loc2_) {
            if (_loc3_.referenceId == param1) {
                return true;
            }
        }
        return false;
    }

    public function getItemByUniqueId(param1:int):Item {
        if (this.containsUniqueId(param1)) {
            return this._content.getValue(param1) as Item;
        }
        return null;
    }

    public function getItemByReferenceId(param1:int):Item {
        var _loc3_:Item = null;
        var _loc2_:Vector.<Item> = this.getContent();
        for each(_loc3_ in _loc2_) {
            if (_loc3_.referenceId == param1) {
                return _loc3_;
            }
        }
        return null;
    }

    public function getItemQuantityByUniqueId(param1:int):int {
        if (this.containsUniqueId(param1) == false) {
            return 0;
        }
        var _loc2_:Item = this.getItemByUniqueId(param1);
        return _loc2_.quantity;
    }

    public function getItemQuantityByReferenceId(param1:int):int {
        var _loc4_:Item = null;
        var _loc2_:Vector.<Item> = this.getContent();
        var _loc3_:int = 0;
        for each(_loc4_ in _loc2_) {
            if (_loc4_.referenceId == param1) {
                _loc3_ += _loc4_.quantity;
            }
        }
        return _loc3_;
    }

    public function getContent():Vector.<Item> {
        return Vector.<Item>(this._content.getValues());
    }
}
}
