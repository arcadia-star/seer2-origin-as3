package org.taomee.ds {
public class TreeSet implements ITree {


    private var _root:TreeSet;

    private var _data:*;

    private var _parent:TreeSet;

    private var _children:HashSet;

    public function TreeSet(param1:* = null, param2:TreeSet = null) {
        super();
        _data = param1;
        _children = new HashSet();
        this.parent = param2;
    }

    public function get depth():int {
        if (!_parent) {
            return 0;
        }
        var _loc1_:TreeSet = _parent;
        var _loc2_:int = 0;
        while (_loc1_) {
            _loc2_++;
            _loc1_ = _loc1_.parent;
            if (_loc1_ == this) {
                throw new Error("TreeSet Infinite Loop");
            }
        }
        return _loc2_;
    }

    public function remove():void {
        if (_parent == null) {
            return;
        }
        _children.forEach(function (param1:TreeSet):void {
            param1.parent = _parent;
        });
    }

    public function clear():void {
        _children = new HashSet();
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

    public function get root():TreeSet {
        return _root;
    }

    public function set parent(param1:TreeSet):void {
        if (_parent) {
            _parent.children.remove(this);
        }
        if (param1 == this) {
            return;
        }
        _parent = param1;
        if (_parent) {
            _parent.children.add(this);
        }
        setRoot();
    }

    private function setRoot():void {
        if (_parent == null) {
            _root = this;
            return;
        }
        var _loc1_:TreeSet = _parent;
        while (_loc1_) {
            if (_loc1_.parent == null) {
                _root = _loc1_;
                return;
            }
            _loc1_ = _loc1_.parent;
            if (_loc1_ == this) {
                throw new Error("TreeSet Infinite Loop");
            }
        }
    }

    public function get length():int {
        var _loc1_:int = numChildren;
        var _loc2_:TreeSet = _parent;
        while (_loc2_) {
            _loc1_ += _loc2_.numChildren;
            _loc2_ = _loc2_.parent;
            if (_loc2_ == this) {
                throw new Error("TreeSet Infinite Loop");
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

    public function get parent():TreeSet {
        return _parent;
    }

    public function get children():HashSet {
        return _children;
    }
}
}
