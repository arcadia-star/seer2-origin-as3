package com.taomee.seer2.app.plantSystem.tip {
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.ui.UIManager;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.text.TextField;

public class PlantItemSkin extends Sprite {


    private var _tipSkin:MovieClip;

    private var _contentTxt:TextField;

    private var _back:MovieClip;

    public function PlantItemSkin() {
        super();
        this.mouseChildren = false;
        this.mouseEnabled = false;
        this.initialize();
    }

    private function initialize():void {
        this._tipSkin = UIManager.getMovieClip("UI_PlantItemTooltip");
        this._contentTxt = this._tipSkin["contentTxt"] as TextField;
        this._back = this._tipSkin["bg"];
        this._tipSkin.x = 0;
        this._tipSkin.y = -30;
        addChild(this._tipSkin);
    }

    public function show(param1:String):void {
        this._contentTxt.text = param1;
        if (this._back) {
            this._back.width = this._contentTxt.x + this._contentTxt.textWidth + 8;
            this._back.height = this._contentTxt.y + this._contentTxt.textHeight + 18;
        }
        LayerManager.topLayer.addChild(this);
    }

    public function hide():void {
        if (this.parent != null) {
            this.parent.removeChild(this);
        }
    }

    public function setData(param1:Object):void {
    }
}
}
