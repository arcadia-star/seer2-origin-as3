package com.taomee.seer2.core.loader {
import com.taomee.seer2.core.log.Logger;

import flash.events.ErrorEvent;
import flash.events.Event;
import flash.events.ProgressEvent;
import flash.system.ApplicationDomain;
import flash.utils.clearTimeout;
import flash.utils.setTimeout;

internal class QueueLoaderImpl {

    private static const SORT_NAME:String = "priority";

    private static const TIMEOUT_MAX:uint = 2;


    private var _waitList:Array;

    private var _isStop:Boolean = false;

    private var _loader:IntegrateLoader;

    private var _timeoutID:uint;

    private var _log:Logger;

    public function QueueLoaderImpl() {
        this._waitList = [];
        this._loader = new IntegrateLoader();
        super();
        this._log = Logger.getLogger("QueueLoader");
    }

    public function get currentInfo():QueueInfo {
        return this._loader.info;
    }

    public function get waitList():Array {
        return this._waitList;
    }

    public function load(param1:String, param2:String, param3:Function, param4:Function = null, param5:* = null, param6:int = 2, param7:Function = null, param8:Function = null, param9:Boolean = false):void {
        if (this.hasCompleteHandler(param1, param3)) {
            return;
        }
        var _loc10_:QueueInfo;
        (_loc10_ = new QueueInfo()).url = param1;
        _loc10_.type = param2;
        _loc10_.data = param5;
        _loc10_.priority = param6;
        _loc10_.completeHandler = param3;
        _loc10_.errorHandler = param4;
        _loc10_.openHandler = param7;
        _loc10_.progressHandler = param8;
        if (param9) {
            this._waitList.unshift(_loc10_);
        } else {
            this._waitList.push(_loc10_);
            this._waitList.sortOn(SORT_NAME, Array.NUMERIC);
        }
        if (param6 == QueuePriority.COERCE) {
            if (this._loader.info.priority != QueuePriority.COERCE) {
                this.nextLoad(true);
                return;
            }
        }
        this.nextLoad();
    }

    public function addBef(param1:String, param2:String):void {
        var _loc3_:QueueInfo = null;
        for each(_loc3_ in this._waitList) {
            if (_loc3_.url == param1) {
                return;
            }
        }
        _loc3_ = new QueueInfo();
        _loc3_.priority = QueuePriority.LOW;
        _loc3_.url = param1;
        _loc3_.type = param2;
        this._waitList.push(_loc3_);
        this.nextLoad();
    }

    public function pause():void {
        this._isStop = true;
        this.close();
    }

    public function resume():void {
        if (this._isStop) {
            this._isStop = false;
            this.nextLoad(true);
        }
    }

    public function cancelAll():void {
        var _loc1_:QueueInfo = null;
        this.close();
        for each(_loc1_ in this._waitList) {
            _loc1_.dispose();
        }
        this._waitList.length = 0;
    }

    public function cancel(param1:String, param2:Function):void {
        if (param2 == null) {
            return;
        }
        var _loc3_:QueueInfo = this._loader.info;
        if (_loc3_) {
            if (_loc3_.url == param1) {
                if (_loc3_.completeHandler == param2) {
                    this.close();
                }
            }
        }
        var _loc4_:int = int(this._waitList.length);
        var _loc5_:int = 0;
        while (_loc5_ < _loc4_) {
            _loc3_ = this._waitList[_loc5_];
            if (_loc3_.url == param1) {
                if (_loc3_.completeHandler == param2) {
                    this._waitList.splice(_loc5_, 1);
                    _loc3_.dispose();
                    break;
                }
            }
            _loc5_++;
        }
        this.nextLoad();
    }

    public function cancelURL(param1:String):void {
        var _loc2_:QueueInfo = this._loader.info;
        if (_loc2_) {
            if (_loc2_.url == param1) {
                this.close();
            }
        }
        this.removeURL(param1);
        this.nextLoad();
    }

    public function cancelHandler(param1:Function):void {
        if (param1 == null) {
            return;
        }
        var _loc2_:QueueInfo = this._loader.info;
        if (_loc2_) {
            if (_loc2_.completeHandler == param1) {
                this.close();
            }
        }
        this.removeHandler(param1);
        this.nextLoad();
    }

    public function cancelData(param1:String, param2:*, param3:String = null):void {
        if (param1 == null || param1 == "") {
            return;
        }
        var _loc4_:QueueInfo;
        if ((Boolean(_loc4_ = this._loader.info)) && _loc4_.data) {
            if (param3 == null) {
                if (param1 in _loc4_.data) {
                    if (_loc4_.data[param1] == param2) {
                        this.close();
                    }
                }
            } else if (_loc4_.url == param3) {
                if (param1 in _loc4_.data) {
                    if (_loc4_.data[param1] == param2) {
                        this.close();
                    }
                }
            }
        }
        this.removeData(param1, param2, param3);
        this.nextLoad();
    }

    public function hasCompleteHandlerFromData(param1:String, param2:String, param3:Function):Boolean {
        var _loc4_:QueueInfo = null;
        for each(_loc4_ in this._waitList) {
            if (_loc4_.url == param1 && _loc4_.data) {
                if (param2 in _loc4_.data) {
                    if (_loc4_.data[param2] == param3) {
                        return true;
                    }
                }
            }
        }
        return false;
    }

    private function hasCompleteHandler(param1:String, param2:Function):Boolean {
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

    private function close():void {
        this._loader.removeEventListener(Event.OPEN, this.onOpen);
        this._loader.removeEventListener(Event.COMPLETE, this.onComplete);
        this._loader.removeEventListener(ProgressEvent.PROGRESS, this.onProgress);
        this._loader.removeEventListener(ErrorEvent.ERROR, this.onError);
        this._loader.close();
    }

    private function removeURL(param1:String):void {
        var _loc4_:QueueInfo = null;
        var _loc2_:int = int(this._waitList.length);
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_) {
            if (_loc4_ = this._waitList[_loc3_]) {
                if (_loc4_.url == param1) {
                    this._waitList.splice(_loc3_, 1);
                    _loc3_--;
                    _loc4_.dispose();
                }
            }
            _loc3_++;
        }
    }

    private function removeHandler(param1:Function):void {
        var _loc4_:QueueInfo = null;
        var _loc2_:int = int(this._waitList.length);
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_) {
            if (_loc4_ = this._waitList[_loc3_]) {
                if (_loc4_.completeHandler == param1) {
                    this._waitList.splice(_loc3_, 1);
                    _loc3_--;
                    _loc4_.dispose();
                }
            }
            _loc3_++;
        }
    }

    private function removeData(param1:String, param2:*, param3:String = null):void {
        var _loc6_:QueueInfo = null;
        var _loc4_:int = int(this._waitList.length);
        var _loc5_:int = 0;
        while (_loc5_ < _loc4_) {
            if ((Boolean(_loc6_ = this._waitList[_loc5_])) && _loc6_.data) {
                if (param3 == null) {
                    if (param1 in _loc6_.data) {
                        if (_loc6_.data[param1] == param2) {
                            this._waitList.splice(_loc5_, 1);
                            _loc5_--;
                            _loc6_.dispose();
                        }
                    }
                } else if (_loc6_.url == param3) {
                    if (param1 in _loc6_.data) {
                        if (_loc6_.data[param1] == param2) {
                            this._waitList.splice(_loc5_, 1);
                            _loc5_--;
                            _loc6_.dispose();
                        }
                    }
                }
            }
            _loc5_++;
        }
    }

    private function nextLoad(param1:Boolean = false):void {
        var _loc2_:QueueInfo = null;
        if (param1) {
            this.close();
        } else if (this._loader.info) {
            return;
        }
        clearTimeout(this._timeoutID);
        if (this._isStop) {
            return;
        }
        if (this._waitList.length > 0) {
            this._loader.addEventListener(Event.OPEN, this.onOpen);
            this._loader.addEventListener(Event.COMPLETE, this.onComplete);
            this._loader.addEventListener(ProgressEvent.PROGRESS, this.onProgress);
            this._loader.addEventListener(ErrorEvent.ERROR, this.onError);
            _loc2_ = this._waitList[0];
            this._loader.load(_loc2_);
            this._timeoutID = setTimeout(this.onTimeout, 5000);
            if (_loc2_.openHandler != null) {
                _loc2_.openHandler(new ContentInfo(_loc2_.url, _loc2_.type, null, null, _loc2_.data));
            }
            this._log.info("nextLoad " + _loc2_.url);
        }
    }

    private function onTimeout():void {
        if (this._loader.info) {
            if (this._loader.info.timeCount >= TIMEOUT_MAX) {
                this.removeURL(this._loader.info.url);
            } else {
                ++this._loader.info.timeCount;
            }
            this.nextLoad(true);
        }
    }

    private function getOuts(param1:String):Array {
        var _loc5_:QueueInfo = null;
        var _loc2_:Array = [];
        var _loc3_:int = int(this._waitList.length);
        var _loc4_:int = 0;
        while (_loc4_ < _loc3_) {
            if (_loc5_ = this._waitList[_loc4_]) {
                if (_loc5_.url == param1) {
                    this._waitList.splice(_loc4_, 1);
                    _loc4_--;
                    _loc2_.push(_loc5_);
                }
            }
            _loc4_++;
        }
        return _loc2_;
    }

    private function onOpen(param1:Event):void {
        clearTimeout(this._timeoutID);
    }

    private function onComplete(param1:IntegrateLoaderEvent):void {
        var _loc2_:QueueInfo = this._loader.info;
        this.close();
        this._log.info("onComplete " + _loc2_.url);
        var _loc3_:Array = this.getOuts(_loc2_.url);
        this.nextLoad();
        this.outComplete(_loc3_, param1.content, param1.domain);
    }

    private function outComplete(param1:Array, param2:*, param3:ApplicationDomain):void {
        var _loc4_:QueueInfo = null;
        for each(_loc4_ in param1) {
            if (_loc4_.completeHandler != null) {
                _loc4_.completeHandler(new ContentInfo(_loc4_.url, _loc4_.type, param2, param3, _loc4_.data));
            }
            _loc4_.dispose();
        }
    }

    private function onError(param1:ErrorEvent):void {
        clearTimeout(this._timeoutID);
        var _loc2_:QueueInfo = this._loader.info;
        this.close();
        this._log.error(_loc2_.url);
        var _loc3_:Array = this.getOuts(_loc2_.url);
        this.nextLoad();
        this.outError(_loc3_);
    }

    private function outError(param1:Array):void {
        var _loc2_:QueueInfo = null;
        for each(_loc2_ in param1) {
            if (_loc2_.errorHandler != null) {
                _loc2_.errorHandler(new ContentInfo(_loc2_.url, _loc2_.type, null, null, _loc2_.data));
            }
            _loc2_.dispose();
        }
    }

    private function onProgress(param1:ProgressEvent):void {
        var _loc2_:QueueInfo = this._loader.info;
        if (_loc2_.progressHandler != null) {
            _loc2_.progressHandler(param1);
        }
    }
}
}
