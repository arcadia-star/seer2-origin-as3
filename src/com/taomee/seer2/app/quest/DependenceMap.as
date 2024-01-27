package com.taomee.seer2.app.quest {
import org.taomee.ds.HashMap;

public class DependenceMap {


    private var _dependentMap:HashMap;

    private var _dependMap:HashMap;

    public function DependenceMap() {
        super();
        this._dependentMap = new HashMap();
        this._dependMap = new HashMap();
    }

    public function addPreviousDepend(param1:int, param2:Vector.<int>):void {
        var _loc4_:int = 0;
        var _loc3_:Number = 1 / param2.length;
        for each(_loc4_ in param2) {
            this.addDependence(_loc4_, param1, _loc3_);
        }
    }

    private function addDependence(param1:int, param2:int, param3:Number):void {
        if (!this._dependentMap.containsKey(param1)) {
            this._dependentMap.add(param1, new Vector.<DependenceNode>());
        }
        var _loc4_:Vector.<DependenceNode> = this._dependentMap.getValue(param1) as Vector.<DependenceNode>;
        this.addDependenceNode(_loc4_, new DependenceNode(param2, param3));
    }

    public function completeDependent(param1:int):Vector.<int> {
        var _loc4_:DependenceNode = null;
        var _loc5_:Vector.<DependenceNode> = null;
        var _loc2_:Vector.<DependenceNode> = this._dependentMap.getValue(param1);
        var _loc3_:Vector.<int> = new Vector.<int>();
        if (_loc2_) {
            for each(_loc4_ in _loc2_) {
                if (!this._dependMap.containsKey(_loc4_.id)) {
                    this._dependMap.add(_loc4_.id, new Vector.<DependenceNode>());
                }
                _loc5_ = this._dependMap.getValue(_loc4_.id) as Vector.<DependenceNode>;
                this.addDependenceNode(_loc5_, new DependenceNode(param1, _loc4_.weighing));
                if (this.isDependNodeOpen(_loc4_.id)) {
                    _loc3_.push(_loc4_.id);
                }
            }
        }
        return _loc3_;
    }

    private function addDependenceNode(param1:Vector.<DependenceNode>, param2:DependenceNode):void {
        if (!this.containsNode(param1, param2)) {
            param1.push(param2);
        }
    }

    private function containsNode(param1:Vector.<DependenceNode>, param2:DependenceNode):Boolean {
        var _loc3_:DependenceNode = null;
        for each(_loc3_ in param1) {
            if (_loc3_.id == param2.id) {
                return true;
            }
        }
        return false;
    }

    private function isDependNodeOpen(param1:int):Boolean {
        var _loc3_:Number = NaN;
        var _loc4_:DependenceNode = null;
        var _loc2_:Vector.<DependenceNode> = this._dependMap.getValue(param1) as Vector.<DependenceNode>;
        if (_loc2_) {
            _loc3_ = 0;
            for each(_loc4_ in _loc2_) {
                _loc3_ += _loc4_.weighing;
            }
            return _loc3_ > 0.99;
        }
        return false;
    }
}
}

class DependenceNode {


    public var id:int;

    public var weighing:Number;

    public function DependenceNode(param1:int, param2:Number) {
        super();
        this.id = param1;
        this.weighing = param2;
    }
}
