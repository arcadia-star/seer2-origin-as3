package test {

import flash.display.Loader;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.ProgressEvent;
import flash.events.TextEvent;
import flash.net.URLRequest;
import flash.net.URLStream;
import flash.system.ApplicationDomain;
import flash.system.LoaderContext;
import flash.utils.ByteArray;

internal class DLLLoader extends EventDispatcher {

    public static var size:uint = 0;


    private var _dllList:Array;

    private var _stream:URLStream;

    private var _loader:Loader;

    private var _isDebug:Boolean = false;

    private var _rootURL:String;

    private var _index:uint = 0;

    private var _len:uint = 0;

    public function DLLLoader() {
        super();
        this._stream = new URLStream();
        this._stream.addEventListener(Event.OPEN, this.onOpen);
        this._stream.addEventListener(Event.COMPLETE, this.onComplete);
        this._stream.addEventListener(ProgressEvent.PROGRESS, this.onProgressHandler);
        this._loader = new Loader();
        this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onLoaderOver);
    }

    public function doLoad(param1:XML, param2:String, param3:Boolean = false):void {
        var _loc5_:XML = null;
        var _loc6_:DLLInfo = null;
        this._dllList = [];
        this._isDebug = param3;
        this._rootURL = param2;
        var _loc4_:XMLList = param1.elements();
        for each(_loc5_ in _loc4_) {
            (_loc6_ = new DLLInfo()).name = _loc5_.@name;
            _loc6_.path = _loc5_.@path;
            this._dllList.push(_loc6_);
        }
        this._len = this._dllList.length;
        this.beginLoad();
    }

    public function beginLoad():void {
        var _loc1_:DLLInfo = null;
        if (this._dllList.length > 0) {
            _loc1_ = this._dllList[0];
            this._stream.load(new URLRequest(this._rootURL + _loc1_.path));
            ++this._index;
        } else {
            this._stream.removeEventListener(Event.OPEN, this.onOpen);
            this._stream.removeEventListener(Event.COMPLETE, this.onComplete);
            this._stream.removeEventListener(ProgressEvent.PROGRESS, this.onProgressHandler);
            this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.onLoaderOver);
            this._loader = null;
            this._stream = null;
            dispatchEvent(new Event(Event.COMPLETE));
        }
    }

    private function onOpen(param1:Event):void {
        var _loc2_:DLLInfo = this._dllList[0];
        dispatchEvent(new TextEvent(Event.OPEN, false, false, "加载" + _loc2_.name));
    }

    private function onProgressHandler(param1:ProgressEvent):void {
        var _loc2_:Number = param1.bytesLoaded / param1.bytesTotal;
        var _loc3_:ProgressEvent = new ProgressEvent(ProgressEvent.PROGRESS);
        _loc3_.bytesLoaded = this._index - 1 + _loc2_;
        _loc3_.bytesTotal = this._len;
        dispatchEvent(_loc3_);
    }

    private function onComplete(param1:Event):void {
        var _loc2_:DLLInfo = this._dllList[0];
        var _loc3_:ByteArray = new ByteArray();
        if (this._isDebug == false) {
            this._stream.readBytes(new ByteArray(), 0, 7);
        }
        this._stream.readBytes(_loc3_);
        if (this._isDebug == false) {
            _loc3_.uncompress();
        }
        this._stream.close();
        var _loc4_:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
        this._loader.loadBytes(_loc3_, _loc4_);
    }

    private function onLoaderOver(param1:Event):void {
        this._dllList.shift();
        this.beginLoad();
    }
}
}

class DLLInfo {


    public var name:String;

    public var path:String;

    public function DLLInfo() {
        super();
    }
}
