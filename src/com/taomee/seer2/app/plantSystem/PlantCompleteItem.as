package com.taomee.seer2.app.plantSystem {
import com.taomee.seer2.app.component.IconDisplayer;
import com.taomee.seer2.app.config.ItemConfig;

import flash.display.Sprite;

import org.taomee.utils.DisplayUtil;

public class PlantCompleteItem extends Sprite {


    private var _icon:IconDisplayer;

    private var _id:uint;

    private var _count:uint;

    private var _sp:Sprite;

    public function PlantCompleteItem(param1:uint, param2:uint) {
        super();
        this._id = param1;
        this._count = param2;
        this.init();
    }

    private function init():void {
        this._icon = new IconDisplayer();
        var _loc1_:String = "+" + this._count.toString();
        this._sp = PlantMovePlay.playNumber(_loc1_, this._icon);
        addChild(this._sp);
        this._icon.setIconUrl(ItemConfig.getItemIconUrl(this._id));
    }

    public function dispose():void {
        DisplayUtil.removeForParent(this._sp);
        if (this._icon) {
            this._icon.dispose();
        }
        this._sp = null;
        this._icon = null;
    }

    public function get id():uint {
        return this._id;
    }
}
}
