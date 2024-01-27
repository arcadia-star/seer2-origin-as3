package com.taomee.seer2.core.ui.toolTip.tipSkins {
import com.taomee.seer2.core.scene.LayerManager;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.text.TextField;

import org.taomee.utils.StringUtil;

public class BaseTipSkin extends Sprite {


    protected var _tipSkin:MovieClip;

    protected var _tipTxt:TextField;

    protected var _back:MovieClip;

    public function BaseTipSkin() {
        super();
        this.mouseChildren = false;
        this.mouseEnabled = false;
    }

    public function show(param1:String):void {
        this._tipTxt.htmlText = StringUtil.replace(param1, "\\n", "<br>");
        if (this._back) {
            this._back.width = this._tipTxt.x + this._tipTxt.textWidth + 8;
            this._back.height = this._tipTxt.y + this._tipTxt.textHeight + 14;
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
