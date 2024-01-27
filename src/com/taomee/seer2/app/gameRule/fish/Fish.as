package com.taomee.seer2.app.gameRule.fish {
public class Fish {


    private var _id:uint;

    private var _name:String;

    private var _description:String;

    private var _minWeight:Number;

    private var _maxWeight:Number;

    private var _minLength:Number;

    private var _maxLength:Number;

    private var _mapIds:Array;

    public function Fish() {
        super();
    }

    public function get id():uint {
        return this._id;
    }

    public function set id(param1:uint):void {
        this._id = param1;
    }

    public function get name():String {
        return this._name;
    }

    public function set name(param1:String):void {
        this._name = param1;
    }

    public function get description():String {
        return this._description;
    }

    public function set description(param1:String):void {
        this._description = param1;
    }

    public function get minWeight():Number {
        return this._minWeight;
    }

    public function set minWeight(param1:Number):void {
        this._minWeight = param1;
    }

    public function get maxWeight():Number {
        return this._maxWeight;
    }

    public function set maxWeight(param1:Number):void {
        this._maxWeight = param1;
    }

    public function get minLength():Number {
        return this._minLength;
    }

    public function set minLength(param1:Number):void {
        this._minLength = param1;
    }

    public function get maxLength():Number {
        return this._maxLength;
    }

    public function set maxLength(param1:Number):void {
        this._maxLength = param1;
    }

    public function get mapIds():Array {
        return this._mapIds;
    }

    public function set mapIds(param1:Array):void {
        this._mapIds = param1;
    }
}
}
