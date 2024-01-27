package com.taomee.seer2.app.component {
import com.taomee.seer2.app.config.ItemConfig;
import com.taomee.seer2.core.cache.CacheManager;
import com.taomee.seer2.core.cache.CacheType;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.DisplayObject;
import flash.display.Sprite;

public class IconDisplayer extends Sprite {

    public static const NORMAL:String = "normal";

    public static const CENTER:String = "center";


    private var _iconUrl:String;

    private var _icon:DisplayObject;

    private var _onComplete:Function;

    private var _param:Array;

    private var _maxWidth:Number;

    private var _maxHeight:Number;

    private var _displayType:String;

    public function IconDisplayer() {
        super();
        mouseChildren = false;
        this._displayType = NORMAL;
    }

    public function setIconUrl(param1:String, param2:Function = null, param3:Array = null):void {
        this.removeIcon();
        this._iconUrl = param1;
        this._onComplete = param2;
        if (param3) {
            this._param = param3;
        }
        this.loadIcon();
    }

    public function set displayType(param1:String):void {
        this._displayType = param1;
        this.setIconMove();
    }

    public function setBoundary(param1:Number, param2:Number):void {
        this._maxWidth = param1;
        this._maxHeight = param2;
    }

    public function showIconByReferenceId(param1:uint):void {
        this.setIconUrl(ItemConfig.getItemIconUrl(param1));
    }

    public function get icon():DisplayObject {
        return this._icon;
    }

    public function removeIcon():void {
        if (this._iconUrl) {
            CacheManager.cancel(this._iconUrl, CacheType.PHASOR, this.onIconLoaded);
        }
        DisplayObjectUtil.removeFromParent(this._icon);
        this._icon = null;
    }

    public function dispose():void {
        this.removeIcon();
        CacheManager.cancel(this._iconUrl, CacheType.PHASOR, this.onIconLoaded);
        this._onComplete = null;
    }

    private function setIconMove():void {
        if (this._icon) {
            switch (this._displayType) {
                case NORMAL:
                    this._icon.x = 0;
                    this._icon.y = 0;
                    break;
                case CENTER:
                    this._icon.x = -this._icon.width / 2;
                    this._icon.y = -this._icon.height / 2;
            }
        }
    }

    private function loadIcon():void {
        CacheManager.getContent(this._iconUrl, CacheType.PHASOR, this.onIconLoaded);
    }

    private function onIconLoaded(param1:ContentInfo):void {
        this._icon = param1.content as DisplayObject;
        if (this.icon != null) {
            if (!isNaN(this._maxWidth)) {
                DisplayObjectUtil.setSize(this._icon, this._maxWidth, this._maxHeight);
            }
            addChild(this._icon);
            this.setIconMove();
        }
        if (this._onComplete != null) {
            if (this._param) {
                this._onComplete(this._param);
            } else {
                this._onComplete();
            }
            this._param = null;
            this._onComplete = null;
        }
    }
}
}
