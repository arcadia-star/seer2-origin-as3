package com.taomee.seer2.app.inventory.item {
import com.taomee.seer2.app.actor.constant.EquipSlot;
import com.taomee.seer2.app.config.ItemConfig;
import com.taomee.seer2.app.config.info.EquipElementInfo;
import com.taomee.seer2.app.config.item.EquipItemDefinition;
import com.taomee.seer2.core.inventory.StackableItem;
import com.taomee.seer2.core.utils.URLUtil;
import com.taomee.seer2.core.utils.Util;

public class EquipItem extends StackableItem {


    private var _definition:EquipItemDefinition;

    private var _isEquiped:Boolean;

    private var _slotIndex:uint;

    private var _isAccessory:Boolean;

    private var _hasAccessory:Boolean;

    private var _elementInfo:EquipElementInfo;

    private var _strengLevel:uint;

    public function EquipItem(param1:int, param2:Boolean = true, param3:uint = 0, param4:uint = 0) {
        super();
        this.referenceId = param1;
        this.expiryTime = param3;
        this.getTime = param4;
        this.isEquiped = param2;
        this.quantity = 1;
        if (param1 != 0) {
            this._definition = ItemConfig.getEquipDefinition(param1);
            this.initialize();
        }
    }

    public static function getSlotIndexByReference(param1:uint):int {
        var _loc2_:EquipItemDefinition = ItemConfig.getEquipDefinition(param1);
        return _loc2_.slotIndex;
    }

    private function initialize():void {
        this.name = this._definition.name;
        this.quantityLimit = this._definition.quantityLimit;
        this.category = this._definition.category;
        this.currencyType = this._definition.currencyType;
        this.price = this._definition.price;
        this.tradability = this._definition.tradability;
        this.vipTradability = this._definition.vipTradability;
        this.isVipOnly = this._definition.isVipOnly;
        this.tip = this._definition.tip;
        this._slotIndex = this._definition.slotIndex;
        this._hasAccessory = this.checkAccessory(this._slotIndex);
    }

    private function checkAccessory(param1:uint):Boolean {
        return param1 == EquipSlot.HAND_RIGHT || param1 == EquipSlot.FOOT_RIGHT || param1 == EquipSlot.DOGZ_RIGHT;
    }

    override public function get iconUrl():String {
        return URLUtil.getEquipIcon(this.referenceId);
    }

    public function get previewUrl():String {
        var _loc1_:String = this.getResourceIdentifier();
        if (this.hasAccessory == true) {
            return URLUtil.getEquipPreview(_loc1_ + "_0");
        }
        if (this.isAccessory == true) {
            return URLUtil.getEquipPreview(_loc1_ + "_1");
        }
        return URLUtil.getEquipPreview(_loc1_);
    }

    public function get swfUrl():String {
        var _loc1_:String = this.getResourceIdentifier();
        if (this.hasAccessory == true) {
            return URLUtil.getEquipSwf(_loc1_ + "_0");
        }
        if (this.isAccessory == true) {
            return URLUtil.getEquipSwf(_loc1_ + "_1");
        }
        return URLUtil.getEquipSwf(_loc1_);
    }

    private function getResourceIdentifier():String {
        var _loc1_:String = this.suitId.toString();
        var _loc2_:String = String(Util.pad(_loc1_, "0", 3, false));
        var _loc3_:String = this.slotIndex.toString();
        if (this.slotIndex == EquipSlot.HAND_LEFT) {
            _loc3_ = EquipSlot.HAND_RIGHT.toString();
        }
        if (this.slotIndex == EquipSlot.FOOT_LEFT) {
            _loc3_ = EquipSlot.FOOT_RIGHT.toString();
        }
        if (this.slotIndex == EquipSlot.DOGZ_LEFT) {
            _loc3_ = EquipSlot.DOGZ_RIGHT.toString();
        }
        var _loc4_:String = String(Util.pad(_loc3_, "0", 2, false));
        return "1" + _loc2_ + _loc4_;
    }

    public function set isEquiped(param1:Boolean):void {
        this._isEquiped = param1;
    }

    public function get isEquiped():Boolean {
        return this._isEquiped;
    }

    public function set slotIndex(param1:uint):void {
        this._slotIndex = param1;
    }

    public function get slotIndex():uint {
        return this._slotIndex;
    }

    public function get suitId():int {
        return this._definition.suitId;
    }

    public function get timeLimit():int {
        return this._definition.timeLimit;
    }

    public function set hasAccessory(param1:Boolean):void {
        this._hasAccessory = param1;
    }

    public function get hasAccessory():Boolean {
        return this._hasAccessory;
    }

    public function set isAccessory(param1:Boolean):void {
        this._isAccessory = param1;
    }

    public function get isAccessory():Boolean {
        return this._isAccessory;
    }

    public function set elementInfo(param1:EquipElementInfo):void {
        this._elementInfo = param1;
    }

    public function get elementInfo():EquipElementInfo {
        return this._elementInfo;
    }

    public function set strengLevel(param1:uint):void {
        this._strengLevel = param1;
    }

    public function get strengLevel():uint {
        return this._strengLevel;
    }

    public function getAccessory():EquipItem {
        var _loc1_:EquipItem = null;
        var _loc2_:EquipItem = null;
        var _loc3_:EquipItem = null;
        if (this.slotIndex == EquipSlot.HAND_RIGHT) {
            _loc1_ = new EquipItem(this.referenceId, this.isEquiped, this.expiryTime);
            _loc1_.hasAccessory = false;
            _loc1_.isAccessory = true;
            _loc1_.slotIndex = EquipSlot.HAND_LEFT;
            return _loc1_;
        }
        if (this.slotIndex == EquipSlot.FOOT_RIGHT) {
            _loc2_ = new EquipItem(this.referenceId, this.isEquiped, this.expiryTime);
            _loc2_.hasAccessory = false;
            _loc2_.isAccessory = true;
            _loc2_.slotIndex = EquipSlot.FOOT_LEFT;
            return _loc2_;
        }
        if (this.slotIndex == EquipSlot.DOGZ_RIGHT) {
            _loc3_ = new EquipItem(this.referenceId, this.isEquiped, this.expiryTime);
            _loc3_.hasAccessory = false;
            _loc3_.isAccessory = true;
            _loc3_.slotIndex = EquipSlot.DOGZ_LEFT;
            return _loc3_;
        }
        return null;
    }

    public function get leftDay():int {
        return Math.ceil(this.expiryTime / 24 / 3600);
    }

    public function isExpired():Boolean {
        if (this.leftDay < 7 && this.leftDay != 0) {
            return true;
        }
        return false;
    }
}
}
