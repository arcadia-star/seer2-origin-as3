package com.taomee.seer2.app.component {
import com.taomee.seer2.app.config.EquipElementConfig;
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.inventory.item.EquipItem;
import com.taomee.seer2.core.inventory.Item;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

public class ItemToolTip extends Sprite {

    private static var _instance:ItemToolTip;


    private var _container:MovieClip;

    private var _backMc:MovieClip;

    private var _nameTxt:TextField;

    private var _descriptionTxt:TextField;

    private var _remarkTxt:TextField;

    private var _item:Item;

    public function ItemToolTip() {
        super();
        this.createChildren();
    }

    public static function show(param1:Item):void {
        if (_instance == null) {
            _instance = new ItemToolTip();
        }
        _instance.setData(param1);
    }

    public static function hide():void {
        if (_instance) {
            _instance.setData(null);
        }
    }

    private function createChildren():void {
        this._container = UIManager.getMovieClip("UI_ItemTooltip");
        addChild(this._container);
        this._backMc = this._container["back"];
        this._nameTxt = this._container["itemName"];
        this._descriptionTxt = this._container["description"];
        this._descriptionTxt.autoSize = TextFieldAutoSize.LEFT;
        this._descriptionTxt.width = 160;
        this._descriptionTxt.wordWrap = true;
        this._remarkTxt = this._container["remark"];
    }

    private function setData(param1:Item):void {
        this._item = param1;
        if (this._item != null) {
            this.updatePosition();
            this.updateDisplay();
            LayerManager.topLayer.addChild(this);
            LayerManager.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.onStageMouseMove);
        } else {
            DisplayObjectUtil.removeFromParent(this);
            LayerManager.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.onStageMouseMove);
        }
    }

    private function updateDisplay():void {
        var _loc1_:int = 0;
        this._nameTxt.text = this._item.name;
        this._descriptionTxt.text = this._item.tip;
        if (this._item is EquipItem && Boolean((this._item as EquipItem).strengLevel)) {
            this.updateElement(this._item as EquipItem);
        }
        this._backMc.width = this._descriptionTxt.width + 10;
        this._backMc.height = this._descriptionTxt.height + 50;
        if (this._item is EquipItem && this._item.price > 0) {
            _loc1_ = (this._item as EquipItem).leftDay;
            this._remarkTxt.text = _loc1_ == 0 ? "永久不过期" : "剩余" + _loc1_ + "天到期";
            this._remarkTxt.y = this._descriptionTxt.height + 35;
            this._backMc.height += 20;
            this._remarkTxt.visible = true;
        } else {
            this._remarkTxt.visible = false;
        }
    }

    private function updateElement(param1:EquipItem):void {
        var _loc2_:String = null;
        param1.elementInfo = EquipElementConfig.getInfo(param1.referenceId);
        if (param1.elementInfo != null) {
            if (param1.elementInfo.idVec.length > 1) {
                _loc2_ = "套装效果:";
            } else {
                _loc2_ = "装备效果";
            }
            _loc2_ += "使" + param1.elementInfo.obj + "的";
            _loc2_ += this.getElementType(param1.elementInfo.elementType, param1.elementInfo.elementCount, param1.strengLevel);
            if (this.isEquiped(param1)) {
                switch (param1.strengLevel) {
                    case 1:
                        this._descriptionTxt.htmlText = "<font color=\'#FFFFFF\'>" + _loc2_ + "</font>" + this._descriptionTxt.text;
                        break;
                    case 2:
                        this._descriptionTxt.htmlText = "<font color=\'#00ff00\'>" + _loc2_ + "</font>" + this._descriptionTxt.text;
                        break;
                    case 3:
                        this._descriptionTxt.htmlText = "<font color=\'#0072FA\'>" + _loc2_ + "</font>" + this._descriptionTxt.text;
                        break;
                    case 4:
                        this._descriptionTxt.htmlText = "<font color=\'#EE5812\'>" + _loc2_ + "</font>" + this._descriptionTxt.text;
                        break;
                    case 5:
                        this._descriptionTxt.htmlText = "<font color=\'#EECD02\'>" + _loc2_ + "</font>" + this._descriptionTxt.text;
                }
            } else {
                this._descriptionTxt.htmlText = "<font color=\'#99918E\'>" + _loc2_ + "</font>" + this._descriptionTxt.text;
            }
        }
    }

    private function getElementType(param1:Array, param2:Array, param3:uint):String {
        var _loc4_:* = "";
        var _loc5_:Array = param1[param3 - 1];
        var _loc6_:Array = param2[param3 - 1];
        var _loc7_:int = 0;
        while (_loc7_ < _loc5_.length) {
            switch (_loc5_[_loc7_]) {
                case 1:
                    _loc4_ += "物攻值";
                    break;
                case 2:
                    _loc4_ += "物防值";
                    break;
                case 3:
                    _loc4_ += "特攻值";
                    break;
                case 4:
                    _loc4_ += "特防值";
                    break;
                case 5:
                    _loc4_ += "速度值";
                    break;
                case 6:
                    _loc4_ += "体力值";
                    break;
                case 7:
                    _loc4_ += "全能力值";
                    break;
            }
            _loc4_ += "+" + _loc6_[_loc7_].toString();
            if (_loc7_ != _loc5_.length - 1) {
                _loc4_ += ",";
            }
            _loc7_++;
        }
        return _loc4_ + "点\n";
    }

    private function isEquiped(param1:EquipItem):Boolean {
        var _loc3_:uint = 0;
        var _loc2_:Boolean = true;
        for each(_loc3_ in param1.elementInfo.idVec) {
            if (ItemManager.getItemByReferenceId(_loc3_) == null || (ItemManager.getItemByReferenceId(_loc3_) as EquipItem).isEquiped == false) {
                _loc2_ = false;
            }
        }
        return _loc2_;
    }

    private function onStageMouseMove(param1:MouseEvent):void {
        this.updatePosition();
    }

    private function updatePosition():void {
        this.x = LayerManager.stage.mouseX + 10;
        this.y = LayerManager.stage.mouseY + 20;
        if (this.x + this._container.width > 1140) {
            this.x = 1140 - this.width;
        }
        if (this.y + this.height > 660) {
            this.y = 600 - this.height;
        }
    }
}
}
