package com.taomee.seer2.app.controls.widget {
import com.greensock.TweenLite;
import com.taomee.seer2.app.component.IconDisplayer;
import com.taomee.seer2.app.config.ItemConfig;
import com.taomee.seer2.app.info.BuyPropInfo;
import com.taomee.seer2.app.net.parser.Parser_1224;
import com.taomee.seer2.app.shopManager.ShopManager;
import com.taomee.seer2.core.ui.toolTip.TooltipManager;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;
import flash.text.TextField;

public class SpringLessTaobaoToolbar {


    private const itemIdList:Vector.<uint> = Vector.<uint>([801089, 801090, 801093, 801094, 801095, 201069, 201070, 201071, 201077, 201078, 203339, 203340, 203341, 203342, 203482, 203483, 203484, 201113, 401200, 206667, 201109, 401121, 801149, 801150, 801151, 801092, 801131, 801132, 801133, 801134, 801135, 203481, 203480]);

    private const prevMoneyList:Vector.<uint> = Vector.<uint>([30, 30, 30, 30, 30, 200, 150, 50, 10, 20, 250, 250, 250, 250, 150, 150, 150, 30, 10, 480, 50, 20, 80, 80, 80, 50, 30, 150, 50, 50, 50, 250, 250]);

    private const currMoneyList:Vector.<uint> = Vector.<uint>([8, 8, 8, 8, 8, 150, 80, 35, 6, 10, 80, 80, 80, 80, 60, 60, 60, 15, 7, 384, 40, 16, 1, 1, 1, 1, 1, 1, 1, 1, 1, 80, 80]);

    private var _itemIcon:IconDisplayer;

    private var _itemIconMC:MovieClip;

    private var _prevMoneyTxt:TextField;

    private var _currMoneyTxt:TextField;

    private var _currEndCountTxt:TextField;

    private var _buyBtn:SimpleButton;

    private var _prevBtn:SimpleButton;

    private var _nextBtn:SimpleButton;

    private var _countEntMC:MovieClip;

    private var _mc:MovieClip;

    private var _currItemId:uint;

    public var _isShow:Boolean;

    public var _isDispose:Boolean;

    private var _isChange:Boolean;

    public function SpringLessTaobaoToolbar(param1:MovieClip) {
        super();
        this._mc = param1;
        this.initMC();
    }

    private function initMC():void {
        this._itemIconMC = this._mc["itemIconMC"];
        this._prevMoneyTxt = this._mc["prevMoneyTxt"];
        this._currMoneyTxt = this._mc["currMoneyTxt"];
        this._currEndCountTxt = this._mc["currEndCountTxt"];
        this._countEntMC = this._mc["countEntMC"];
        this._buyBtn = this._mc["buyBtn"];
        this._prevBtn = this._mc["prevBtn"];
        this._prevBtn.visible = false;
        this._nextBtn = this._mc["nextBtn"];
        this._nextBtn.visible = false;
        this._itemIcon = new IconDisplayer();
        this._itemIconMC.addChild(this._itemIcon);
        this._itemIcon.x = this._itemIcon.y = 5;
        this._itemIcon.scaleX = this._itemIcon.scaleY = 1.1;
        TooltipManager.addCommonTip(this._itemIconMC, "");
        this.initEvent();
    }

    private function initEvent():void {
        this._buyBtn.addEventListener(MouseEvent.CLICK, this.onBuy);
        this._prevBtn.addEventListener(MouseEvent.CLICK, this.onPrev);
        this._nextBtn.addEventListener(MouseEvent.CLICK, this.onNext);
    }

    private function onPrev(param1:MouseEvent):void {
        TweenLite.to(this._mc, 0.5, {
            "x": -343,
            "onComplete": this.onTweenOut
        });
    }

    private function onTweenOut():void {
        this._isShow = false;
        this._prevBtn.visible = false;
        this._nextBtn.visible = true;
        this.clear();
    }

    private function onTweenOver():void {
        this._isShow = true;
        this._prevBtn.visible = true;
        this._nextBtn.visible = false;
        this.update();
    }

    private function onNext(param1:MouseEvent):void {
        this._isChange = false;
        TweenLite.to(this._mc, 0.5, {
            "x": 0,
            "onComplete": this.onTweenOver
        });
    }

    private function onBuy(param1:MouseEvent):void {
        var _loc2_:BuyPropInfo = new BuyPropInfo();
        _loc2_.itemId = this._currItemId;
        _loc2_.buyComplete = this.buyComplete;
        ShopManager.buyVirtualItem(_loc2_);
    }

    private function buyComplete(param1:Parser_1224):void {
        this.dispose();
        this._countEntMC.visible = false;
        this._currEndCountTxt.text = "";
        this._buyBtn.visible = false;
    }

    public function dispose():void {
        this._isDispose = true;
        this.onPrev(null);
    }

    private function clear():void {
        this._itemIcon.removeIcon();
    }

    private function update():void {
        if (this._itemIcon) {
            this._itemIcon.removeIcon();
            this._itemIcon.setIconUrl(ItemConfig.getItemIconUrl(this._currItemId));
        }
        this._prevMoneyTxt.text = this.prevMoneyList[this.itemIdList.indexOf(this._currItemId)].toString();
        this._currMoneyTxt.text = this.currMoneyList[this.itemIdList.indexOf(this._currItemId)].toString();
        if (this._isChange) {
            if (this._countEntMC) {
                this._countEntMC.visible = true;
            }
            if (this._currEndCountTxt) {
                this._currEndCountTxt.text = uint(Math.random() * 47 + 3).toString();
            }
        }
        TooltipManager.addCommonTip(this._itemIconMC, ItemConfig.getItemDefinition(this._currItemId).tip);
    }

    public function show(param1:uint):void {
        this._isChange = true;
        this._isShow = true;
        this._currItemId = param1;
        this._isDispose = false;
        this._buyBtn.visible = true;
        TweenLite.to(this._mc, 0.5, {
            "x": 0,
            "onComplete": this.onTweenOver
        });
    }
}
}
