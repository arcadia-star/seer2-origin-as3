package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.app.swap.special.SpecialInfo;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;

import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.utils.IDataInput;

public class MapProcessor_80061 extends MapProcessor {

    private static const FIND_FOR:uint = 203318;

    private static const FIND_SWAP:int = 2057;


    private var _swapList:Vector.<MovieClip>;

    private var _findState:Vector.<Boolean>;

    public function MapProcessor_80061(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this.initFindAct();
    }

    private function initFindAct():void {
        this.initSet();
        this.initEvent();
        this.update();
    }

    private function initSet():void {
        this._swapList = new Vector.<MovieClip>();
        var _loc1_:int = 0;
        while (_loc1_ < 6) {
            this._swapList.push(_map.content["swap" + _loc1_]);
            this._swapList[_loc1_].buttonMode = true;
            _loc1_++;
        }
    }

    private function initEvent():void {
        var _loc1_:int = 0;
        while (_loc1_ < this._swapList.length) {
            this._swapList[_loc1_].addEventListener(MouseEvent.CLICK, this.onSwap);
            _loc1_++;
        }
    }

    private function onSwap(param1:MouseEvent):void {
        var index:int = 0;
        var evt:MouseEvent = param1;
        this.setBtnEnable(false);
        index = this._swapList.indexOf(evt.currentTarget as MovieClip);
        if (this._findState[index]) {
            if (this.getLeftSpaceNum() == 0) {
                AlertManager.showAlert("藏着玫瑰花的地方已经全部找到了哦!");
            } else {
                AlertManager.showAlert("此处已经找过了,到其他地方看看吧!");
            }
            this.setBtnEnable(true);
        } else {
            SwapManager.swapItem(FIND_SWAP, 1, function (param1:IDataInput):void {
                new SwapInfo(param1);
                _findState[index] = true;
                setBtnEnable(true);
                if (getLeftSpaceNum() == 0) {
                    ServerMessager.addMessage("藏着玫瑰花的地方已经全部找到了哦!");
                } else {
                    ServerMessager.addMessage("还有" + getLeftSpaceNum() + "处可能藏着玫瑰花哦！仔细找找吧。");
                }
            }, function (param1:uint):void {
                setBtnEnable(true);
            }, new SpecialInfo(1, index));
        }
    }

    private function getLeftSpaceNum():int {
        var _loc1_:int = 0;
        var _loc2_:int = 0;
        while (_loc2_ < this._findState.length) {
            if (!this._findState[_loc2_]) {
                _loc1_++;
            }
            _loc2_++;
        }
        return _loc1_;
    }

    private function update():void {
        this.setBtnEnable(false);
        ActiveCountManager.requestActiveCount(FIND_FOR, function (param1:uint, param2:uint):void {
            var _loc3_:uint = param2;
            _findState = new Vector.<Boolean>();
            var _loc4_:int = 0;
            while (_loc4_ < 6) {
                _findState.push(Boolean(_loc3_ & Math.pow(2, _loc4_)));
                _loc4_++;
            }
            setBtnEnable(true);
        });
    }

    private function setBtnEnable(param1:Boolean):void {
        var _loc2_:int = 0;
        while (_loc2_ < this._swapList.length) {
            this._swapList[_loc2_].mouseEnabled = this._swapList[_loc2_].mouseChildren = param1;
            _loc2_++;
        }
    }

    private function disposeFindAct():void {
        var _loc1_:int = 0;
        if (this._swapList) {
            _loc1_ = 0;
            while (_loc1_ < this._swapList.length) {
                this._swapList[_loc1_].removeEventListener(MouseEvent.CLICK, this.onSwap);
                _loc1_++;
            }
            this._swapList = null;
        }
        this._findState = null;
    }

    override public function dispose():void {
        super.dispose();
        this.disposeFindAct();
    }
}
}
