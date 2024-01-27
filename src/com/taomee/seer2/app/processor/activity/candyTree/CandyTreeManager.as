package com.taomee.seer2.app.processor.activity.candyTree {
import com.taomee.seer2.app.manager.DayLimitManager;
import com.taomee.seer2.app.manager.InteractiveRewardManager;
import com.taomee.seer2.app.net.parser.Parser_1060;
import com.taomee.seer2.app.plantSystem.PlantMouse;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.map.MapModel;

import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.utils.IDataInput;
import flash.utils.Timer;

public class CandyTreeManager {


    private var _map:MapModel;

    private var _water:MovieClip;

    private var _flower:MovieClip;

    private var _staticMC:MovieClip;

    private var _timeMC:MovieClip;

    private var _getWinMC:MovieClip;

    private var _currTime:uint;

    private var _timer:Timer;

    private var _isClickWater:Boolean;

    private var _waterPoint:Point;

    public function CandyTreeManager(param1:MapModel) {
        super();
        this._map = param1;
        this.init();
    }

    private function init():void {
        this.initMC();
        this.getStatus();
    }

    private function getStatus():void {
        DayLimitManager.getDoCount(528, function (param1:uint):void {
            CandyTreeData.isCanWater = param1;
            if (param1 == 0) {
                _staticMC.visible = true;
                _staticMC.gotoAndStop(1);
                CandyTreeData.currStatus = 1;
            } else {
                getFlowerData();
            }
        });
    }

    private function getFlowerData():void {
        DayLimitManager.getDoCount(526, function (param1:uint):void {
            var count:uint = param1;
            CandyTreeData.upCount = count;
            DayLimitManager.getDoCount(527, function (param1:uint):void {
                CandyTreeData.startTime = param1;
                _currTime = CandyTreeData.getOverTime(CandyTreeData.upCount, param1);
                if (_currTime == 10000) {
                    timeComplete();
                } else {
                    timeStart();
                }
            });
        });
    }

    private function timeStart():void {
        CandyTreeData.currStatus = 3;
        this._staticMC.visible = false;
        this._timeMC.visible = true;
        this._timer = new Timer(1000);
        this._timer.addEventListener(TimerEvent.TIMER, this.onTimer);
        this._timer.start();
    }

    private function onTimer(param1:TimerEvent):void {
        if (this._currTime <= 0) {
            this._timer.stop();
            this._timer.removeEventListener(TimerEvent.TIMER, this.onTimer);
            this._timeMC.visible = false;
            this.timeComplete();
        } else {
            CandyTreeData.updateTime(CandyTreeData.upCount, this._currTime);
            --this._currTime;
        }
    }

    private function timeComplete():void {
        this._staticMC.visible = true;
        this._staticMC.gotoAndStop(2);
        CandyTreeData.currStatus = 2;
        MovieClipUtil.playMc(this._flower, 2, this._flower.totalFrames);
    }

    private function initMC():void {
        this._water = this._map.content["water"];
        this._water.gotoAndStop(1);
        this._water.buttonMode = true;
        this._flower = this._map.content["flower"];
        this._flower.gotoAndStop(1);
        this._flower.buttonMode = true;
        this._staticMC = this._map.content["staticMC"];
        this._staticMC.visible = false;
        this._staticMC.buttonMode = true;
        this._timeMC = this._map.content["timeMC"];
        this._timeMC.visible = false;
        CandyTreeData.timeMC = this._timeMC;
        this._isClickWater = false;
        this._getWinMC = this._map.content["getWinMC"];
        this._getWinMC.visible = false;
        this.initEvent();
    }

    private function initEvent():void {
        this._water.addEventListener(MouseEvent.CLICK, this.onWater);
        this._flower.addEventListener(MouseEvent.CLICK, this.onFlowe);
        this._staticMC.addEventListener(MouseEvent.CLICK, this.onFlowe);
    }

    private function onFlowe(param1:MouseEvent):void {
        this.onFlower();
    }

    private function onWater(param1:MouseEvent):void {
        if (this._isClickWater) {
            if (this._water.hitTestObject(this._staticMC) || this._water.hitTestObject(this._flower)) {
                this.onFlower();
            } else {
                this._isClickWater = false;
                this._water.x = this._waterPoint.x;
                this._water.y = this._waterPoint.y;
                PlantMouse.endMouse();
                this._water.visible = true;
            }
        } else {
            this._isClickWater = true;
            this._waterPoint = new Point(this._water.x, this._water.y);
            PlantMouse.startMouse(this._water);
        }
    }

    private function onFlower():void {
        if (CandyTreeData.currStatus == 3) {
            AlertManager.showAlert("需要倒计时结束才可以收获");
            if (this._isClickWater) {
                this._isClickWater = false;
                this._water.x = this._waterPoint.x;
                this._water.y = this._waterPoint.y;
                PlantMouse.endMouse();
                this._water.visible = true;
            }
            return;
        }
        if (this._isClickWater && CandyTreeData.currStatus == 1) {
            this.waterStart();
        } else {
            if (this._isClickWater) {
                AlertManager.showAlert("别着急，现在不需要浇水哦。");
                this._isClickWater = false;
                this._water.x = this._waterPoint.x;
                this._water.y = this._waterPoint.y;
                PlantMouse.endMouse();
                this._water.visible = true;
                return;
            }
            if (CandyTreeData.currStatus == 1) {
                AlertManager.showAlert("用左边的水壶浇水吧！");
                return;
            }
        }
        if (CandyTreeData.currStatus == 2 && this._isClickWater == false) {
            this.getWin();
        }
    }

    private function waterStart():void {
        PlantMouse.endMouse();
        MovieClipUtil.playMc(this._water, 2, this._water.totalFrames, function ():void {
            SwapManager.swapItem(674, 1, function (param1:IDataInput):void {
                new SwapInfo(param1);
                getFlowerData();
                _staticMC.visible = false;
                _isClickWater = false;
                _water.x = _waterPoint.x;
                _water.y = _waterPoint.y;
                PlantMouse.endMouse();
            });
        }, true);
    }

    private function getWin():void {
        InteractiveRewardManager.requestReward(180, function (param1:Parser_1060):void {
            var par:Parser_1060 = param1;
            par.showResult(false, null);
            _getWinMC.visible = true;
            _getWinMC["count"].gotoAndStop(par.addItemVec[0].count);
            MovieClipUtil.playMc(_getWinMC, 2, _getWinMC.totalFrames, function ():void {
                _getWinMC.gotoAndStop(1);
                _getWinMC.visible = false;
                _flower.gotoAndStop(1);
                getStatus();
            }, true);
        });
    }

    public function dispose():void {
        PlantMouse.endMouse();
        this._water.removeEventListener(MouseEvent.CLICK, this.onWater);
        this._flower.removeEventListener(MouseEvent.CLICK, this.onFlowe);
        this._staticMC.removeEventListener(MouseEvent.CLICK, this.onFlowe);
        if (this._timer) {
            this._timer.stop();
            this._timer.removeEventListener(TimerEvent.TIMER, this.onTimer);
        }
    }
}
}
