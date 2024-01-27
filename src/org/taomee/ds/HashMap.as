package org.taomee.ds {
import flash.utils.Dictionary;

public class HashMap implements ICollection {


    private var _length:int;

    private var _weakKeys:Boolean;

    private var _content:Dictionary;

    public function HashMap(param1:Boolean = false) {
        super();
        _weakKeys = param1;
        _length = 0;
        _content = new Dictionary(param1);
    }

    public function containsKey(param1:*):Boolean {
        if (param1 in _content) {
            return true;
        }
        return false;
    }

    public function getValue(param1:*):* {
        var _loc2_:* = _content[param1];
        return _loc2_ === undefined ? null : _loc2_;
    }

    public function remove(param1:*):* {
        if (!(param1 in _content)) {
            return null;
        }
        var _loc2_:* = _content[param1];
        delete _content[param1];
        --_length;
        return _loc2_;
    }

    public function get weakKeys():Boolean {
        return _weakKeys;
    }

    public function clear():void {
        _length = 0;
        _content = new Dictionary(_weakKeys);
    }

    public function containsValue(param1:*):Boolean {
        var _loc2_:* = undefined;
        for each(_loc2_ in _content) {
            if (_loc2_ === param1) {
                return true;
            }
        }
        return false;
    }

    public function getValues():Array {
        var _loc3_:* = undefined;
        var _loc1_:Array = new Array(_length);
        var _loc2_:int = 0;
        for each(_loc3_ in _content) {
            _loc1_[_loc2_] = _loc3_;
            _loc2_++;
        }
        return _loc1_;
    }

    public function every(param1:Function):Boolean {
        var _loc2_:* = undefined;
        for (_loc2_ in _content) {
            if (!param1(_loc2_, _content[_loc2_])) {
                return false;
            }
        }
        return true;
    }

    public function clone():HashMap {
        var _loc2_:* = undefined;
        var _loc1_:HashMap = new HashMap(_weakKeys);
        for (_loc2_ in _content) {
            _loc1_.add(_loc2_, _content[_loc2_]);
        }
        return _loc1_;
    }

    public function eachKey(param1:Function):void {
        var _loc2_:* = undefined;
        for (_loc2_ in _content) {
            param1(_loc2_);
        }
    }

    public function add(param1:*, param2:*):* {
        var _loc3_:* = undefined;
        if (param1 == null) {
            throw new ArgumentError("cannot put a value with undefined or null key!");
        }
        if (param2 === undefined) {
            return null;
        }
        if (!(param1 in _content)) {
            ++_length;
        }
        _loc3_ = getValue(param1);
        _content[param1] = param2;
        return _loc3_;
    }

    public function isEmpty():Boolean {
        return _length == 0;
    }

    public function get length():int {
        return _length;
    }

    public function getKey(param1:*):* {
        var _loc2_:* = undefined;
        for (_loc2_ in _content) {
            if (_content[_loc2_] == param1) {
                return _loc2_;
            }
        }
        return null;
    }

    public function getKeys():Array {
        var _loc3_:* = undefined;
        var _loc1_:Array = new Array(_length);
        var _loc2_:int = 0;
        for (_loc3_ in _content) {
            _loc1_[_loc2_] = _loc3_;
            _loc2_++;
        }
        return _loc1_;
    }

    public function toString():String {
        var _loc5_:int = 0;
        var _loc1_:Array = getKeys();
        var _loc2_:Array = getValues();
        var _loc3_:int = int(_loc1_.length);
        var _loc4_:String = "HashMap Content:\n";
        _loc5_ = 0;
        while (_loc5_ < _loc3_) {
            _loc4_ += _loc1_[_loc5_] + " -> " + _loc2_[_loc5_] + "\n";
            _loc5_++;
        }
        return _loc4_;
    }

    public function eachValue(param1:Function):void {
        var _loc2_:* = undefined;
        for each(_loc2_ in _content) {
            param1(_loc2_);
        }
    }

    public function forEach(param1:Function):void {
        var _loc2_:* = undefined;
        for (_loc2_ in _content) {
            param1(_loc2_, _content[_loc2_]);
        }
    }

    public function filter(param1:Function):Array {
        var _loc3_:* = undefined;
        var _loc4_:* = undefined;
        var _loc2_:Array = [];
        for (_loc3_ in _content) {
            _loc4_ = _content[_loc3_];
            if (param1(_loc3_, _loc4_)) {
                _loc2_.push(_loc4_);
            }
        }
        return _loc2_;
    }

    public function some(param1:Function):Boolean {
        var _loc2_:* = undefined;
        for (_loc2_ in _content) {
            if (param1(_loc2_, _content[_loc2_])) {
                return true;
            }
        }
        return false;
    }
}
}
