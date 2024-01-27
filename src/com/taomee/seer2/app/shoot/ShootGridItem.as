package com.taomee.seer2.app.shoot {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.component.IconDisplayer;
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.core.inventory.events.InventoryEvent;
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;
import com.taomee.seer2.core.utils.effect.SweepEffect;

import flash.display.Sprite;
import flash.text.TextField;

public class ShootGridItem extends Sprite {


    private var _id:uint;

    private var _icon:IconDisplayer;

    private var _bg:Sprite;

    private var _numTxt:TextField;

    private var _canShoot:Boolean;

    private var _hotArea:Sprite;

    public function ShootGridItem() {
        super();
        mouseEnabled = true;
        this._bg = UIManager.getSprite("UI_ShootPanel_Item");
        this._numTxt = new TextField();
        this._numTxt.y = this._bg.height - 15;
        this._numTxt.textColor = 16777215;
        this._numTxt.selectable = false;
        this._numTxt.mouseEnabled = false;
        addChild(this._bg);
        this._icon = new IconDisplayer();
        addChild(this._icon);
        this._hotArea = new Sprite();
        this._hotArea.alpha = 0;
        this._hotArea.graphics.beginFill(16711680);
        this._hotArea.graphics.drawRect(0, 0, this._bg.width, this._bg.height);
        this._hotArea.graphics.endFill();
        addChild(this._hotArea);
    }

    public function set id(param1:uint):void {
        this._id = param1;
        if (this._id > 0) {
            this._icon.setIconUrl(URLUtil.getShootIcon(this._id), this.onIcon);
        }
    }

    public function get id():uint {
        return this._id;
    }

    private function onIcon():void {
        DisplayObjectUtil.removeFromParent(this._numTxt);
        this.processIcon();
        SweepEffect.instance.add(this._hotArea, this._icon);
    }

    private function processIcon():void {
        if (ShootXMLInfo.isYearShoot(this.id)) {
            this.processYearVip();
        } else if (ShootXMLInfo.isVipShoot(this.id)) {
            this.processVIP();
        } else if (ShootXMLInfo.isSpecialShootItem(this.id)) {
            this.processSpecialItem();
        } else {
            this.canShoot = true;
        }
    }

    private function processYearVip():void {
        this.canShoot = ActorManager.getActor().getInfo().isYearVip != 0;
    }

    private function processVIP():void {
        this.canShoot = ActorManager.getActor().getInfo().vipInfo.isVip();
    }

    private function processSpecialItem():void {
        if (ItemManager.hasGetItem) {
            this.updateQuantity();
        } else {
            ItemManager.requestItemList(this.updateQuantity);
        }
        ItemManager.addEventListener(InventoryEvent.UPDATE_QUANTITY, this.onUpdateQuantity);
    }

    private function onUpdateQuantity(param1:InventoryEvent):void {
        if (param1.itemReferenceId == ShootXMLInfo.getSpecialItemId(this.id)) {
            this.updateQuantity();
        }
    }

    private function updateQuantity():void {
        var _loc1_:int = ItemManager.getItemQuantityByReferenceId(ShootXMLInfo.getSpecialItemId(this.id));
        if (_loc1_ > 0) {
            this._numTxt.text = String(_loc1_);
            this._numTxt.x = this._bg.width - this._numTxt.textWidth - 5;
            this._numTxt.height = 16;
            addChildAt(this._numTxt, numChildren);
            this.canShoot = true;
        } else {
            DisplayObjectUtil.removeFromParent(this._numTxt);
            this.canShoot = false;
        }
    }

    public function set canShoot(param1:Boolean):void {
        this._canShoot = param1;
        if (this._canShoot) {
            DisplayObjectUtil.recoverDisplayObject(this._icon);
            buttonMode = true;
        } else {
            DisplayObjectUtil.grayDisplayObject(this._icon);
            buttonMode = false;
        }
    }

    public function get canShoot():Boolean {
        return this._canShoot;
    }
}
}
