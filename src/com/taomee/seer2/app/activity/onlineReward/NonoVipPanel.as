package com.taomee.seer2.app.activity.onlineReward {
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.utils.IDataInput;
import flash.utils.Timer;

import org.taomee.filter.ColorFilter;
import org.taomee.utils.DisplayUtil;

public class NonoVipPanel {


    private var _nonoVipPanel:MovieClip;

    private var _closeBtn:SimpleButton;

    private var _goBtn:SimpleButton;

    private var _data:IDataInput;

    private var _currConis:uint;

    private var _conis:uint;

    private var _itemID:uint;

    private var _count0:MovieClip;

    private var _count00:MovieClip;

    private var _count000:MovieClip;

    private var _timer:Timer;

    private var _fun:Function;

    public function NonoVipPanel(param1:MovieClip) {
        super();
        this._nonoVipPanel = param1;
        this._closeBtn = this._nonoVipPanel["closeBtn"];
        this._goBtn = this._nonoVipPanel["goBtn"];
        this._count0 = this._nonoVipPanel["count0"];
        this._count00 = this._nonoVipPanel["count00"];
        this._count000 = this._nonoVipPanel["count000"];
        this._count0.gotoAndStop(1);
        this._count00.gotoAndStop(1);
        this._count000.gotoAndStop(1);
        this.initEvent();
    }

    private function initEvent():void {
        this._closeBtn.addEventListener(MouseEvent.CLICK, this.onClose);
        this._goBtn.mouseEnabled = true;
        this._goBtn.filters = [];
        this._goBtn.addEventListener(MouseEvent.CLICK, this.onGo);
    }

    private function onGo(param1:MouseEvent):void {
        this._goBtn.mouseEnabled = false;
        ColorFilter.setGrayscale(this._goBtn);
        SwapManager.swapItem(250, 1, this.onGetRewardSuccess);
    }

    private function onGetRewardSuccess(param1:IDataInput):void {
        var _loc2_:SwapInfo = new SwapInfo(param1, false);
        this._conis = _loc2_.swapCoins;
        this._itemID = _loc2_.itemID;
        this._currConis = 0;
        this._count0.gotoAndPlay(2);
        this._count00.gotoAndPlay(2);
        this._count000.gotoAndPlay(3);
        this._timer = new Timer(1000);
        this._timer.addEventListener(TimerEvent.TIMER, this.onTimer);
        this._timer.start();
    }

    private function onTimer(param1:TimerEvent):void {
        if (this._timer.currentCount == 2) {
            this._count0.gotoAndStop(int(this._conis % 100 % 10) + 1);
        }
        if (this._timer.currentCount == 3) {
            this._count00.gotoAndStop(int(this._conis % 100 / 10) + 1);
        }
        if (this._timer.currentCount == 4) {
            this._count000.gotoAndStop(int(this._conis / 100) + 1);
        }
        if (this._timer.currentCount == 5) {
            this._timer.stop();
            this._timer.removeEventListener(TimerEvent.TIMER, this.onTimer);
            AlertManager.showCoinsGainedAlert(this._conis);
            AlertManager.showItemGainedAlert(this._itemID, 1);
        }
    }

    private function onClose(param1:MouseEvent):void {
        DisplayObjectUtil.removeFromParent(this._nonoVipPanel);
        if (this._fun != null) {
            this._fun();
        }
        this.dispose();
    }

    public function show(param1:Function = null):void {
        this._fun = param1;
        this._goBtn.mouseEnabled = true;
        this._goBtn.filters = [];
        this._goBtn.addEventListener(MouseEvent.CLICK, this.onGo);
        this._count0.gotoAndStop(1);
        this._count00.gotoAndStop(1);
        this._count000.gotoAndStop(1);
        LayerManager.topLayer.addChild(this._nonoVipPanel);
        DisplayUtil.align(this._nonoVipPanel);
    }

    public function dispose():void {
        if (this._timer) {
            this._timer.stop();
            this._timer.removeEventListener(TimerEvent.TIMER, this.onTimer);
        }
        this._timer = null;
    }
}
}
