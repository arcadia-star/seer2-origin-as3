package com.taomee.seer2.core.map.grids {
import flash.display.Loader;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.net.URLRequest;
import flash.system.LoaderContext;
import flash.utils.ByteArray;

public class BaseLoader extends EventDispatcher {


    protected var _url:String;

    protected var _loader:Loader;

    protected var _name:String;

    protected var _type:String;

    public function BaseLoader() {
        super();
    }

    public function load(param1:String, param2:LoaderContext = null):void {
        this._url = param1;
        this._loader = new Loader();
        this._loader.load(new URLRequest(param1), param2);
        this.addEvent();
    }

    public function loadBytes(param1:ByteArray, param2:LoaderContext = null):void {
        this._loader = new Loader();
        this._loader.loadBytes(param1, param2);
        this.addEvent();
    }

    protected function addEvent():void {
        this._loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, this.progressFun);
        this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.completeFun);
        this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.ioErrorFun);
    }

    protected function delEvent():void {
        this._loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, this.progressFun);
        this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.completeFun);
        this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.ioErrorFun);
    }

    protected function completeFun(param1:Event):void {
        dispatchEvent(param1);
        this.delEvent();
    }

    protected function progressFun(param1:ProgressEvent):void {
        dispatchEvent(param1);
    }

    protected function ioErrorFun(param1:Event):void {
    }

    public function clear():void {
        this._loader.unload();
        this._loader = null;
        HeptaFishGC.gc();
    }

    public function get url():String {
        return this._url;
    }

    public function set url(param1:String):void {
        this._url = param1;
    }

    public function get name():String {
        return this._name;
    }

    public function set name(param1:String):void {
        this._name = param1;
    }

    public function get loader():Loader {
        return this._loader;
    }

    public function get type():String {
        return this._type;
    }
}
}
