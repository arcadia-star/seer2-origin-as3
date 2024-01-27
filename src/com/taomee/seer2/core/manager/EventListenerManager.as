package com.taomee.seer2.core.manager {
import flash.utils.Dictionary;

import org.taomee.ds.HashSet;
import org.taomee.utils.DictionaryUtil;

public class EventListenerManager {


    private var eventRegister:Dictionary;

    public function EventListenerManager() {
        super();
        this.eventRegister = new Dictionary(true);
    }

    public function addEventListener(param1:*, param2:String, param3:Function, param4:Boolean = false, param5:int = 0, param6:Boolean = false):void {
        if (param1 == null) {
            return;
        }
        this.registerEventListener(param1, param2, param3);
        param1.addEventListener(param2, param3, param4, param5, param6);
    }

    public function removeEventListener(param1:*, param2:String = null, param3:Function = null):void {
        var _loc5_:String = null;
        var _loc6_:String = null;
        var _loc7_:HashSet = null;
        var _loc8_:Array = null;
        var _loc9_:Function = null;
        if (!param1) {
            throw new Error("传入的object不能为null！");
        }
        if (null != param2 && null != param3) {
            param1.removeEventListener(param2, param3, false);
            param1.removeEventListener(param2, param3, true);
        }
        var _loc4_:Dictionary = this.getTargetListeners(param1);
        if (null == param2) {
            if (_loc4_) {
                for (_loc5_ in _loc4_) {
                    _loc6_ = _loc5_;
                    if (param2 == null || param2 == _loc6_) {
                        if (_loc7_ = _loc4_[_loc5_]) {
                            _loc8_ = _loc7_.toArray();
                            while (_loc8_.length != 0) {
                                _loc9_ = _loc8_[0];
                                if (param3 == null || param3 == _loc9_) {
                                    param1.removeEventListener(_loc6_, _loc9_, false);
                                    param1.removeEventListener(_loc6_, _loc9_, true);
                                    _loc7_.remove(_loc9_);
                                }
                                _loc8_.pop();
                            }
                            if (_loc7_.length == 0) {
                                delete _loc4_[_loc5_];
                            }
                        }
                    }
                }
                if (DictionaryUtil.getKeys(_loc4_).length == 0) {
                    delete this.eventRegister[param1];
                }
            }
        }
    }

    public function clear():void {
        var _loc1_:* = undefined;
        for (_loc1_ in this.eventRegister) {
            this.removeEventListener(_loc1_);
        }
    }

    private function registerEventListener(param1:*, param2:String, param3:Function):void {
        this.getTargetFunctions(param1, param2).add(param3);
    }

    private function getTargetListeners(param1:*, param2:Boolean = false):Dictionary {
        if (!this.eventRegister[param1]) {
            if (!param2) {
                return null;
            }
            this.eventRegister[param1] = new Dictionary();
        }
        return this.eventRegister[param1] as Dictionary;
    }

    private function getTargetFunctions(param1:*, param2:*):HashSet {
        var _loc3_:Dictionary = this.getTargetListeners(param1, true);
        if (!_loc3_[param2]) {
            _loc3_[param2] = new HashSet();
        }
        return _loc3_[param2] as HashSet;
    }
}
}
