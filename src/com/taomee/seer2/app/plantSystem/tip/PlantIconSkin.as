package com.taomee.seer2.app.plantSystem.tip {
import com.taomee.seer2.app.component.IconDisplayer;
import com.taomee.seer2.app.config.ItemConfig;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.text.TextField;

import org.taomee.utils.DisplayUtil;

public class PlantIconSkin extends Sprite {


    private var _tipSkin:MovieClip;

    private var _contentTxt:TextField;

    private var _id:uint;

    private var _icon:IconDisplayer;

    private var _back:MovieClip;

    public function PlantIconSkin() {
        super();
        this.mouseChildren = false;
        this.mouseEnabled = false;
        this.initialize();
    }

    private function initialize():void {
        this._tipSkin = UIManager.getMovieClip("UI_PlantIconTooltip");
        this._contentTxt = this._tipSkin["contentTxt"] as TextField;
        this._back = this._tipSkin["bg"];
        this._tipSkin.x = 0;
        this._tipSkin.y = -30;
        addChild(this._tipSkin);
    }

    public function show(param1:String, param2:uint, param3:Boolean):void {
        this._contentTxt.text = param1;
        this._icon = new IconDisplayer();
        if (this._back) {
            this._back.height = this._contentTxt.y + this._contentTxt.textHeight + 18;
            if (this._back.height < 110) {
                this._back.height = 110;
            }
        }
        if (param3) {
            this._icon.setIconUrl(URLUtil.getPetIcon(param2));
        } else {
            this._icon.setIconUrl(ItemConfig.getItemIconUrl(param2));
        }
        this._icon.x = this._tipSkin["iconMC"].x + 3;
        this._icon.y = this._tipSkin["iconMC"].y + 3;
        this._tipSkin.addChild(this._icon);
        LayerManager.topLayer.addChild(this);
    }

    public function hide():void {
        if (this.parent != null) {
            this.parent.removeChild(this);
        }
        if (this._icon) {
            this._icon.dispose();
        }
        DisplayUtil.removeForParent(this._icon);
    }

    public function setData(param1:Object):void {
    }
}
}
