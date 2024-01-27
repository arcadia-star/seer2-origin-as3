package com.taomee.seer2.core.cache {
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.QueueInfo;
import com.taomee.seer2.core.loader.QueueLoader;

internal class CacheImpl {


    public var maxCount:uint;

    public var name:String = "item";

    protected var _cacheList:Array;

    protected var _waitList:Array;

    public function CacheImpl() {
        this._cacheList = [];
        this._waitList = [];
        super();
    }

    public function dispose():void {
        this.clear();
        this._waitList = null;
        this._cacheList = null;
    }

    public function clear():void {
        var _loc1_:QueueInfo = null;
        var _loc2_:CacheInfo = null;
        for each(_loc1_ in this._waitList) {
            _loc1_.dispose();
        }
        for each(_loc2_ in this._cacheList) {
            _loc2_.dispose();
        }
    }

    public function getContent(param1:String, param2:String, param3:Function, param4:Function = null, param5:* = null, param6:int = 2, param7:Function = null, param8:Function = null):void {
        var _loc9_:CacheInfo = null;
        for each(_loc9_ in this._cacheList) {
            if (_loc9_.url == param1) {
                this.parseOutput(param1, param2, param3, _loc9_, param5);
                return;
            }
        }
        if (this.hasWaitList(param1, param3)) {
            return;
        }
        var _loc10_:QueueInfo;
        (_loc10_ = new QueueInfo()).url = param1;
        _loc10_.type = param2;
        _loc10_.data = param5;
        _loc10_.completeHandler = param3;
        _loc10_.errorHandler = param4;
        this._waitList.push(_loc10_);
        QueueLoader.load(param1, param2, this.onComplete, this.onError, param5, param6, param7, param8);
    }

    public function cancel(param1:String, param2:Function):void {
        var _loc5_:QueueInfo = null;
        var _loc3_:Boolean = false;
        var _loc4_:int = int(this._waitList.length);
        var _loc6_:int = 0;
        while (_loc6_ < _loc4_) {
            if ((_loc5_ = this._waitList[_loc6_]).url == param1) {
                if (_loc5_.completeHandler == param2) {
                    this._waitList.splice(_loc6_, 1);
                    _loc5_.dispose();
                    _loc3_ = true;
                    break;
                }
            }
            _loc6_++;
        }
        if (_loc3_ == false) {
            return;
        }
        for each(_loc5_ in this._waitList) {
            if (_loc5_.url == param1) {
                return;
            }
        }
        QueueLoader.cancel(param1, this.onComplete);
    }

    private function hasWaitList(param1:String, param2:Function):Boolean {
        var _loc3_:QueueInfo = null;
        for each(_loc3_ in this._waitList) {
            if (_loc3_.url == param1) {
                if (_loc3_.completeHandler == param2) {
                    return true;
                }
            }
        }
        return false;
    }

    private function addCache(param1:CacheInfo):void {
        var _loc2_:int = int(this._cacheList.length);
        if (_loc2_ > this.maxCount) {
            this.parseCache(this._cacheList);
        }
        this._cacheList.push(param1);
    }

    private function onError(param1:ContentInfo):void {
        var _loc4_:QueueInfo = null;
        var _loc2_:int = int(this._waitList.length);
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_) {
            if (_loc4_ = this._waitList[_loc3_]) {
                if (_loc4_.url == param1.url) {
                    this._waitList.splice(_loc3_, 1);
                    _loc3_--;
                    if (_loc4_.errorHandler != null) {
                        _loc4_.errorHandler(new ContentInfo(_loc4_.url, param1.type, null, null, _loc4_.data));
                    }
                    _loc4_.dispose();
                }
            }
            _loc3_++;
        }
    }

    protected function onComplete(param1:ContentInfo):void {
        var _loc4_:QueueInfo = null;
        var _loc5_:CacheInfo = null;
        var _loc6_:CacheInfo = null;
        var _loc2_:int = int(this._waitList.length);
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_) {
            if (_loc4_ = this._waitList[_loc3_]) {
                if (_loc4_.url == param1.url) {
                    this._waitList.splice(_loc3_, 1);
                    _loc3_--;
                    for each(_loc6_ in this._cacheList) {
                        if (_loc6_.url == _loc4_.url) {
                            _loc5_ = _loc6_;
                            break;
                        }
                    }
                    if (_loc5_ == null) {
                        (_loc5_ = new CacheInfo()).url = _loc4_.url;
                        this.parseContent(_loc5_, param1);
                        this.addCache(_loc5_);
                    }
                    if (_loc4_.completeHandler != null) {
                        this.parseOutput(_loc4_.url, param1.type, _loc4_.completeHandler, _loc5_, _loc4_.data);
                    }
                    _loc4_.dispose();
                }
            }
            _loc3_++;
        }
    }

    protected function parseOutput(param1:String, param2:String, param3:Function, param4:CacheInfo, param5:* = null):void {
        param3(new ContentInfo(param1, param2, param4.content, param4.domain, param5));
    }

    protected function parseCache(param1:Array):void {
        var _loc2_:CacheInfo = param1.shift();
        _loc2_.dispose();
    }

    protected function parseContent(param1:CacheInfo, param2:ContentInfo):void {
        param1.content = param2.content;
        param1.domain = param2.domain;
    }
}
}
