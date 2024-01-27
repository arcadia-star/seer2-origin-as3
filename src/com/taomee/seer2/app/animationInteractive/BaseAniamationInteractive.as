package com.taomee.seer2.app.animationInteractive {
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.UILoader;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.MouseEvent;
import flash.media.Sound;
import flash.system.ApplicationDomain;

import org.taomee.utils.DomainUtil;

public class BaseAniamationInteractive extends EventDispatcher {


    protected var _animation:MovieClip;

    protected var _closeBtn:SimpleButton;

    private var _domain:ApplicationDomain;

    protected var _isSuccess:Boolean;

    protected var _callBack:Function;

    public function BaseAniamationInteractive() {
        super();
    }

    public function setup(param1:String, param2:Function = null):void {
        this._callBack = param2;
        var _loc3_:String = String(URLUtil.getAnimation(param1));
        UILoader.load(_loc3_, LoadType.DOMAIN, this.onLoadAnimation);
    }

    protected function paramAnimation():void {
    }

    private function onLoadAnimation(param1:ContentInfo):void {
        this._domain = param1.content;
        this._animation = this.getMovieClip("item");
        LayerManager.hideMap();
        LayerManager.topLayer.addChild(this._animation);
        this._animation.x = 120;
        this._animation.y = 50;
        var _loc2_:MovieClip = UIManager.getMovieClip("UI_PlayScreen");
        _loc2_.x -= 120;
        _loc2_.y -= 50;
        this._animation.addChild(_loc2_);
        this._closeBtn = this._animation["closeBtn"];
        if (this._closeBtn) {
            this._closeBtn.addEventListener(MouseEvent.CLICK, this.onClose);
        }
        this.paramAnimation();
    }

    private function onClose(param1:MouseEvent):void {
        this.dispose();
    }

    protected function hide():void {
        LayerManager.showMap();
        if (this._closeBtn) {
            this._closeBtn.removeEventListener(MouseEvent.CLICK, this.onClose);
        }
        DisplayObjectUtil.removeFromParent(this._animation);
        dispatchEvent(new Event(Event.CLOSE));
    }

    public function dispose():void {
        this.hide();
        if (this._callBack != null) {
            this._callBack(this._isSuccess);
            this._callBack = null;
        }
    }

    public function getMovieClip(param1:String):MovieClip {
        return DomainUtil.getMovieClip(param1, this._domain);
    }

    public function getSound(param1:String):Sound {
        return DomainUtil.getSound(param1, this._domain);
    }
}
}
