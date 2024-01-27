package com.taomee.seer2.app.plantSystem.tip {
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.ui.UIManager;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.text.TextField;

public class PlantTipSkin extends Sprite {


    private var _tipSkin:MovieClip;

    private var _nickTxt:TextField;

    private var _timeTxt:TextField;

    private var _loadingTxt:TextField;

    private var _loadingBar:MovieClip;

    private var _back:MovieClip;

    public function PlantTipSkin() {
        super();
        this.mouseChildren = false;
        this.mouseEnabled = false;
        this.initialize();
    }

    private function initialize():void {
        this._tipSkin = UIManager.getMovieClip("UI_PlantTooltip");
        this._nickTxt = this._tipSkin["nickTxt"] as TextField;
        this._timeTxt = this._tipSkin["timeTxt"] as TextField;
        this._loadingTxt = this._tipSkin["loadingTxt"] as TextField;
        this._loadingBar = this._tipSkin["loadingBar"] as MovieClip;
        this._tipSkin.x = 0;
        this._tipSkin.y = -30;
        addChild(this._tipSkin);
    }

    public function show(param1:String, param2:String, param3:uint, param4:uint):void {
        this._nickTxt.text = param1;
        this._timeTxt.text = param2;
        this._loadingBar["bar"].scaleX = 1 - param3 / param4;
        this._loadingTxt.text = 100 - uint(param3 / param4 * 100) + "%";
        if (this._loadingTxt.text == "99%") {
            this._loadingTxt.text = "100%";
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
