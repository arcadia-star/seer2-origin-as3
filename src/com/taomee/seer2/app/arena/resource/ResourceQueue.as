package com.taomee.seer2.app.arena.resource {
import com.taomee.seer2.app.arena.resource.events.ResourceQueueEvent;
import com.taomee.seer2.core.cache.CacheManager;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.QueueLoader;

import flash.events.EventDispatcher;
import flash.events.ProgressEvent;

public class ResourceQueue extends EventDispatcher {


    private var _itemVec:Vector.<ResourceDefinition>;

    private var _cacheVec:Vector.<ResourceDefinition>;

    private var _isStart:Boolean;

    private var _loadedCount:int;

    private var _totalToLoad:int;

    private var _mainLoadedPercent:Number;

    private var _subLoadedPercent:Number;

    public function ResourceQueue() {
        super(this);
        this._itemVec = new Vector.<ResourceDefinition>();
        this._cacheVec = new Vector.<ResourceDefinition>();
        this._isStart = false;
        this._loadedCount = 0;
    }

    public function addItem(param1:String, param2:String, param3:Function):void {
        if (this._isStart == false) {
            this._itemVec.push(new ResourceDefinition(param1, param2, param3));
        }
    }

    public function addCache(param1:String, param2:String, param3:Function):void {
        if (this._isStart == false) {
            this._cacheVec.push(new ResourceDefinition(param1, param2, param3));
        }
    }

    public function startLoad():void {
        this._totalToLoad = this._itemVec.length + this._cacheVec.length;
        this._isStart = true;
        dispatchEvent(new ResourceQueueEvent(ResourceQueueEvent.QUEUE_START));
        this.startLoadResource();
        this.startLoadCache();
        this._mainLoadedPercent = 0;
        this._subLoadedPercent = 0;
    }

    private function startLoadResource():void {
        var _loc1_:ResourceDefinition = null;
        for each(_loc1_ in this._itemVec) {
            _loc1_.addEventListener(ProgressEvent.PROGRESS, this.onResourceProgress);
            _loc1_.addEventListener(ResourceQueueEvent.ITEM_COMPLETE, this.onResourceLoaded);
            QueueLoader.load(_loc1_.url, _loc1_.type, _loc1_.completeHandler, this.onResourceError, null, 2, null, _loc1_.progressHandler);
        }
    }

    private function startLoadCache():void {
        var _loc1_:ResourceDefinition = null;
        for each(_loc1_ in this._cacheVec) {
            _loc1_.addEventListener(ProgressEvent.PROGRESS, this.onResourceProgress);
            _loc1_.addEventListener(ResourceQueueEvent.ITEM_COMPLETE, this.onResourceLoaded);
            CacheManager.getContent(_loc1_.url, _loc1_.type, _loc1_.completeHandler, this.onResourceError, null, 2, null, _loc1_.progressHandler);
        }
    }

    private function onResourceProgress(param1:ProgressEvent):void {
        this._subLoadedPercent = param1.bytesLoaded / param1.bytesTotal;
        dispatchEvent(param1.clone());
    }

    public function getLoadedPercent():int {
        return int((this._mainLoadedPercent + this._subLoadedPercent / this._totalToLoad) * 100);
    }

    private function onResourceError(param1:ContentInfo):void {
        dispatchEvent(new ResourceQueueEvent(ResourceQueueEvent.QUEUE_ERROR));
        ++this._loadedCount;
        this._mainLoadedPercent = this._loadedCount / this._totalToLoad;
        this.checkQueueComplete();
    }

    private function onResourceLoaded(param1:ResourceQueueEvent):void {
        var _loc2_:ResourceDefinition = param1.target as ResourceDefinition;
        _loc2_.removeEventListener(ProgressEvent.PROGRESS, this.onResourceProgress);
        _loc2_.removeEventListener(ResourceQueueEvent.ITEM_COMPLETE, this.onResourceLoaded);
        ++this._loadedCount;
        this._mainLoadedPercent = this._loadedCount / this._totalToLoad;
        this.checkQueueComplete();
    }

    private function checkQueueComplete():void {
        if (this._loadedCount >= this._totalToLoad) {
            dispatchEvent(new ResourceQueueEvent(ResourceQueueEvent.QUEUE_COMPLETE));
        }
    }

    public function cancelAll():void {
        var _loc1_:ResourceDefinition = null;
        var _loc2_:ResourceDefinition = null;
        for each(_loc1_ in this._itemVec) {
            QueueLoader.cancel(_loc1_.url, _loc1_.completeHandler);
        }
        for each(_loc2_ in this._cacheVec) {
            CacheManager.cancel(_loc2_.url, _loc2_.type, _loc2_.completeHandler);
        }
        this._itemVec = new Vector.<ResourceDefinition>();
        this._cacheVec = new Vector.<ResourceDefinition>();
    }
}
}

import com.taomee.seer2.app.arena.resource.events.ResourceQueueEvent;
import com.taomee.seer2.core.loader.ContentInfo;

import flash.events.EventDispatcher;
import flash.events.ProgressEvent;

class ResourceDefinition extends EventDispatcher {


    public var type:String;

    public var url:String;

    private var _completeHandler:Function;

    public function ResourceDefinition(param1:String, param2:String, param3:Function) {
        super(this);
        this.type = param1;
        this.url = param2;
        this._completeHandler = param3;
    }

    public function completeHandler(param1:ContentInfo):void {
        this._completeHandler(param1);
        dispatchEvent(new ResourceQueueEvent(ResourceQueueEvent.ITEM_COMPLETE));
    }

    public function progressHandler(param1:ProgressEvent):void {
        dispatchEvent(param1.clone());
    }

    override public function toString():String {
        return "Type: " + this.type + " Url: " + this.url;
    }
}
