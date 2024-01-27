package com.taomee.seer2.app.processor.quest.handler.activity.quest30034 {
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.utils.Timer;

import org.taomee.utils.DisplayUtil;

public class Game30034 {

    private static const HP_EACH_HIT:uint = 2;


    private var _ui:MovieClip;

    private var _hurtState:uint = 1;

    private var _hurtClickCount:uint = 0;

    private var _recoverTimer:Timer;

    private var _clockTimer:Timer;

    private var _info:ContentInfo;

    private var _function:Function;

    public function Game30034(param1:Function) {
        super();
        this._function = param1;
        QueueLoader.load(URLUtil.getActivityAnimation("xegg/game4"), LoadType.SWF, this.onResLoaded);
    }

    private function onResLoaded(param1:ContentInfo = null):void {
        if (this._info == null) {
            this._info = param1;
        }
        this.initUI();
        this.initEventListener();
    }

    private function initUI():void {
        this._ui = new (this._info.domain.getDefinition("SalungBoxingUI"))();
        LayerManager.topLayer.addChild(this._ui);
        this.playMc(2, 1);
    }

    private function initEventListener():void {
        this._recoverTimer = new Timer(400);
        this._recoverTimer.addEventListener(TimerEvent.TIMER, this.timerHandler);
        this._recoverTimer.start();
        LayerManager.topLayer.addEventListener(MouseEvent.CLICK, this.mouseClickHandler);
        this._clockTimer = new Timer(600);
        this._clockTimer.addEventListener(TimerEvent.TIMER, this.clockTick);
        this._clockTimer.start();
    }

    private function clockTick(param1:TimerEvent):void {
        this._ui["timerClock"].nextFrame();
        if (this._ui["timerClock"].currentFrame >= this._ui["timerClock"].totalFrames) {
            this._clockTimer.reset();
            this._clockTimer.removeEventListener(TimerEvent.TIMER, this.clockTick);
            DisplayUtil.removeForParent(this._ui["timerClock"]);
        }
    }

    private function mouseClickHandler(param1:MouseEvent):void {
        ++this._hurtClickCount;
        var _loc2_:uint = this._hurtClickCount / HP_EACH_HIT;
        this._ui["progressbar"].gotoAndStop(_loc2_);
        this._recoverTimer.reset();
        this._recoverTimer.start();
        if (param1.stageX > 480) {
            this._ui["rightFist"].gotoAndPlay(1);
            this.hurtStateHandler(true);
        } else {
            this._ui["leftFist"].gotoAndPlay(1);
            this.hurtStateHandler(false);
        }
        if (this._ui["progressbar"].currentFrame >= this._ui["progressbar"].totalFrames) {
            this.dispose();
        }
    }

    public function dispose():void {
        this._clockTimer.reset();
        this._recoverTimer.reset();
        this._recoverTimer.removeEventListener(TimerEvent.TIMER, this.timerHandler);
        LayerManager.topLayer.removeEventListener(MouseEvent.CLICK, this.mouseClickHandler);
        this._clockTimer.removeEventListener(TimerEvent.TIMER, this.clockTick);
        DisplayUtil.removeForParent(this._ui);
        this._info = null;
        this._clockTimer = null;
        this._recoverTimer = null;
        this._ui = null;
        if (this._function != null) {
            this._function();
            this._function = null;
        }
    }

    private function hurtStateHandler(param1:Boolean):void {
        this._hurtState = this._hurtClickCount / 4;
        if (param1) {
            this.playMc(3, this._hurtState);
        } else {
            this.playMc(1, this._hurtState);
        }
    }

    private function timerHandler(param1:Event):void {
        this._hurtState = this._hurtClickCount / 4;
        this.playMc(2, this._hurtState);
    }

    private function playMc(param1:uint, param2:uint):void {
        var _loc3_:int = 1;
        while (_loc3_ <= 3) {
            this._ui["hurtPeople"]["state" + _loc3_].visible = false;
            _loc3_++;
        }
        this._ui["hurtPeople"]["state" + param1].visible = true;
        this._ui["hurtPeople"]["state" + param1].gotoAndStop(param2);
        if (param1 == 1) {
            this._ui["hurtPeople"]["state4"].visible = true;
            this._ui["hurtPeople"]["state4"].gotoAndPlay(1);
        } else if (param1 == 3) {
            this._ui["hurtPeople"]["state5"].visible = true;
            this._ui["hurtPeople"]["state5"].gotoAndPlay(1);
        } else {
            this._ui["hurtPeople"]["state4"].visible = false;
            this._ui["hurtPeople"]["state4"].stop();
            this._ui["hurtPeople"]["state5"].visible = false;
            this._ui["hurtPeople"]["state5"].stop();
        }
    }
}
}
