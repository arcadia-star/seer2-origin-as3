package org.taomee.ds {
import flash.utils.Dictionary;

public class DHash implements ICollection {


    private var _contentKey:Dictionary;

    private var _length:int;

    private var _contentValue:Dictionary;

    private var _weakKeys:Boolean;

    public function DHash(param1:Boolean = false) {
        super();
        _weakKeys = param1;
        _length = 0;
        _contentKey = new Dictionary(param1);
        _contentValue = new Dictionary(param1);
    }

    public function containsKey(param1:*):Boolean {
        return param1 in _contentKey;
    }

    public function isEmpty():Boolean {
        return _length == 0;
    }

    public function clear():void {
        _length = 0;
        _contentKey = new Dictionary(_weakKeys);
        _contentValue = new Dictionary(_weakKeys);
    }

    public function containsValue(param1:*):Boolean {
        return param1 in _contentValue;
    }

    public function removeForValue(param1:*):* {
        var _loc2_:* = undefined;
        if (param1 in _contentValue) {
            _loc2_ = _contentValue[param1];
            delete _contentValue[param1];
            delete _contentKey[_loc2_];
            --_length;
            return _loc2_;
        }
        return null;
    }

    public function addForKey(param1:*, param2:*):* {
        var _loc3_:* = undefined;
        if (param1 == null) {
            throw new ArgumentError("cannot put a value with undefined or null key!");
        }
        if (param2 === undefined) {
            return null;
        }
        if (!(param1 in _contentKey)) {
            ++_length;
        }
        _loc3_ = getValue(param1);
        delete _contentValue[_loc3_];
        _contentKey[param1] = param2;
        _contentValue[param2] = param1;
        return _loc3_;
    }

    public function getValues():Array {
        var _loc3_:* = undefined;
        var _loc1_:Array = new Array(_length);
        var _loc2_:int = 0;
        for each(_loc3_ in _contentKey) {
            _loc1_[_loc2_] = _loc3_;
            _loc2_++;
        }
        return _loc1_;
    }

    public function clone():DHash {
        var _loc2_:* = undefined;
        var _loc1_:DHash = new DHash(_weakKeys);
        for (_loc2_ in _contentKey) {
            _loc1_.addForKey(_loc2_, _contentKey[_loc2_]);
        }
        return _loc1_;
    }

    public function contains(param1:*):Boolean {
        if (param1 in _contentKey) {
            return true;
        }
        if (param1 in _contentValue) {
            return true;
        }
        return false;
    }

    public function eachKey(param1:Function):void {
        var _loc2_:* = undefined;
        for each(_loc2_ in _contentValue) {
            param1(_loc2_);
        }
    }

    public function getKey(param1:*):* {
        var _loc2_:* = _contentValue[param1];
        return _loc2_ === undefined ? null : _loc2_;
    }

    public function forEach(param1:Function):void {
        var _loc2_:* = undefined;
        for (_loc2_ in _contentKey) {
            param1(_loc2_, _contentKey[_loc2_]);
        }
    }

    public function get length():int {
        return _length;
    }

    public function eachValue(param1:Function):void {
        var _loc2_:* = undefined;
        for each(_loc2_ in _contentKey) {
            param1(_loc2_);
        }
    }

    public function getKeys():Array {
        var _loc3_:* = undefined;
        var _loc1_:Array = new Array(_length);
        var _loc2_:int = 0;
        for each(_loc3_ in _contentValue) {
            _loc1_[_loc2_] = _loc3_;
            _loc2_++;
        }
        return _loc1_;
    }

    public function addForValue(param1:*, param2:*):* {
        var _loc3_:* = undefined;
        if (param1 == null) {
            throw new ArgumentError("cannot put a key with undefined or null value!");
        }
        if (param2 === undefined) {
            return null;
        }
        if (!(param1 in _contentValue)) {
            ++_length;
        }
        _loc3_ = getKey(param1);
        delete _contentKey[_loc3_];
        _contentValue[param1] = param2;
        _contentKey[param2] = param1;
        return _loc3_;
    }

    public function removeForKey(param1:*):* {
        var _loc2_:* = undefined;
        if (param1 in _contentKey) {
            _loc2_ = _contentKey[param1];
            delete _contentKey[param1];
            delete _contentValue[_loc2_];
            --_length;
            return _loc2_;
        }
        return null;
    }

    public function getValue(param1:*):* {
        var _loc2_:* = _contentKey[param1];
        return _loc2_ === undefined ? null : _loc2_;
    }
}
}
