package com.taomee.seer2.app.popup.alert {
import com.taomee.seer2.app.component.ItemIcon;
import com.taomee.seer2.app.config.ItemGroupConfig;
import com.taomee.seer2.app.inventory.ItemGroup;
import com.taomee.seer2.app.inventory.ItemUtil;
import com.taomee.seer2.app.popup.AlertInfo;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

public class ItemGroupView extends Sprite implements IAlert {


    private var _mainUI:MovieClip;

    private var _flagMc:MovieClip;

    private var _chooseBtn:SimpleButton;

    private var _confirmBtn:SimpleButton;

    private var _mcVec:Vector.<MovieClip>;

    private var _giftMc:MovieClip;

    private var _iconVec:Vector.<ItemIcon>;

    private var _selectedIndex:int;

    private var _category:String;

    private var _group:ItemGroup;

    public function ItemGroupView() {
        var _loc2_:MovieClip = null;
        var _loc3_:ItemIcon = null;
        super();
        this._mainUI = UIManager.getMovieClip("UI_ItemGroupViewUI");
        addChild(this._mainUI);
        this._flagMc = this._mainUI["flagMc"];
        this._flagMc.gotoAndStop(1);
        this._mcVec = new Vector.<MovieClip>();
        this._iconVec = new Vector.<ItemIcon>();
        var _loc1_:int = 0;
        while (_loc1_ < 3) {
            _loc2_ = this._mainUI["mc_" + _loc1_];
            _loc2_.buttonMode = true;
            _loc2_.addEventListener(MouseEvent.CLICK, this.onMcClick);
            this._mcVec.push(_loc2_);
            _loc3_ = new ItemIcon(_loc2_.width, _loc2_.height);
            _loc3_.x = _loc2_.x;
            _loc3_.y = _loc2_.y;
            this._iconVec.push(_loc3_);
            this._mainUI.addChild(_loc3_);
            _loc1_++;
        }
        this._giftMc = this._mainUI["giftMc"];
        DisplayObjectUtil.disableSprite(this._giftMc);
        this._chooseBtn = this._mainUI["confirmBtn"];
        this._confirmBtn = this._mainUI["chooseBtn"];
        this._confirmBtn.addEventListener(MouseEvent.CLICK, this.onConfirmBtnClick);
        this._chooseBtn.addEventListener(MouseEvent.CLICK, this.onChooseBtnClick);
        this._chooseBtn.visible = false;
        this._confirmBtn.visible = true;
    }

    public function show(param1:AlertInfo):void {
        this._category = param1.initInfo.category;
        this._group = param1.initInfo.group;
        this._selectedIndex = 0;
        this.updateSelected();
        AlertManager.addPopUp(param1, this);
    }

    public function dispose():void {
        AlertManager.removePopUp(this, true);
        this.dispatchEvent(new Event(Event.CLOSE));
    }

    private function onMcClick(param1:MouseEvent):void {
        var _loc2_:int = 0;
        while (_loc2_ < 3) {
            if (this._mcVec[_loc2_] == param1.currentTarget) {
                this._selectedIndex = _loc2_;
            }
            _loc2_++;
        }
        this.updateSelected();
    }

    private function onConfirmBtnClick(param1:MouseEvent):void {
        this._chooseBtn.visible = true;
        this._confirmBtn.visible = false;
        this._flagMc.gotoAndStop(2);
        DisplayObjectUtil.removeFromParent(this._giftMc);
        var _loc2_:Vector.<ItemGroup> = this.getGroupVec();
        var _loc3_:int = 0;
        while (_loc3_ < 3) {
            if (_loc2_[_loc3_].itemDesVec.length == 1) {
                this._iconVec[_loc3_].update(_loc2_[_loc3_].iconUrl, _loc2_[_loc3_].itemDesVec[0].quantity);
            } else {
                this._iconVec[_loc3_].update(_loc2_[_loc3_].iconUrl, 0);
            }
            _loc3_++;
        }
    }

    private function updateSelected():void {
        var _loc1_:int = 0;
        while (_loc1_ < 3) {
            if (_loc1_ == this._selectedIndex) {
                this._mcVec[_loc1_].gotoAndStop(2);
            } else {
                this._mcVec[_loc1_].gotoAndStop(1);
            }
            _loc1_++;
        }
    }

    private function getGroupVec():Vector.<ItemGroup> {
        var _loc4_:ItemGroup = null;
        var _loc1_:Vector.<ItemGroup> = new Vector.<ItemGroup>();
        var _loc2_:Vector.<ItemGroup> = ItemGroupConfig.getItemGroupVec(this._category);
        var _loc3_:int = 0;
        while (_loc3_ < 3) {
            if (_loc3_ != this._selectedIndex) {
                do {
                    _loc4_ = _loc2_[Math.floor(Math.random() * _loc2_.length)];
                }
                while (_loc2_.indexOf(_loc4_) == -1 && this._group != _loc4_);

                _loc1_.push(_loc4_);
            } else {
                _loc1_.push(this._group);
            }
            _loc3_++;
        }
        return _loc1_;
    }

    private function onChooseBtnClick(param1:MouseEvent):void {
        this.dispose();
        ItemUtil.updateLocal(this._group.itemDesVec);
        ItemUtil.showItemVec(this._group.itemDesVec);
    }
}
}
