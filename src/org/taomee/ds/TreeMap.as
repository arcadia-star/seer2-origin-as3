package org.taomee.ds {
public class TreeMap implements ITree {


    private var _root:TreeMap;

    private var _data:*;

    private var _parent:TreeMap;

    private var _children:HashMap;

    private var _key:*;

    public function TreeMap(param1:*, param2:* = null, param3:TreeMap = null) {
        super();
        _key = param1;
        _data = param2;
        _children = new HashMap();
        this.parent = param3;
    }

    public function get depth():int {
        if (_parent == null) {
            return 0;
        }
        var _loc1_:TreeMap = _parent;
        var _loc2_:int = 0;
        while (_loc1_) {
            _loc2_++;
            _loc1_ = _loc1_.parent;
            if (_loc1_ == this) {
                throw new Error("TreeMap Infinite Loop");
            }
        }
        return _loc2_;
    }

    public function remove():void {
        if (_parent == null) {
            return;
        }
        _children.eachValue(function (param1:TreeMap):void {
            param1.parent = _parent;
        });
    }

    public function get parent():TreeMap {
        return _parent;
    }

    public function clear():void {
        _children = new HashMap();
    }

    public function set data(param1:*):void {
        _data = param1;
    }

    public function get numSiblings():int {
        if (_parent) {
            return _parent.numChildren;
        }
        return 0;
    }

    public function get key():* {
        return _key;
    }

    public function get root():TreeMap {
        return _root;
    }

    public function set parent(param1:TreeMap):void {
        if (_parent) {
            _parent.children.remove(_key);
        }
        if (param1 == this) {
            return;
        }
        _parent = param1;
        if (_parent) {
            _parent.children.add(_key, this);
        }
        setRoot();
    }

    private function setRoot():void {
        if (_parent == null) {
            _root = this;
            return;
        }
        var _loc1_:TreeMap = _parent;
        while (_loc1_) {
            if (_loc1_.parent == null) {
                _root = _loc1_;
                return;
            }
            _loc1_ = _loc1_.parent;
            if (_loc1_ == this) {
                throw new Error("TreeMap Infinite Loop");
            }
        }
    }

    public function get length():int {
        var _loc1_:int = numChildren;
        var _loc2_:TreeMap = _parent;
        while (_loc2_) {
            _loc1_ += _loc2_.numChildren;
            _loc2_ = _loc2_.parent;
            if (_loc2_ == this) {
                throw new Error("TreeMap Infinite Loop");
            }
        }
        return _loc1_;
    }

    public function get isLeaf():Boolean {
        return _children.length == 0;
    }

    public function get data():* {
        return _data;
    }

    public function get isRoot():Boolean {
        return _root == this;
    }

    public function get numChildren():int {
        return _children.length;
    }

    public function set key(param1:*):void {
        if (_parent) {
            _parent.children.remove(_key);
            _parent.children.add(param1, this);
        }
        _key = param1;
    }

    public function get children():HashMap {
        return _children;
    }
}
}
