package com.taomee.seer2.app.inventory.item {
import com.taomee.seer2.app.config.ItemConfig;
import com.taomee.seer2.app.config.item.MedalItemDefinition;
import com.taomee.seer2.app.inventory.constant.ItemCategory;
import com.taomee.seer2.core.inventory.StackableItem;
import com.taomee.seer2.core.utils.URLUtil;

public class MedalItem extends StackableItem {


    private var _definition:MedalItemDefinition;

    private var _level:int;

    private var _description:String;

    private var _title:String;

    public function MedalItem(param1:int, param2:int, param3:uint, param4:uint = 0) {
        super();
        this.referenceId = param1;
        this.quantity = param2;
        this.expiryTime = param3;
        this.getTime = param4;
        this.initialize();
    }

    private function initialize():void {
        this._definition = ItemConfig.getMedalDefinition(referenceId);
        this.name = this._definition.name;
        this.category = ItemCategory.MEDAL;
        this._level = this._definition.level;
        this._description = this._definition.tip;
        this._title = this._definition.title;
        this._definition = null;
    }

    override public function get iconUrl():String {
        return URLUtil.getMedalIcon(this.referenceId);
    }

    public function get level():int {
        return this._level;
    }

    public function get description():String {
        return this._description;
    }

    public function get title():String {
        return this._title;
    }

    public function hasTitle():Boolean {
        return this._title != "";
    }
}
}
