package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.dream.DreamManager;
import com.taomee.seer2.core.map.MapModel;

import flash.display.MovieClip;
import flash.events.MouseEvent;

public class MapProcessor_138 extends DreamMapProcessor {

    private static const TOTAL_COINS:uint = 5;


    private var _coinsCount:int;

    private var _coinsVec:Vector.<MovieClip>;

    public function MapProcessor_138(param1:MapModel) {
        _taskId = 3;
        super(param1);
    }

    override public function init():void {
        super.init();
        this._coinsCount = 0;
        this.initCoinsVec();
    }

    override protected function onDreamerMouseOver(param1:MouseEvent):void {
        if (_dreamer.currentFrameLabel == "getMoneyEnd") {
            _dreamer.gotoAndPlay("getMoney");
        } else if (_dreamer.currentFrameLabel == "getAllMoneyEnd") {
            _dreamer.gotoAndPlay("getAllMoney");
        }
    }

    private function initCoinsVec():void {
        var _loc3_:String = null;
        var _loc4_:MovieClip = null;
        this._coinsVec = new Vector.<MovieClip>();
        var _loc1_:String = "coins";
        var _loc2_:uint = 1;
        while (_loc2_ <= TOTAL_COINS) {
            _loc3_ = _loc1_ + _loc2_.toString();
            if ((_loc4_ = _map.content[_loc3_]) != null) {
                this._coinsVec.push(_loc4_);
                initInteractor(_loc4_);
                _loc4_.addEventListener(MouseEvent.CLICK, this.onCoinsClick);
            }
            _loc2_++;
        }
    }

    private function onCoinsClick(param1:MouseEvent):void {
        var _loc2_:MovieClip = param1.currentTarget as MovieClip;
        _loc2_.play();
        ++this._coinsCount;
        if (this._coinsCount == TOTAL_COINS) {
            _dreamer.gotoAndPlay("getAllMoney");
            DreamManager.currentTaskId = _taskId;
            indicateLeaveDream();
        } else {
            _dreamer.gotoAndPlay("getMoney");
        }
    }

    private function clearEventListener():void {
        var _loc1_:int = 0;
        while (_loc1_ < this._coinsVec.length) {
            this._coinsVec[_loc1_].removeEventListener(MouseEvent.CLICK, this.onCoinsClick);
            this._coinsVec[_loc1_] = null;
            _loc1_++;
        }
    }

    override public function dispose():void {
        super.dispose();
        this.clearEventListener();
        this._coinsVec = null;
    }
}
}
