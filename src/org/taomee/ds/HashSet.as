package org.taomee.ds {
import flash.utils.Dictionary;

public class HashSet implements ICollection {


    private var _length:int;

    private var _weakKeys:Boolean;

    private var _content:Dictionary;

    public function HashSet(param1:Boolean = false) {
        super();
        _weakKeys = param1;
        _content = new Dictionary(param1);
        _length = 0;
    }

    public function addAll(param1:Array):void {
        var _loc2_:* = undefined;
        for each(_loc2_ in param1) {
            add(_loc2_);
        }
    }

    public function add(param1:*):void {
        if (param1 === undefined) {
            return;
        }
        if (!(param1 in _content)) {
            ++_length;
        }
        _content[param1] = param1;
    }

    public function containsAll(param1:Array):Boolean {
        var _loc3_:int = 0;
        var _loc2_:int = int(param1.length);
        _loc3_ = 0;
        while (_loc3_ < _loc2_) {
            if (!(param1[_loc3_] in _content)) {
                return false;
            }
            _loc3_++;
        }
        return true;
    }

    public function isEmpty():Boolean {
        return _length == 0;
    }

    public function remove(param1:*):Boolean {
        if (param1 in _content) {
            delete _content[param1];
            --_length;
            return true;
        }
        return false;
    }

    public function get length():int {
        return _length;
    }

    public function every(param1:Function):Boolean {
        var _loc2_:* = undefined;
        for each(_loc2_ in _content) {
            if (!param1(_loc2_)) {
                return false;
            }
        }
        return true;
    }

    public function clone():HashSet {
        var _loc2_:* = undefined;
        var _loc1_:HashSet = new HashSet(_weakKeys);
        for each(_loc2_ in _content) {
            _loc1_.add(_loc2_);
        }
        return _loc1_;
    }

    public function forEach(param1:Function):void {
        var _loc2_:* = undefined;
        for each(_loc2_ in _content) {
            param1(_loc2_);
        }
    }

    public function some(param1:Function):Boolean {
        var _loc2_:* = undefined;
        for each(_loc2_ in _content) {
            if (param1(_loc2_)) {
                return true;
            }
        }
        return false;
    }

    public function clear():void {
        _content = new Dictionary(_weakKeys);
        _length = 0;
    }

    public function removeAll(param1:Array):void {
        var _loc2_:* = undefined;
        for each(_loc2_ in param1) {
            remove(_loc2_);
        }
    }

    public function toArray():Array {
        var _loc3_:* = undefined;
        var _loc1_:Array = new Array(_length);
        var _loc2_:int = 0;
        for each(_loc3_ in _content) {
            _loc1_[_loc2_] = _loc3_;
            _loc2_++;
        }
        return _loc1_;
    }

    public function contains(param1:*):Boolean {
        return param1 in _content;
    }
}
}
