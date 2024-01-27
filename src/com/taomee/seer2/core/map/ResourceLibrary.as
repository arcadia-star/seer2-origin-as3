package com.taomee.seer2.core.map {
import flash.display.BitmapData;
import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.media.Sound;
import flash.system.ApplicationDomain;

import org.taomee.utils.DomainUtil;

public class ResourceLibrary {


    private var _domain:ApplicationDomain;

    public function ResourceLibrary(param1:ApplicationDomain) {
        super();
        this._domain = param1;
    }

    public function getClass(param1:String):Class {
        return DomainUtil.getClass(param1, this._domain);
    }

    public function getMovieClip(param1:String):MovieClip {
        return DomainUtil.getMovieClip(param1, this._domain);
    }

    public function getButton(param1:String):SimpleButton {
        return DomainUtil.getSimpleButton(param1, this._domain);
    }

    public function getBitmapData(param1:String):BitmapData {
        return DomainUtil.getBitmapData(param1, this._domain);
    }

    public function getSound(param1:String):Sound {
        return DomainUtil.getSound(param1, this._domain);
    }

    public function getSprite(param1:String):Sprite {
        return DomainUtil.getSprite(param1, this._domain);
    }

    public function dispose():void {
        this._domain = null;
    }
}
}
