package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.processor.activity.getMoneyRideHorseAct.GetMoneyRideHorseAct;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.core.map.MapModel;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;

public class MapProcessor_360 extends TitleMapProcessor {


    private var _getMoneyRideHorseAct:GetMoneyRideHorseAct;

    private var _funnyPet:MovieClip;

    private var _funnyFlower:MovieClip;

    public function MapProcessor_360(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this.initFunnyPet();
        this.initFunnyFlower();
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_157);
        this._getMoneyRideHorseAct = new GetMoneyRideHorseAct(_map);
    }

    private function initFunnyPet():void {
        this._funnyPet = _map.content["funnyPet"];
        this._funnyPet.addEventListener(Event.ENTER_FRAME, this.onFunnyPetEnd);
    }

    private function onFunnyPetEnd(param1:Event):void {
        if (this._funnyPet.currentFrame == this._funnyPet.totalFrames) {
            this._funnyPet.removeEventListener(Event.ENTER_FRAME, this.onFunnyPetEnd);
            if (SwapManager.isSwapNumberMax(87)) {
                SwapManager.entrySwap(87);
            }
        }
    }

    private function clearFunnyPet():void {
        this._funnyPet.removeEventListener(Event.ENTER_FRAME, this.onFunnyPetEnd);
        this._funnyPet = null;
    }

    private function initFunnyFlower():void {
        this._funnyFlower = _map.content["funnyFlower"];
        (this._funnyFlower["hotArea"] as MovieClip).buttonMode = true;
        this._funnyFlower["hotArea"].addEventListener(MouseEvent.CLICK, this.onFunnyFlowerClick);
        this._funnyFlower.addEventListener(Event.ENTER_FRAME, this.onFunnyFlowerEnd);
    }

    private function onFunnyFlowerClick(param1:MouseEvent):void {
        if (this._funnyFlower.currentFrame == 1) {
            this._funnyFlower.nextFrame();
        } else if (this._funnyFlower.currentFrame == 2) {
            this._funnyFlower.play();
            (this._funnyFlower["hotArea"] as MovieClip).buttonMode = false;
            this._funnyFlower["hotArea"].removeEventListener(MouseEvent.CLICK, this.onFunnyFlowerClick);
        }
    }

    private function onFunnyFlowerEnd(param1:Event):void {
        if (this._funnyFlower.currentFrame == this._funnyFlower.totalFrames) {
            this._funnyFlower.removeEventListener(Event.ENTER_FRAME, this.onFunnyFlowerEnd);
            if (SwapManager.isSwapNumberMax(192)) {
                SwapManager.entrySwap(192);
            }
        }
    }

    private function clearFunnyFlower():void {
        this._funnyFlower["hotArea"].removeEventListener(MouseEvent.CLICK, this.onFunnyFlowerClick);
        this._funnyFlower.removeEventListener(Event.ENTER_FRAME, this.onFunnyFlowerEnd);
        this._funnyFlower = null;
    }

    override public function dispose():void {
        this.clearFunnyFlower();
        this.clearFunnyPet();
        if (this._getMoneyRideHorseAct) {
            this._getMoneyRideHorseAct.dispose();
            this._getMoneyRideHorseAct = null;
        }
        super.dispose();
    }
}
}
