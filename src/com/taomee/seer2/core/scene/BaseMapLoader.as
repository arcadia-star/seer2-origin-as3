package com.taomee.seer2.core.scene {
import com.taomee.seer2.core.map.ResourceLibrary;

import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.EventDispatcher;

public class BaseMapLoader extends EventDispatcher {


    protected var _configXml:XML;

    protected var _dataXml:XML;

    protected var _mapResource:Sprite;

    protected var _libManager:ResourceLibrary;

    protected var _xmlUrl:String;

    protected var _swfUrl:String;

    protected var _dataUrl:String;

    protected var _imgUrl:String;

    protected var _resourceId:int;

    protected var _mapBitmapData:BitmapData;

    public function BaseMapLoader() {
        super();
    }

    public function load(param1:int):void {
    }

    public function dispose():void {
        this._configXml = null;
        this._dataXml = null;
        this._mapResource = null;
        this._libManager = null;
    }

    public function get configXml():XML {
        return this._configXml;
    }

    public function get dataXml():XML {
        return this._dataXml;
    }

    public function get mapResource():Sprite {
        return this._mapResource;
    }

    public function get libManager():ResourceLibrary {
        return this._libManager;
    }

    public function get mapBitmapData():BitmapData {
        return this._mapBitmapData;
    }
}
}
