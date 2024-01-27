package com.taomee.seer2.app.component {
import com.taomee.seer2.app.vip.data.VipInfo;
import com.taomee.seer2.core.cache.CacheManager;
import com.taomee.seer2.core.cache.CacheType;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.Sprite;

public class VipLogoDisplayer extends Sprite {


    private var _vipInfo:VipInfo;

    private var _iconUrl:String;

    private var _icon:DisplayObject;

    private var _width:Number;

    private var _height:Number;

    public function VipLogoDisplayer() {
        super();
    }

    public function setBoundary(param1:Number, param2:Number):void {
        this._width = param1;
        this._height = param2;
    }

    public function setVipFlag(param1:VipInfo):void {
        this.clear();
        this._vipInfo = param1;
        if (param1.isVip()) {
            this._iconUrl = "res/vip/logo/" + param1.vipFlag + ".swf";
            CacheManager.getContent(this._iconUrl, CacheType.PHASOR, this.onIconLoaded);
        }
    }

    private function onIconLoaded(param1:ContentInfo):void {
        this._icon = param1.content as DisplayObject;
        if (this._icon) {
            DisplayObjectUtil.setSize(this._icon, this._width, this._height);
            addChild(this._icon);
            if (this._vipInfo.vipFlag == 1) {
                MovieClip(this._icon).gotoAndStop(this._vipInfo.level);
            }
        }
    }

    private function clear():void {
        DisplayObjectUtil.removeFromParent(this._icon);
        CacheManager.cancel(this._iconUrl, CacheType.PHASOR, this.onIconLoaded);
    }

    public function dispose():void {
        this.clear();
        this._icon = null;
        this._vipInfo = null;
    }
}
}
