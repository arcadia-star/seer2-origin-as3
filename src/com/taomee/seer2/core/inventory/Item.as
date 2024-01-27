package com.taomee.seer2.core.inventory {
public class Item {


    private var _referenceId:uint;

    private var _expiryTime:uint;

    private var _getTime:uint;

    private var _uniqueId:int;

    private var _quantity:int = 1;

    private var _quantityLimit:int;

    private var _name:String = "";

    private var _category:int;

    private var _currencyType:int;

    private var _price:int;

    private var _tradability:int;

    private var _vipTradability:int;

    private var _isVipOnly:Boolean;

    private var _tip:String;

    public function Item() {
        super();
    }

    public function set name(param1:String):void {
        this._name = param1;
    }

    public function get name():String {
        return this._name;
    }

    public function set referenceId(param1:int):void {
        this._referenceId = param1;
    }

    public function get referenceId():int {
        return this._referenceId;
    }

    public function set expiryTime(param1:uint):void {
        this._expiryTime = param1;
    }

    public function get expiryTime():uint {
        return this._expiryTime;
    }

    public function set uniqueId(param1:int):void {
        this._uniqueId = param1;
    }

    public function get uniqueId():int {
        return this._uniqueId;
    }

    public function set category(param1:int):void {
        this._category = param1;
    }

    public function get category():int {
        return this._category;
    }

    public function set quantity(param1:int):void {
        this._quantity = param1;
    }

    public function get quantity():int {
        return this._quantity;
    }

    public function set quantityLimit(param1:int):void {
        this._quantityLimit = param1;
    }

    public function get quantityLimit():int {
        return this._quantityLimit;
    }

    public function get currencyType():int {
        return this._currencyType;
    }

    public function set currencyType(param1:int):void {
        this._currencyType = param1;
    }

    public function get price():int {
        return this._price;
    }

    public function set price(param1:int):void {
        this._price = param1;
    }

    public function get tradability():int {
        return this._tradability;
    }

    public function set tradability(param1:int):void {
        this._tradability = param1;
    }

    public function get vipTradability():int {
        return this._vipTradability;
    }

    public function set vipTradability(param1:int):void {
        this._vipTradability = param1;
    }

    public function set isVipOnly(param1:Boolean):void {
        this._isVipOnly = param1;
    }

    public function get isVipOnly():Boolean {
        return this._isVipOnly;
    }

    public function get iconUrl():String {
        throw new Error("Should be implemented in sub class!");
    }

    public function set tip(param1:String):void {
        this._tip = param1;
    }

    public function get getTime():uint {
        return this._getTime;
    }

    public function set getTime(param1:uint):void {
        this._getTime = param1;
    }

    public function get tip():String {
        return this._tip;
    }

    public function getOccupiedSpace():int {
        return 1;
    }

    public function clone():Item {
        throw new Error("Should be implemented in sub class!");
    }

    public function toString():String {
        return "Name:" + this._name + " Id: " + this._referenceId + " UniqueId: " + this._uniqueId + " Quantity: " + this._quantity;
    }
}
}
