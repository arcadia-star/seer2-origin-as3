package com.taomee.seer2.app.component {
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.Sprite;

public class PetTypeIcon extends Sprite {

    private static const TYPE_ICON_PREFIX:String = "UI_PetTypeIcon_";


    private var _type:int;

    private var _typeIcon:Sprite;

    private var w:int;

    private var h:int;

    public function PetTypeIcon() {
        super();
        this.initialize();
    }

    private function initialize():void {
        this.mouseChildren = false;
        this.createChildren();
    }

    private function createChildren():void {
        this._typeIcon = new Sprite();
        addChild(this._typeIcon);
    }

    public function set type(param1:int):void {
        this._type = param1;
        this.updateTypeIcon();
    }

    public function clear():void {
        DisplayObjectUtil.removeAllChildren(this._typeIcon);
    }

    public function setBoundary(param1:Number, param2:Number):void {
        DisplayObjectUtil.setSize(this._typeIcon, param1, param2);
    }

    public function setWH(param1:Number, param2:Number):void {
        this.w = param1;
        this.h = param2;
    }

    private function updateTypeIcon():void {
        this.clear();
        var _loc1_:Sprite = UIManager.getSprite(TYPE_ICON_PREFIX + this._type);
        if (_loc1_) {
            if (this.w != 0) {
                _loc1_.width = this.w;
            }
            if (this.h != 0) {
                _loc1_.height = this.h;
            }
            this._typeIcon.addChild(_loc1_);
            addChild(this._typeIcon);
        }
    }
}
}
