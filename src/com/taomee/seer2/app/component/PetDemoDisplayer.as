package com.taomee.seer2.app.component {
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.Loader;
import flash.display.MovieClip;
import flash.display.Sprite;

import org.taomee.utils.DomainUtil;

public class PetDemoDisplayer extends Sprite {

    private static const PET_LINKAGE_NAME:String = "pet";

    private static const BASE_WIDTH:Number = 326;

    private static const BASE_HEIGHT:Number = 326;


    private var _container:Sprite;

    private var _url:String;

    private var _complete:Function;

    private var _loader:Loader;

    private var _scaleParameter:int;

    private var _isPoint:Boolean;

    private var _isScale:Boolean;

    private var _scaleVal:Number;

    public function PetDemoDisplayer() {
        super();
        this.initialize();
    }

    private function initialize():void {
        this._container = new Sprite();
        addChild(this._container);
        this._loader = new Loader();
    }

    public function setUrl(param1:String, param2:Function, param3:int = 0, param4:Boolean = false, param5:Boolean = false):void {
        this._url = param1;
        this._scaleParameter = param3;
        this._complete = param2;
        this._isPoint = param4;
        this._isScale = param5;
        this.loadDemo();
    }

    public function newSetUrl(param1:String, param2:Number = 326, param3:Number = 326, param4:Function = null):void {
        this._url = param1;
        this._scaleVal = Math.min(param2 / BASE_WIDTH, param3 / BASE_HEIGHT);
        this._complete = param4;
        this.loadDemo();
    }

    public function clearDemo():void {
        DisplayObjectUtil.removeAllChildren(this._container);
    }

    public function killLoad():void {
        QueueLoader.cancel(this._url, null);
    }

    private function loadDemo():void {
        DisplayObjectUtil.removeAllChildren(this._container);
        QueueLoader.load(this._url, LoadType.DOMAIN, this.onLoadDemo);
    }

    private function onLoadDemo(param1:ContentInfo):void {
        DisplayObjectUtil.removeAllChildren(this._container);
        this.addDemo(DomainUtil.getMovieClip(PET_LINKAGE_NAME, param1.content));
        if (this._complete != null) {
            this._complete();
            this._complete = null;
        }
    }

    private function addDemo(param1:MovieClip):void {
        if (param1 != null) {
            param1.x = param1.y = 0;
            this._container.addChild(param1);
            param1.scaleX = param1.scaleY = this._scaleVal;
        }
    }
}
}
